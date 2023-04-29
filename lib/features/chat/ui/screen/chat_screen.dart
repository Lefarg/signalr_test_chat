import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:signalr_test_chat/features/chat/domain/model/chat_message_model.dart';
import 'package:signalr_test_chat/features/chat/ui/screen/chat_wm.dart';
import 'package:signalr_test_chat/features/chat/ui/widgets/chat_messaging_input_textfield.dart';
import 'package:signalr_test_chat/features/chat/ui/widgets/group_chat_appbar.dart';

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
            child: EntityStateNotifierBuilder<List<ChatMessageModel>>(
              listenableEntityState: wm.chatMessagesState,
              builder: (_, messages) => messages == null
                  ? const SizedBox.shrink()
                  : ListView.builder(
                      itemCount: messages.length,
                      itemBuilder: (context, index) => Text(
                        messages[index].message,
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
