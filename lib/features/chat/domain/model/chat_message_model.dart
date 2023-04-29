import 'package:signalr_test_chat/features/chat/utils/chat_entity_type.dart';

/// Модель сообщения чата.
class ChatMessageModel {
  final String? senderUsername;
  final String? message;
  final String? avatarPath;
  final ChatEntityType chatEntityType;
  final String? messageDate;

  /// Конструктор [ChatMessageModel].
  const ChatMessageModel({
    required this.chatEntityType,
    this.messageDate,
    this.senderUsername,
    this.message,
    this.avatarPath,
  });
}
