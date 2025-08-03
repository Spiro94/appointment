import { serve } from "https://deno.land/std@0.166.0/http/server.ts";

const corsHeaders = {
    "Access-Control-Allow-Origin": "*",
    "Access-Control-Allow-Headers":
        "authorization, x-client-info, apikey, content-type",
};

interface ParseRequest {
    rawText: string;
    context?: "audio" | "vision" | "text";
    existingData?: Partial<AppointmentData>;
}

interface AppointmentData {
    doctorName?: string;
    specialty?: string;
    date?: string; // ISO format YYYY-MM-DD
    time?: string; // 24-hour format HH:MM
    location?: string;
    address?: string;
    phone?: string;
    appointmentType?: string;
    instructions?: string;
    authorizationNumber?: string;
    notes?: string;
    confidence?: number;
}

serve(async (req: Request) => {
    // Handle CORS preflight requests
    if (req.method === "OPTIONS") {
        return new Response("ok", { headers: corsHeaders });
    }

    try {
        const { rawText, context = "text", existingData } = await req
            .json() as ParseRequest;

        // Validate request
        if (!rawText || rawText.trim().length === 0) {
            return new Response(
                JSON.stringify({
                    error: "rawText is required and cannot be empty",
                }),
                {
                    status: 400,
                    headers: {
                        ...corsHeaders,
                        "Content-Type": "application/json",
                    },
                },
            );
        }

        // Get OpenAI API key from environment
        const openAIApiKey = Deno.env.get("OPENAI_API_KEY");
        if (!openAIApiKey) {
            console.error("OPENAI_API_KEY not found in environment variables");
            return new Response(
                JSON.stringify({ error: "OpenAI API key not configured" }),
                {
                    status: 500,
                    headers: {
                        ...corsHeaders,
                        "Content-Type": "application/json",
                    },
                },
            );
        }

        // Prepare parsing prompt
        const parsingPrompt = `
      Eres un asistente especializado en extraer información de citas médicas en Colombia.
      
      Analiza el siguiente texto y extrae ÚNICAMENTE la información relacionada con citas médicas.
      
      Texto a analizar:
      "${rawText}"
      
      ${
            existingData
                ? `Información existente que puedes combinar o corregir: ${
                    JSON.stringify(existingData)
                }`
                : ""
        }
      
      Instrucciones:
      1. Extrae y normaliza la información de la cita médica
      2. Convierte fechas al formato ISO YYYY-MM-DD (asume año actual si no está especificado)
      3. Convierte horas al formato 24 horas HH:MM
      4. Normaliza nombres de especialidades médicas
      5. Asigna un nivel de confianza del 0-100% a cada campo extraído
      6. Si no encuentras información específica, no inventes datos
      
      Responde ÚNICAMENTE con un JSON válido en este formato exacto:
      {
        "doctorName": "string o null",
        "specialty": "string o null", 
        "date": "YYYY-MM-DD o null",
        "time": "HH:MM o null",
        "location": "string o null",
        "address": "string o null", 
        "phone": "string o null",
        "appointmentType": "string o null",
        "instructions": "string o null",
        "authorizationNumber": "string o null",
        "notes": "string o null",
        "confidence": número del 0-100
      }
      
      NO incluyas explicaciones adicionales, solo el JSON.
    `;

        // Make request to OpenAI
        const openAIResponse = await fetch(
            "https://api.openai.com/v1/chat/completions",
            {
                method: "POST",
                headers: {
                    "Authorization": `Bearer ${openAIApiKey}`,
                    "Content-Type": "application/json",
                },
                body: JSON.stringify({
                    model: "gpt-4o",
                    messages: [
                        {
                            role: "system",
                            content:
                                "Eres un experto en extraer información estructurada de textos médicos. Siempre respondes con JSON válido.",
                        },
                        {
                            role: "user",
                            content: parsingPrompt,
                        },
                    ],
                    max_tokens: 800,
                    temperature: 0.1, // Low temperature for consistency
                    response_format: { type: "json_object" },
                }),
            },
        );

        if (!openAIResponse.ok) {
            const errorText = await openAIResponse.text();
            console.error("OpenAI Parse API error:", errorText);
            return new Response(
                JSON.stringify({ error: "Failed to parse appointment data" }),
                {
                    status: openAIResponse.status,
                    headers: {
                        ...corsHeaders,
                        "Content-Type": "application/json",
                    },
                },
            );
        }

        const parseData = await openAIResponse.json();

        // Extract and parse the response
        const parsedContent = parseData.choices?.[0]?.message?.content;

        if (!parsedContent) {
            return new Response(
                JSON.stringify({ error: "No parsing result generated" }),
                {
                    status: 500,
                    headers: {
                        ...corsHeaders,
                        "Content-Type": "application/json",
                    },
                },
            );
        }

        let appointmentData: AppointmentData;
        try {
            appointmentData = JSON.parse(parsedContent);
        } catch (jsonError) {
            console.error("Failed to parse JSON response:", jsonError);
            return new Response(
                JSON.stringify({ error: "Invalid JSON response from AI" }),
                {
                    status: 500,
                    headers: {
                        ...corsHeaders,
                        "Content-Type": "application/json",
                    },
                },
            );
        }

        // Additional validation and cleanup
        if (appointmentData.date) {
            // Validate date format
            const dateRegex = /^\d{4}-\d{2}-\d{2}$/;
            if (!dateRegex.test(appointmentData.date)) {
                appointmentData.date = undefined;
            }
        }

        if (appointmentData.time) {
            // Validate time format
            const timeRegex = /^\d{2}:\d{2}$/;
            if (!timeRegex.test(appointmentData.time)) {
                appointmentData.time = undefined;
            }
        }

        // Return the parsed appointment data
        return new Response(
            JSON.stringify({
                appointmentData,
                usage: parseData.usage,
                model: parseData.model,
                context,
            }),
            {
                headers: { ...corsHeaders, "Content-Type": "application/json" },
            },
        );
    } catch (error) {
        console.error("Error in ai-parse function:", error);
        return new Response(
            JSON.stringify({ error: "Internal server error" }),
            {
                status: 500,
                headers: { ...corsHeaders, "Content-Type": "application/json" },
            },
        );
    }
});
