import 'package:equatable/equatable.dart';

import '../../../shared/models/ai_models.dart';

/// Estados del AI Assistant Bloc
enum AIAssistant_Status { initial, loading, loaded, error }

/// Estado del AIAssistant_Bloc
class AIAssistant_State extends Equatable {
  const AIAssistant_State({
    this.status = AIAssistant_Status.initial,
    this.messages = const [],
    this.errorMessage,
    this.isTyping = false,
  });

  final AIAssistant_Status status;
  final List<Model_ChatMessage> messages;
  final String? errorMessage;
  final bool isTyping;

  AIAssistant_State copyWith({
    AIAssistant_Status? status,
    List<Model_ChatMessage>? messages,
    String? errorMessage,
    bool? isTyping,
  }) {
    return AIAssistant_State(
      status: status ?? this.status,
      messages: messages ?? this.messages,
      errorMessage: errorMessage,
      isTyping: isTyping ?? this.isTyping,
    );
  }

  @override
  List<Object?> get props => [status, messages, errorMessage, isTyping];
}
