import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ai_models.g.dart';

/// Model for chat messages in AI conversations
@JsonSerializable()
class Model_ChatMessage extends Equatable {
  const Model_ChatMessage({required this.role, required this.content});

  final String role; // 'system', 'user', 'assistant'
  final String content;

  factory Model_ChatMessage.fromJson(Map<String, dynamic> json) =>
      _$Model_ChatMessageFromJson(json);

  Map<String, dynamic> toJson() => _$Model_ChatMessageToJson(this);

  @override
  List<Object> get props => [role, content];
}

/// Request model for AI chat
@JsonSerializable()
class Model_AI_ChatRequest extends Equatable {
  const Model_AI_ChatRequest({
    required this.messages,
    this.maxTokens = 150,
    this.model = 'gpt-3.5-turbo',
    this.temperature = 0.7,
  });

  final List<Model_ChatMessage> messages;
  final int maxTokens;
  final String model;
  final double temperature;

  factory Model_AI_ChatRequest.fromJson(Map<String, dynamic> json) =>
      _$Model_AI_ChatRequestFromJson(json);

  Map<String, dynamic> toJson() => _$Model_AI_ChatRequestToJson(this);

  @override
  List<Object> get props => [messages, maxTokens, model, temperature];
}

/// Response model for AI chat
@JsonSerializable()
class Model_AI_ChatResponse extends Equatable {
  const Model_AI_ChatResponse({required this.message, this.usage, this.model});

  final String message;
  final Map<String, dynamic>? usage;
  final String? model;

  factory Model_AI_ChatResponse.fromJson(Map<String, dynamic> json) =>
      _$Model_AI_ChatResponseFromJson(json);

  Map<String, dynamic> toJson() => _$Model_AI_ChatResponseToJson(this);

  @override
  List<Object?> get props => [message, usage, model];
}

/// Request model for AI transcription
@JsonSerializable()
class Model_AI_TranscriptionRequest extends Equatable {
  const Model_AI_TranscriptionRequest({
    required this.audioBase64,
    this.language = 'es',
    this.prompt,
  });

  final String audioBase64;
  final String language;
  final String? prompt;

  factory Model_AI_TranscriptionRequest.fromJson(Map<String, dynamic> json) =>
      _$Model_AI_TranscriptionRequestFromJson(json);

  Map<String, dynamic> toJson() => _$Model_AI_TranscriptionRequestToJson(this);

  @override
  List<Object?> get props => [audioBase64, language, prompt];
}

/// Response model for AI transcription
@JsonSerializable()
class Model_AI_TranscriptionResponse extends Equatable {
  const Model_AI_TranscriptionResponse({required this.text, this.language});

  final String text;
  final String? language;

  factory Model_AI_TranscriptionResponse.fromJson(Map<String, dynamic> json) =>
      _$Model_AI_TranscriptionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$Model_AI_TranscriptionResponseToJson(this);

  @override
  List<Object?> get props => [text, language];
}

/// Request model for AI vision analysis
@JsonSerializable()
class Model_AI_VisionRequest extends Equatable {
  const Model_AI_VisionRequest({
    required this.imageBase64,
    this.prompt,
    this.maxTokens = 500,
  });

  final String imageBase64;
  final String? prompt;
  final int maxTokens;

  factory Model_AI_VisionRequest.fromJson(Map<String, dynamic> json) =>
      _$Model_AI_VisionRequestFromJson(json);

  Map<String, dynamic> toJson() => _$Model_AI_VisionRequestToJson(this);

  @override
  List<Object?> get props => [imageBase64, prompt, maxTokens];
}

/// Response model for AI vision analysis
@JsonSerializable()
class Model_AI_VisionResponse extends Equatable {
  const Model_AI_VisionResponse({
    required this.analysis,
    this.usage,
    this.model,
  });

  final String analysis;
  final Map<String, dynamic>? usage;
  final String? model;

  factory Model_AI_VisionResponse.fromJson(Map<String, dynamic> json) =>
      _$Model_AI_VisionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$Model_AI_VisionResponseToJson(this);

  @override
  List<Object?> get props => [analysis, usage, model];
}

/// Model for structured appointment data
@JsonSerializable()
class Model_AI_AppointmentData extends Equatable {
  const Model_AI_AppointmentData({
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

  factory Model_AI_AppointmentData.fromJson(Map<String, dynamic> json) =>
      _$Model_AI_AppointmentDataFromJson(json);

  Map<String, dynamic> toJson() => _$Model_AI_AppointmentDataToJson(this);

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
class Model_AI_ParseRequest extends Equatable {
  const Model_AI_ParseRequest({
    required this.rawText,
    this.context = 'text',
    this.existingData,
  });

  final String rawText;
  final String context; // 'audio', 'vision', 'text'
  final Model_AI_AppointmentData? existingData;

  factory Model_AI_ParseRequest.fromJson(Map<String, dynamic> json) =>
      _$Model_AI_ParseRequestFromJson(json);

  Map<String, dynamic> toJson() => _$Model_AI_ParseRequestToJson(this);

  @override
  List<Object?> get props => [rawText, context, existingData];
}

/// Response model for AI parsing
@JsonSerializable()
class Model_AI_ParseResponse extends Equatable {
  const Model_AI_ParseResponse({
    required this.appointmentData,
    this.usage,
    this.model,
    this.context,
  });

  final Model_AI_AppointmentData appointmentData;
  final Map<String, dynamic>? usage;
  final String? model;
  final String? context;

  factory Model_AI_ParseResponse.fromJson(Map<String, dynamic> json) =>
      _$Model_AI_ParseResponseFromJson(json);

  Map<String, dynamic> toJson() => _$Model_AI_ParseResponseToJson(this);

  @override
  List<Object?> get props => [appointmentData, usage, model, context];
}

/// Generic AI error response
@JsonSerializable()
class Model_AI_ErrorResponse extends Equatable {
  const Model_AI_ErrorResponse({required this.error});

  final String error;

  factory Model_AI_ErrorResponse.fromJson(Map<String, dynamic> json) =>
      _$Model_AI_ErrorResponseFromJson(json);

  Map<String, dynamic> toJson() => _$Model_AI_ErrorResponseToJson(this);

  @override
  List<Object> get props => [error];
}
