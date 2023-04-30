import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:signalr_test_chat/features/chat/domain/models/common_chat_message.dart';
import 'package:signalr_test_chat/features/chat/domain/models/incoming_chat_message.dart';
import 'package:signalr_test_chat/features/chat/domain/models/outcoming_chat_message.dart';
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
            child: EntityStateNotifierBuilder<List<CommonChatMessage>>(
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

                          if (currentMessage is OutcomingChatMessage) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                DecoratedBox(
                                  decoration: BoxDecoration(
                                    color: Colors.yellow[100],
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(currentMessage.message),
                                  ),
                                ),
                              ],
                            );
                          }
                          if (currentMessage is IncomingChatMessage) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Column(
                                  children: [
                                    DecoratedBox(
                                      decoration: BoxDecoration(
                                        color: Colors.grey[100],
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(currentMessage.message),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          }
                          return const Text('');
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
