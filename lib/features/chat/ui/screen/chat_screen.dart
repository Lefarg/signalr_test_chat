import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:signalr_test_chat/features/chat/domain/models/common_chat_message.dart';
import 'package:signalr_test_chat/features/chat/domain/models/incoming_chat_message.dart';
import 'package:signalr_test_chat/features/chat/domain/models/outcoming_chat_message.dart';
import 'package:signalr_test_chat/features/chat/ui/screen/chat_wm.dart';
import 'package:signalr_test_chat/features/chat/ui/widgets/chat_messaging_input_textfield.dart';
import 'package:signalr_test_chat/features/chat/ui/widgets/group_chat_appbar.dart';
import 'package:signalr_test_chat/features/chat/ui/widgets/incoming_chat_message_widget.dart';
import 'package:signalr_test_chat/features/chat/ui/widgets/outcoming_chat_message_widget.dart';

class ChatScreen extends ElementaryWidget<ChatWM> {
  const ChatScreen({Key? key, WidgetModelFactory wmFactory = initChatWMFactory})
      : super(
          wmFactory,
          key: key,
        );
  @override
  Widget build(IChatWM wm) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const GroupChatAppBar(),
      body: Column(
        children: [
          Expanded(
            child: EntityStateNotifierBuilder<List<CommonChatMessage>>(
              listenableEntityState: wm.chatMessagesState,
              loadingBuilder: (_, __) =>
                  const Center(child: RefreshProgressIndicator()),
              errorBuilder: (_, e, __) => Center(
                child: Text(e.toString()),
              ),
              builder: (_, messages) => messages == null
                  ? const SizedBox.shrink()
                  : Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ListView.builder(
                        controller: wm.scrollController,
                        shrinkWrap: true,
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          final currentMessage = messages[index];

                          if (currentMessage is OutcomingChatMessage) {
                            return OutcomingChatMessageWidget(
                                currentMessage: currentMessage);
                          }

                          if (currentMessage is IncomingChatMessage) {
                            return IncomingChatMessageWidget(
                                currentMessage: currentMessage);
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                    ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: ChatMessagingInputTextField(
              focusNode: wm.textFieldFocus,
              textEditingController: wm.textEditingController,
              onSendClick: wm.onSendClick,
            ),
          ),
        ],
      ),
    );
  }
}
