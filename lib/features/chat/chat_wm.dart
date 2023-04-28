import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:signalr_test_chat/features/chat/chat_model.dart';
import 'package:signalr_test_chat/features/chat/chat_screen.dart';

/// Factory for [ChatWM].
ChatWM initChatWMFactory(
  BuildContext context,
) {
  final model = ChatModel();

  return ChatWM(model);
}

class ChatWM extends WidgetModel<ChatScreen, ChatModel>
    implements IChatWM {
  /// Create an instance [ChatWM].
  ChatWM(ChatModel model) : super(model);
}

abstract class IChatWM {}
