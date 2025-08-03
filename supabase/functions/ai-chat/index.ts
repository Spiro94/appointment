import { serve } from "https://deno.land/std@0.166.0/http/server.ts";

const corsHeaders = {
    "Access-Control-Allow-Origin": "*",
    "Access-Control-Allow-Headers":
        "authorization, x-client-info, apikey, content-type",
};

interface ChatMessage {
    role: "system" | "user" | "assistant";
    content: string;
}

interface ChatRequest {
    messages: ChatMessage[];
    maxTokens?: number;
    model?: string;
    temperature?: number;
}

serve(async (req: Request) => {
    // Handle CORS preflight requests
    if (req.method === "OPTIONS") {
        return new Response("ok", { headers: corsHeaders });
    }

    try {
        const {
            messages,
            maxTokens = 150,
            model = "gpt-3.5-turbo",
            temperature = 0.7,
        } = await req.json() as ChatRequest;

        // Validate request
        if (!messages || !Array.isArray(messages) || messages.length === 0) {
            return new Response(
                JSON.stringify({
                    error: "Messages array is required and cannot be empty",
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

        // Prepare system prompt for appointment context (Spanish for Colombian users)
        const systemMessage: ChatMessage = {
            role: "system",
            content:
                `Eres un asistente de IA para una aplicación de gestión de citas médicas en Colombia. 
      Ayudas especialmente a:
      - Personas adultas mayores con poca experiencia digital
      - Cuidadores y familiares que gestionan citas
      
      Debes ayudar con:
      - Programar citas médicas
      - Gestionar calendarios
      - Proporcionar recordatorios de citas
      - Responder preguntas sobre citas programadas
      - Interpretar información médica básica
      
      Siempre sé amable, profesional, claro y usa lenguaje simple. 
      Usa formato de fecha DD/MM/AAAA y hora en formato 12 horas (AM/PM).
      Zona horaria: America/Bogotá.
      Si te preguntan sobre temas no relacionados con citas, redirige amablemente la conversación.`,
        };

        // Combine system message with user messages
        const fullMessages = [systemMessage, ...messages];

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
                    model,
                    messages: fullMessages,
                    max_tokens: maxTokens,
                    temperature,
                }),
            },
        );

        if (!openAIResponse.ok) {
            const errorText = await openAIResponse.text();
            console.error("OpenAI API error:", errorText);
            return new Response(
                JSON.stringify({ error: "Failed to get response from OpenAI" }),
                {
                    status: openAIResponse.status,
                    headers: {
                        ...corsHeaders,
                        "Content-Type": "application/json",
                    },
                },
            );
        }

        const openAIData = await openAIResponse.json();

        // Extract the response
        const assistantMessage = openAIData.choices?.[0]?.message?.content;

        if (!assistantMessage) {
            return new Response(
                JSON.stringify({ error: "No response generated" }),
                {
                    status: 500,
                    headers: {
                        ...corsHeaders,
                        "Content-Type": "application/json",
                    },
                },
            );
        }

        // Return the response
        return new Response(
            JSON.stringify({
                message: assistantMessage,
                usage: openAIData.usage,
                model: openAIData.model,
            }),
            {
                headers: { ...corsHeaders, "Content-Type": "application/json" },
            },
        );
    } catch (error) {
        console.error("Error in ai-chat function:", error);
        return new Response(
            JSON.stringify({ error: "Internal server error" }),
            {
                status: 500,
                headers: { ...corsHeaders, "Content-Type": "application/json" },
            },
        );
    }
});
