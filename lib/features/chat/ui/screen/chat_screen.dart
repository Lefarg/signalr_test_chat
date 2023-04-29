import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:signalr_test_chat/features/chat/domain/model/chat_message_model.dart';
import 'package:signalr_test_chat/features/chat/ui/screen/chat_wm.dart';
import 'package:signalr_test_chat/features/chat/ui/widgets/group_char_appbar.dart';

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
            child: SizedBox(
              height: 80,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  autofocus: true,
                  focusNode: wm.textFieldFocus,
                  controller: wm.textEditingController,
                  onSubmitted: wm.onSendClick,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: const Icon(
                        Icons.stacked_bar_chart,
                        color: Colors.black,
                      ),
                      suffixIcon: Material(
                        child: InkWell(
                          customBorder: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                          radius: 20,
                          onTap: () =>
                              wm.onSendClick(wm.textEditingController.text),
                          child: const Icon(
                            Icons.send,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      contentPadding: const EdgeInsets.all(10.0),
                      filled: true,
                      hintStyle: const TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                      hintText: 'Введите сообщение',
                      fillColor: Colors.grey[100]),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
