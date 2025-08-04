import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'chat_message.g.dart';

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
