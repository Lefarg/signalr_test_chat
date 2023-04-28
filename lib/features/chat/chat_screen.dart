import 'package:elementary/elementary.dart';
import 'package:flutter/cupertino.dart';
import 'package:signalr_test_chat/features/chat/chat_wm.dart';

class ChatScreen extends ElementaryWidget<ChatWM>{
  const ChatScreen({Key? key, WidgetModelFactory wmFactory = initChatWMFactory}):super(_, key: key,);
  @override
  Widget build(IChatWM wm) {
  return Container();
}