import 'package:elementary/elementary.dart';
import 'package:signalr_test_chat/features/chat/domain/models/common_chat_message.dart';
import 'package:signalr_test_chat/features/chat/domain/services/chat_messaging_service.dart';

class ChatModel extends ElementaryModel {
  final chatMessagingService = ChatMessagingService();

  EntityStateNotifier<List<CommonChatMessage>> get chatMessagesListState =>
      chatMessagingService.chatMessagesListState;

  ChatModel();

  @override
  void init() {
    super.init();

    chatMessagingService.chatInit();
  }

  void onSendMessage(String message) {
    chatMessagingService.sendMessage(message);
  }
}
