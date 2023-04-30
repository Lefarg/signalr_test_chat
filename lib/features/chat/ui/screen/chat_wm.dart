// ignore_for_file: depend_on_referenced_packages

import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:signalr_test_chat/features/chat/domain/models/common_chat_message.dart';
import 'package:signalr_test_chat/features/chat/ui/screen/chat_model.dart';
import 'package:signalr_test_chat/features/chat/ui/screen/chat_screen.dart';

/// Factory for [ChatWM].
ChatWM initChatWMFactory(
  BuildContext context,
) {
  final model = ChatModel();

  return ChatWM(model);
}

class ChatWM extends WidgetModel<ChatScreen, ChatModel> implements IChatWM {
  final _textFieldFocus = FocusNode();
  final _textEditingController = TextEditingController();
  final _scrollController = ScrollController();

  @override
  FocusNode get textFieldFocus => _textFieldFocus;

  @override
  TextEditingController get textEditingController => _textEditingController;

  @override
  EntityStateNotifier<List<CommonChatMessage>> get chatMessagesState => model.chatMessagesListState;

  @override
  ScrollController get scrollController => _scrollController;

  /// Create an instance [ChatWM].
  ChatWM(ChatModel model) : super(model);

  @override
  void onSendClick(String message) {
    if (message.isEmpty) return;
    model.onSendClick(message);
    _textEditingController.clear();
    _textFieldFocus.requestFocus();
  }

  @override
  void initWidgetModel() {
    super.initWidgetModel();

    chatMessagesState.addListener(() {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        if (_scrollController.hasClients) {
          // TODO(Deyew): требуется проверка и отладка - при скролле вверх и получении сообщения почему-то скроллит не до низа последнего виджета
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            curve: Curves.easeOut,
            duration: const Duration(milliseconds: 300),
          );
        }
      });
    });
  }
}

abstract class IChatWM {
  /// Focus node for text field.
  FocusNode get textFieldFocus;

  /// Scroll controller for messages list.
  ScrollController get scrollController;

  /// Entity state for chat messages.
  EntityStateNotifier<List<CommonChatMessage>> get chatMessagesState;

  /// Text controller for text field.
  TextEditingController get textEditingController;

  /// Send message to server.
  void onSendClick(String message);
}

// class HttpOverrideCertificateVerificationInDev extends HttpOverrides {
//   @override
//   HttpClient createHttpClient(SecurityContext? context) {
//     return super.createHttpClient(context)
//       ..badCertificateCallback =
//           (X509Certificate cert, String host, int port) => true;
//   }
// }

// void _httpClientCreateCallback(http.Client httpClient) {
//   HttpOverrides.global = HttpOverrideCertificateVerificationInDev();
// }
