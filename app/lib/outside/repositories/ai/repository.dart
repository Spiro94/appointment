import 'dart:convert';
import 'dart:typed_data';

import '../../../shared/models/ai_models.dart';
import '../../client_providers/supabase/client_provider.dart';
import '../../effect_providers/all.dart';
import '../base.dart';

/// Repository for handling AI operations through Supabase Edge Functions
class AI_Repository extends Repository_Base {
  AI_Repository({
    required this.supabaseClientProvider,
    required this.effectProviders,
  });

  final Supabase_ClientProvider supabaseClientProvider;
  final EffectProviders_All effectProviders;

  @override
  Future<void> init() async {
    log.fine('AI Repository initialized');
  }

  /// Send a chat message and get AI response
  Future<Model_AI_ChatResponse> sendChatMessage({
    required List<Model_ChatMessage> messages,
    int maxTokens = 150,
    String model = 'gpt-3.5-turbo',
    double temperature = 0.7,
  }) async {
    try {
      log.info('Sending chat message with ${messages.length} messages');

      final request = Model_AI_ChatRequest(
        messages: messages,
        maxTokens: maxTokens,
        model: model,
        temperature: temperature,
      );

      final response = await supabaseClientProvider.client.functions.invoke(
        'ai-chat',
        body: request.toJson(),
      );

      if (response.data == null) {
        throw Exception('No response data from ai-chat function');
      }

      // Check for error in response
      if (response.data['error'] != null) {
        throw Exception('AI Chat error: ${response.data['error']}');
      }

      log.fine('Received chat response successfully');
      return Model_AI_ChatResponse.fromJson(
        response.data as Map<String, dynamic>,
      );
    } catch (e) {
      log.severe('Error in sendChatMessage: $e');
      rethrow;
    }
  }

  /// Transcribe audio to text using Whisper
  Future<Model_AI_TranscriptionResponse> transcribeAudio({
    required Uint8List audioBytes,
    String language = 'es',
    String? prompt,
  }) async {
    try {
      log.info('Transcribing audio of ${audioBytes.length} bytes');

      final audioBase64 = base64Encode(audioBytes);
      final request = Model_AI_TranscriptionRequest(
        audioBase64: audioBase64,
        language: language,
        prompt: prompt,
      );

      final response = await supabaseClientProvider.client.functions.invoke(
        'ai-transcription',
        body: request.toJson(),
      );

      if (response.data == null) {
        throw Exception('No response data from ai-transcription function');
      }

      // Check for error in response
      if (response.data['error'] != null) {
        throw Exception('AI Transcription error: ${response.data['error']}');
      }

      log.fine('Audio transcribed successfully');
      return Model_AI_TranscriptionResponse.fromJson(
        response.data as Map<String, dynamic>,
      );
    } catch (e) {
      log.severe('Error in transcribeAudio: $e');
      rethrow;
    }
  }

  /// Analyze image content using GPT-4o Vision
  Future<Model_AI_VisionResponse> analyzeImage({
    required Uint8List imageBytes,
    String? prompt,
    int maxTokens = 500,
  }) async {
    try {
      log.info('Analyzing image of ${imageBytes.length} bytes');

      final imageBase64 = base64Encode(imageBytes);
      final request = Model_AI_VisionRequest(
        imageBase64: imageBase64,
        prompt: prompt,
        maxTokens: maxTokens,
      );

      final response = await supabaseClientProvider.client.functions.invoke(
        'ai-vision',
        body: request.toJson(),
      );

      if (response.data == null) {
        throw Exception('No response data from ai-vision function');
      }

      // Check for error in response
      if (response.data['error'] != null) {
        throw Exception('AI Vision error: ${response.data['error']}');
      }

      log.fine('Image analyzed successfully');
      return Model_AI_VisionResponse.fromJson(
        response.data as Map<String, dynamic>,
      );
    } catch (e) {
      log.severe('Error in analyzeImage: $e');
      rethrow;
    }
  }

  /// Parse raw text into structured appointment data
  Future<Model_AI_ParseResponse> parseAppointmentData({
    required String rawText,
    String context = 'text',
    Model_AI_AppointmentData? existingData,
  }) async {
    try {
      log.info('Parsing appointment data from $context input');

      final request = Model_AI_ParseRequest(
        rawText: rawText,
        context: context,
        existingData: existingData,
      );

      final response = await supabaseClientProvider.client.functions.invoke(
        'ai-parse',
        body: request.toJson(),
      );

      if (response.data == null) {
        throw Exception('No response data from ai-parse function');
      }

      // Check for error in response
      if (response.data['error'] != null) {
        throw Exception('AI Parse error: ${response.data['error']}');
      }

      log.fine('Appointment data parsed successfully');
      return Model_AI_ParseResponse.fromJson(
        response.data as Map<String, dynamic>,
      );
    } catch (e) {
      log.severe('Error in parseAppointmentData: $e');
      rethrow;
    }
  }

  /// Complete workflow: Audio -> Transcription -> Parsing
  Future<Model_AI_AppointmentData> processAudioToAppointment({
    required Uint8List audioBytes,
    String language = 'es',
    Model_AI_AppointmentData? existingData,
  }) async {
    try {
      log.info('Processing audio to appointment data');

      // Step 1: Transcribe audio
      final transcriptionResponse = await transcribeAudio(
        audioBytes: audioBytes,
        language: language,
        prompt: 'Esta es una grabación sobre una cita médica en Colombia.',
      );

      // Step 2: Parse transcription to structured data
      final parseResponse = await parseAppointmentData(
        rawText: transcriptionResponse.text,
        context: 'audio',
        existingData: existingData,
      );

      log.fine('Audio processed to appointment data successfully');
      return parseResponse.appointmentData;
    } catch (e) {
      log.severe('Error in processAudioToAppointment: $e');
      rethrow;
    }
  }

  /// Complete workflow: Image -> Vision Analysis -> Parsing
  Future<Model_AI_AppointmentData> processImageToAppointment({
    required Uint8List imageBytes,
    Model_AI_AppointmentData? existingData,
  }) async {
    try {
      log.info('Processing image to appointment data');

      // Step 1: Analyze image with vision AI
      final visionResponse = await analyzeImage(
        imageBytes: imageBytes,
        maxTokens: 800,
      );

      // Step 2: Parse vision analysis to structured data
      final parseResponse = await parseAppointmentData(
        rawText: visionResponse.analysis,
        context: 'vision',
        existingData: existingData,
      );

      log.fine('Image processed to appointment data successfully');
      return parseResponse.appointmentData;
    } catch (e) {
      log.severe('Error in processImageToAppointment: $e');
      rethrow;
    }
  }
}
