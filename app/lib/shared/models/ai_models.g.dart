// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatMessage _$ChatMessageFromJson(Map<String, dynamic> json) => ChatMessage(
  role: json['role'] as String,
  content: json['content'] as String,
);

Map<String, dynamic> _$ChatMessageToJson(ChatMessage instance) =>
    <String, dynamic>{'role': instance.role, 'content': instance.content};

AI_ChatRequest _$AI_ChatRequestFromJson(Map<String, dynamic> json) =>
    AI_ChatRequest(
      messages:
          (json['messages'] as List<dynamic>)
              .map((e) => ChatMessage.fromJson(e as Map<String, dynamic>))
              .toList(),
      maxTokens: (json['maxTokens'] as num?)?.toInt() ?? 150,
      model: json['model'] as String? ?? 'gpt-3.5-turbo',
      temperature: (json['temperature'] as num?)?.toDouble() ?? 0.7,
    );

Map<String, dynamic> _$AI_ChatRequestToJson(AI_ChatRequest instance) =>
    <String, dynamic>{
      'messages': instance.messages,
      'maxTokens': instance.maxTokens,
      'model': instance.model,
      'temperature': instance.temperature,
    };

AI_ChatResponse _$AI_ChatResponseFromJson(Map<String, dynamic> json) =>
    AI_ChatResponse(
      message: json['message'] as String,
      usage: json['usage'] as Map<String, dynamic>?,
      model: json['model'] as String?,
    );

Map<String, dynamic> _$AI_ChatResponseToJson(AI_ChatResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'usage': instance.usage,
      'model': instance.model,
    };

AI_TranscriptionRequest _$AI_TranscriptionRequestFromJson(
  Map<String, dynamic> json,
) => AI_TranscriptionRequest(
  audioBase64: json['audioBase64'] as String,
  language: json['language'] as String? ?? 'es',
  prompt: json['prompt'] as String?,
);

Map<String, dynamic> _$AI_TranscriptionRequestToJson(
  AI_TranscriptionRequest instance,
) => <String, dynamic>{
  'audioBase64': instance.audioBase64,
  'language': instance.language,
  'prompt': instance.prompt,
};

AI_TranscriptionResponse _$AI_TranscriptionResponseFromJson(
  Map<String, dynamic> json,
) => AI_TranscriptionResponse(
  text: json['text'] as String,
  language: json['language'] as String?,
);

Map<String, dynamic> _$AI_TranscriptionResponseToJson(
  AI_TranscriptionResponse instance,
) => <String, dynamic>{'text': instance.text, 'language': instance.language};

AI_VisionRequest _$AI_VisionRequestFromJson(Map<String, dynamic> json) =>
    AI_VisionRequest(
      imageBase64: json['imageBase64'] as String,
      prompt: json['prompt'] as String?,
      maxTokens: (json['maxTokens'] as num?)?.toInt() ?? 500,
    );

Map<String, dynamic> _$AI_VisionRequestToJson(AI_VisionRequest instance) =>
    <String, dynamic>{
      'imageBase64': instance.imageBase64,
      'prompt': instance.prompt,
      'maxTokens': instance.maxTokens,
    };

AI_VisionResponse _$AI_VisionResponseFromJson(Map<String, dynamic> json) =>
    AI_VisionResponse(
      analysis: json['analysis'] as String,
      usage: json['usage'] as Map<String, dynamic>?,
      model: json['model'] as String?,
    );

Map<String, dynamic> _$AI_VisionResponseToJson(AI_VisionResponse instance) =>
    <String, dynamic>{
      'analysis': instance.analysis,
      'usage': instance.usage,
      'model': instance.model,
    };

AI_AppointmentData _$AI_AppointmentDataFromJson(Map<String, dynamic> json) =>
    AI_AppointmentData(
      doctorName: json['doctorName'] as String?,
      specialty: json['specialty'] as String?,
      date: json['date'] as String?,
      time: json['time'] as String?,
      location: json['location'] as String?,
      address: json['address'] as String?,
      phone: json['phone'] as String?,
      appointmentType: json['appointmentType'] as String?,
      instructions: json['instructions'] as String?,
      authorizationNumber: json['authorizationNumber'] as String?,
      notes: json['notes'] as String?,
      confidence: (json['confidence'] as num?)?.toInt(),
    );

Map<String, dynamic> _$AI_AppointmentDataToJson(AI_AppointmentData instance) =>
    <String, dynamic>{
      'doctorName': instance.doctorName,
      'specialty': instance.specialty,
      'date': instance.date,
      'time': instance.time,
      'location': instance.location,
      'address': instance.address,
      'phone': instance.phone,
      'appointmentType': instance.appointmentType,
      'instructions': instance.instructions,
      'authorizationNumber': instance.authorizationNumber,
      'notes': instance.notes,
      'confidence': instance.confidence,
    };

AI_ParseRequest _$AI_ParseRequestFromJson(Map<String, dynamic> json) =>
    AI_ParseRequest(
      rawText: json['rawText'] as String,
      context: json['context'] as String? ?? 'text',
      existingData:
          json['existingData'] == null
              ? null
              : AI_AppointmentData.fromJson(
                json['existingData'] as Map<String, dynamic>,
              ),
    );

Map<String, dynamic> _$AI_ParseRequestToJson(AI_ParseRequest instance) =>
    <String, dynamic>{
      'rawText': instance.rawText,
      'context': instance.context,
      'existingData': instance.existingData,
    };

AI_ParseResponse _$AI_ParseResponseFromJson(Map<String, dynamic> json) =>
    AI_ParseResponse(
      appointmentData: AI_AppointmentData.fromJson(
        json['appointmentData'] as Map<String, dynamic>,
      ),
      usage: json['usage'] as Map<String, dynamic>?,
      model: json['model'] as String?,
      context: json['context'] as String?,
    );

Map<String, dynamic> _$AI_ParseResponseToJson(AI_ParseResponse instance) =>
    <String, dynamic>{
      'appointmentData': instance.appointmentData,
      'usage': instance.usage,
      'model': instance.model,
      'context': instance.context,
    };

AI_ErrorResponse _$AI_ErrorResponseFromJson(Map<String, dynamic> json) =>
    AI_ErrorResponse(error: json['error'] as String);

Map<String, dynamic> _$AI_ErrorResponseToJson(AI_ErrorResponse instance) =>
    <String, dynamic>{'error': instance.error};
