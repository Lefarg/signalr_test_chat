import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:signalr_test_chat/features/chat/domain/model/chat_message_model.dart';
import 'package:signalr_test_chat/features/chat/ui/screen/chat_wm.dart';
import 'package:signalr_test_chat/features/chat/ui/widgets/chat_messaging_input_textfield.dart';
import 'package:signalr_test_chat/features/chat/ui/widgets/group_chat_appbar.dart';
import 'package:signalr_test_chat/features/chat/utils/chat_entity_type.dart';

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
                  : Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ListView.builder(
                        controller: wm.scrollController,
                        shrinkWrap: true,
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          final currentMessage = messages[index];

                          if (currentMessage.chatEntityType == ChatEntityType.outcomingMessage) {
                            return SizedBox(
                              // height: 100,
                              // width: 200,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  color: Colors.yellow[100],
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(currentMessage.message ?? ''),
                                ),
                              ),
                            );
                          }
                          return Text(
                            currentMessage.message ?? '',
                          );
                        },
                      ),
                    ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
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
