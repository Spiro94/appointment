import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'chat_message.dart';

part 'ai_chat_models.g.dart';

/// Request model for AI chat
@JsonSerializable()
class AI_ChatRequest extends Equatable {
  const AI_ChatRequest({
    required this.messages,
    this.maxTokens = 150,
    this.model = 'gpt-3.5-turbo',
    this.temperature = 0.7,
  });

  final List<ChatMessage> messages;
  final int maxTokens;
  final String model;
  final double temperature;

  factory AI_ChatRequest.fromJson(Map<String, dynamic> json) =>
      _$AI_ChatRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AI_ChatRequestToJson(this);

  @override
  List<Object> get props => [messages, maxTokens, model, temperature];
}

/// Response model for AI chat
@JsonSerializable()
class AI_ChatResponse extends Equatable {
  const AI_ChatResponse({required this.message, this.usage, this.model});

  final String message;
  final Map<String, dynamic>? usage;
  final String? model;

  factory AI_ChatResponse.fromJson(Map<String, dynamic> json) =>
      _$AI_ChatResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AI_ChatResponseToJson(this);

  @override
  List<Object?> get props => [message, usage, model];
}
