/// Модель сообщения чата.
class ChatMessageModel {
  final String senderUsername;
  final String message;

  /// Конструктор [ChatMessageModel].
  const ChatMessageModel({
    required this.senderUsername,
    required this.message,
  });
}
