import 'package:signalr_test_chat/features/chat/domain/models/common_chat_message.dart';

class IncomingChatMessage extends CommonChatMessage {
  final String name;
  final String message;

  IncomingChatMessage({required this.name, required this.message});
}
