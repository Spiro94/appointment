import { serve } from "https://deno.land/std@0.166.0/http/server.ts";

const corsHeaders = {
    "Access-Control-Allow-Origin": "*",
    "Access-Control-Allow-Headers":
        "authorization, x-client-info, apikey, content-type",
};

interface TranscriptionRequest {
    audioBase64: string;
    language?: string;
    prompt?: string;
}

serve(async (req: Request) => {
    // Handle CORS preflight requests
    if (req.method === "OPTIONS") {
        return new Response("ok", { headers: corsHeaders });
    }

    try {
        const { audioBase64, language = "es", prompt } = await req
            .json() as TranscriptionRequest;

        // Validate request
        if (!audioBase64) {
            return new Response(
                JSON.stringify({ error: "audioBase64 is required" }),
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

        // Convert base64 to blob
        const audioBytes = Uint8Array.from(
            atob(audioBase64),
            (c) => c.charCodeAt(0),
        );
        const audioBlob = new Blob([audioBytes], { type: "audio/wav" });

        // Prepare form data
        const formData = new FormData();
        formData.append("file", audioBlob, "audio.wav");
        formData.append("model", "whisper-1");
        formData.append("language", language);

        // Add context prompt for medical appointments in Colombian Spanish
        const contextPrompt = prompt ||
            "Esta es una grabación sobre citas médicas en Colombia. " +
                "Puede incluir nombres de doctores, especialidades médicas, fechas, horas, " +
                "direcciones de clínicas u hospitales, y síntomas o condiciones médicas.";
        formData.append("prompt", contextPrompt);

        // Make request to OpenAI Whisper
        const openAIResponse = await fetch(
            "https://api.openai.com/v1/audio/transcriptions",
            {
                method: "POST",
                headers: {
                    "Authorization": `Bearer ${openAIApiKey}`,
                },
                body: formData,
            },
        );

        if (!openAIResponse.ok) {
            const errorText = await openAIResponse.text();
            console.error("OpenAI Whisper API error:", errorText);
            return new Response(
                JSON.stringify({ error: "Failed to transcribe audio" }),
                {
                    status: openAIResponse.status,
                    headers: {
                        ...corsHeaders,
                        "Content-Type": "application/json",
                    },
                },
            );
        }

        const transcriptionData = await openAIResponse.json();

        // Return the transcription
        return new Response(
            JSON.stringify({
                text: transcriptionData.text,
                language: transcriptionData.language || language,
            }),
            {
                headers: { ...corsHeaders, "Content-Type": "application/json" },
            },
        );
    } catch (error) {
        console.error("Error in ai-transcription function:", error);
        return new Response(
            JSON.stringify({ error: "Internal server error" }),
            {
                status: 500,
                headers: { ...corsHeaders, "Content-Type": "application/json" },
            },
        );
    }
});
