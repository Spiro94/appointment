// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Model_ChatMessage _$Model_ChatMessageFromJson(Map<String, dynamic> json) =>
    Model_ChatMessage(
      role: json['role'] as String,
      content: json['content'] as String,
    );

Map<String, dynamic> _$Model_ChatMessageToJson(Model_ChatMessage instance) =>
    <String, dynamic>{'role': instance.role, 'content': instance.content};

Model_AI_ChatRequest _$Model_AI_ChatRequestFromJson(
  Map<String, dynamic> json,
) => Model_AI_ChatRequest(
  messages:
      (json['messages'] as List<dynamic>)
          .map((e) => Model_ChatMessage.fromJson(e as Map<String, dynamic>))
          .toList(),
  maxTokens: (json['maxTokens'] as num?)?.toInt() ?? 150,
  model: json['model'] as String? ?? 'gpt-3.5-turbo',
  temperature: (json['temperature'] as num?)?.toDouble() ?? 0.7,
);

Map<String, dynamic> _$Model_AI_ChatRequestToJson(
  Model_AI_ChatRequest instance,
) => <String, dynamic>{
  'messages': instance.messages,
  'maxTokens': instance.maxTokens,
  'model': instance.model,
  'temperature': instance.temperature,
};

Model_AI_ChatResponse _$Model_AI_ChatResponseFromJson(
  Map<String, dynamic> json,
) => Model_AI_ChatResponse(
  message: json['message'] as String,
  usage: json['usage'] as Map<String, dynamic>?,
  model: json['model'] as String?,
);

Map<String, dynamic> _$Model_AI_ChatResponseToJson(
  Model_AI_ChatResponse instance,
) => <String, dynamic>{
  'message': instance.message,
  'usage': instance.usage,
  'model': instance.model,
};

Model_AI_TranscriptionRequest _$Model_AI_TranscriptionRequestFromJson(
  Map<String, dynamic> json,
) => Model_AI_TranscriptionRequest(
  audioBase64: json['audioBase64'] as String,
  language: json['language'] as String? ?? 'es',
  prompt: json['prompt'] as String?,
);

Map<String, dynamic> _$Model_AI_TranscriptionRequestToJson(
  Model_AI_TranscriptionRequest instance,
) => <String, dynamic>{
  'audioBase64': instance.audioBase64,
  'language': instance.language,
  'prompt': instance.prompt,
};

Model_AI_TranscriptionResponse _$Model_AI_TranscriptionResponseFromJson(
  Map<String, dynamic> json,
) => Model_AI_TranscriptionResponse(
  text: json['text'] as String,
  language: json['language'] as String?,
);

Map<String, dynamic> _$Model_AI_TranscriptionResponseToJson(
  Model_AI_TranscriptionResponse instance,
) => <String, dynamic>{'text': instance.text, 'language': instance.language};

Model_AI_VisionRequest _$Model_AI_VisionRequestFromJson(
  Map<String, dynamic> json,
) => Model_AI_VisionRequest(
  imageBase64: json['imageBase64'] as String,
  prompt: json['prompt'] as String?,
  maxTokens: (json['maxTokens'] as num?)?.toInt() ?? 500,
);

Map<String, dynamic> _$Model_AI_VisionRequestToJson(
  Model_AI_VisionRequest instance,
) => <String, dynamic>{
  'imageBase64': instance.imageBase64,
  'prompt': instance.prompt,
  'maxTokens': instance.maxTokens,
};

Model_AI_VisionResponse _$Model_AI_VisionResponseFromJson(
  Map<String, dynamic> json,
) => Model_AI_VisionResponse(
  analysis: json['analysis'] as String,
  usage: json['usage'] as Map<String, dynamic>?,
  model: json['model'] as String?,
);

Map<String, dynamic> _$Model_AI_VisionResponseToJson(
  Model_AI_VisionResponse instance,
) => <String, dynamic>{
  'analysis': instance.analysis,
  'usage': instance.usage,
  'model': instance.model,
};

Model_AI_AppointmentData _$Model_AI_AppointmentDataFromJson(
  Map<String, dynamic> json,
) => Model_AI_AppointmentData(
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

Map<String, dynamic> _$Model_AI_AppointmentDataToJson(
  Model_AI_AppointmentData instance,
) => <String, dynamic>{
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

Model_AI_ParseRequest _$Model_AI_ParseRequestFromJson(
  Map<String, dynamic> json,
) => Model_AI_ParseRequest(
  rawText: json['rawText'] as String,
  context: json['context'] as String? ?? 'text',
  existingData:
      json['existingData'] == null
          ? null
          : Model_AI_AppointmentData.fromJson(
            json['existingData'] as Map<String, dynamic>,
          ),
);

Map<String, dynamic> _$Model_AI_ParseRequestToJson(
  Model_AI_ParseRequest instance,
) => <String, dynamic>{
  'rawText': instance.rawText,
  'context': instance.context,
  'existingData': instance.existingData,
};

Model_AI_ParseResponse _$Model_AI_ParseResponseFromJson(
  Map<String, dynamic> json,
) => Model_AI_ParseResponse(
  appointmentData: Model_AI_AppointmentData.fromJson(
    json['appointmentData'] as Map<String, dynamic>,
  ),
  usage: json['usage'] as Map<String, dynamic>?,
  model: json['model'] as String?,
  context: json['context'] as String?,
);

Map<String, dynamic> _$Model_AI_ParseResponseToJson(
  Model_AI_ParseResponse instance,
) => <String, dynamic>{
  'appointmentData': instance.appointmentData,
  'usage': instance.usage,
  'model': instance.model,
  'context': instance.context,
};

Model_AI_ErrorResponse _$Model_AI_ErrorResponseFromJson(
  Map<String, dynamic> json,
) => Model_AI_ErrorResponse(error: json['error'] as String);

Map<String, dynamic> _$Model_AI_ErrorResponseToJson(
  Model_AI_ErrorResponse instance,
) => <String, dynamic>{'error': instance.error};
