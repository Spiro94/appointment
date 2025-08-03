import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ai_models.g.dart';

/// Model for chat messages in AI conversations
@JsonSerializable()
class ChatMessage extends Equatable {
  const ChatMessage({required this.role, required this.content});

  final String role; // 'system', 'user', 'assistant'
  final String content;

  factory ChatMessage.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageFromJson(json);

  Map<String, dynamic> toJson() => _$ChatMessageToJson(this);

  @override
  List<Object> get props => [role, content];
}

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

/// Request model for AI transcription
@JsonSerializable()
class AI_TranscriptionRequest extends Equatable {
  const AI_TranscriptionRequest({
    required this.audioBase64,
    this.language = 'es',
    this.prompt,
  });

  final String audioBase64;
  final String language;
  final String? prompt;

  factory AI_TranscriptionRequest.fromJson(Map<String, dynamic> json) =>
      _$AI_TranscriptionRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AI_TranscriptionRequestToJson(this);

  @override
  List<Object?> get props => [audioBase64, language, prompt];
}

/// Response model for AI transcription
@JsonSerializable()
class AI_TranscriptionResponse extends Equatable {
  const AI_TranscriptionResponse({required this.text, this.language});

  final String text;
  final String? language;

  factory AI_TranscriptionResponse.fromJson(Map<String, dynamic> json) =>
      _$AI_TranscriptionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AI_TranscriptionResponseToJson(this);

  @override
  List<Object?> get props => [text, language];
}

/// Request model for AI vision analysis
@JsonSerializable()
class AI_VisionRequest extends Equatable {
  const AI_VisionRequest({
    required this.imageBase64,
    this.prompt,
    this.maxTokens = 500,
  });

  final String imageBase64;
  final String? prompt;
  final int maxTokens;

  factory AI_VisionRequest.fromJson(Map<String, dynamic> json) =>
      _$AI_VisionRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AI_VisionRequestToJson(this);

  @override
  List<Object?> get props => [imageBase64, prompt, maxTokens];
}

/// Response model for AI vision analysis
@JsonSerializable()
class AI_VisionResponse extends Equatable {
  const AI_VisionResponse({required this.analysis, this.usage, this.model});

  final String analysis;
  final Map<String, dynamic>? usage;
  final String? model;

  factory AI_VisionResponse.fromJson(Map<String, dynamic> json) =>
      _$AI_VisionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AI_VisionResponseToJson(this);

  @override
  List<Object?> get props => [analysis, usage, model];
}

/// Model for structured appointment data
@JsonSerializable()
class AI_AppointmentData extends Equatable {
  const AI_AppointmentData({
    this.doctorName,
    this.specialty,
    this.date,
    this.time,
    this.location,
    this.address,
    this.phone,
    this.appointmentType,
    this.instructions,
    this.authorizationNumber,
    this.notes,
    this.confidence,
  });

  final String? doctorName;
  final String? specialty;
  final String? date; // ISO format YYYY-MM-DD
  final String? time; // 24-hour format HH:MM
  final String? location;
  final String? address;
  final String? phone;
  final String? appointmentType;
  final String? instructions;
  final String? authorizationNumber;
  final String? notes;
  final int? confidence; // 0-100

  factory AI_AppointmentData.fromJson(Map<String, dynamic> json) =>
      _$AI_AppointmentDataFromJson(json);

  Map<String, dynamic> toJson() => _$AI_AppointmentDataToJson(this);

  @override
  List<Object?> get props => [
    doctorName,
    specialty,
    date,
    time,
    location,
    address,
    phone,
    appointmentType,
    instructions,
    authorizationNumber,
    notes,
    confidence,
  ];
}

/// Request model for AI parsing
@JsonSerializable()
class AI_ParseRequest extends Equatable {
  const AI_ParseRequest({
    required this.rawText,
    this.context = 'text',
    this.existingData,
  });

  final String rawText;
  final String context; // 'audio', 'vision', 'text'
  final AI_AppointmentData? existingData;

  factory AI_ParseRequest.fromJson(Map<String, dynamic> json) =>
      _$AI_ParseRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AI_ParseRequestToJson(this);

  @override
  List<Object?> get props => [rawText, context, existingData];
}

/// Response model for AI parsing
@JsonSerializable()
class AI_ParseResponse extends Equatable {
  const AI_ParseResponse({
    required this.appointmentData,
    this.usage,
    this.model,
    this.context,
  });

  final AI_AppointmentData appointmentData;
  final Map<String, dynamic>? usage;
  final String? model;
  final String? context;

  factory AI_ParseResponse.fromJson(Map<String, dynamic> json) =>
      _$AI_ParseResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AI_ParseResponseToJson(this);

  @override
  List<Object?> get props => [appointmentData, usage, model, context];
}

/// Generic AI error response
@JsonSerializable()
class AI_ErrorResponse extends Equatable {
  const AI_ErrorResponse({required this.error});

  final String error;

  factory AI_ErrorResponse.fromJson(Map<String, dynamic> json) =>
      _$AI_ErrorResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AI_ErrorResponseToJson(this);

  @override
  List<Object> get props => [error];
}
