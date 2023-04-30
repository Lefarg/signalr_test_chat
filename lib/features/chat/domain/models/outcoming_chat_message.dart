import 'package:signalr_test_chat/features/chat/domain/models/common_chat_message.dart';

class OutcomingChatMessage extends CommonChatMessage {
  final String name;
  final String message;

  OutcomingChatMessage({required this.name, required this.message});
}
