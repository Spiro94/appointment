// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_chat_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

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
