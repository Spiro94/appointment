import { serve } from "https://deno.land/std@0.166.0/http/server.ts";

const corsHeaders = {
    "Access-Control-Allow-Origin": "*",
    "Access-Control-Allow-Headers":
        "authorization, x-client-info, apikey, content-type",
};

interface VisionRequest {
    imageBase64: string;
    prompt?: string;
    maxTokens?: number;
}

serve(async (req: Request) => {
    // Handle CORS preflight requests
    if (req.method === "OPTIONS") {
        return new Response("ok", { headers: corsHeaders });
    }

    try {
        const { imageBase64, prompt, maxTokens = 500 } = await req
            .json() as VisionRequest;

        // Validate request
        if (!imageBase64) {
            return new Response(
                JSON.stringify({ error: "imageBase64 is required" }),
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

        // Prepare vision prompt for medical appointments
        const visionPrompt = prompt || `
      Analiza esta imagen que puede contener información sobre una cita médica.
      Extrae TODA la información relevante que veas:
      
      - Nombre del doctor o especialista
      - Especialidad médica
      - Fecha de la cita (formato DD/MM/AAAA)
      - Hora de la cita (formato 12 horas con AM/PM)
      - Lugar (clínica, hospital, consultorio)
      - Dirección completa
      - Teléfono de contacto
      - Tipo de consulta o procedimiento
      - Instrucciones especiales (ayuno, medicamentos, etc.)
      - Número de autorización o cita
      - Cualquier otra información médica relevante
      
      Si es una orden médica, también extrae:
      - Exámenes solicitados
      - Medicamentos recetados
      - Diagnósticos
      
      Responde en español colombiano y usa formato JSON estructurado.
      Si no puedes leer algo claramente, indícalo como "texto_no_legible".
    `;

        // Make request to OpenAI GPT-4o Vision
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
                            role: "user",
                            content: [
                                {
                                    type: "text",
                                    text: visionPrompt,
                                },
                                {
                                    type: "image_url",
                                    image_url: {
                                        url: `data:image/jpeg;base64,${imageBase64}`,
                                        detail: "high",
                                    },
                                },
                            ],
                        },
                    ],
                    max_tokens: maxTokens,
                    temperature: 0.1, // Low temperature for accuracy
                }),
            },
        );

        if (!openAIResponse.ok) {
            const errorText = await openAIResponse.text();
            console.error("OpenAI Vision API error:", errorText);
            return new Response(
                JSON.stringify({ error: "Failed to analyze image" }),
                {
                    status: openAIResponse.status,
                    headers: {
                        ...corsHeaders,
                        "Content-Type": "application/json",
                    },
                },
            );
        }

        const visionData = await openAIResponse.json();

        // Extract the response
        const analysisResult = visionData.choices?.[0]?.message?.content;

        if (!analysisResult) {
            return new Response(
                JSON.stringify({ error: "No analysis result generated" }),
                {
                    status: 500,
                    headers: {
                        ...corsHeaders,
                        "Content-Type": "application/json",
                    },
                },
            );
        }

        // Return the analysis
        return new Response(
            JSON.stringify({
                analysis: analysisResult,
                usage: visionData.usage,
                model: visionData.model,
            }),
            {
                headers: { ...corsHeaders, "Content-Type": "application/json" },
            },
        );
    } catch (error) {
        console.error("Error in ai-vision function:", error);
        return new Response(
            JSON.stringify({ error: "Internal server error" }),
            {
                status: 500,
                headers: { ...corsHeaders, "Content-Type": "application/json" },
            },
        );
    }
});
