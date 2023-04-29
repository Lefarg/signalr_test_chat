import 'package:flutter/material.dart';

class ChatMessagingInputTextField extends StatelessWidget {
  final FocusNode focusNode;
  final TextEditingController textEditingController;
  final Function(String) onSendClick;

  const ChatMessagingInputTextField({
    required this.focusNode,
    required this.textEditingController,
    required this.onSendClick,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          autofocus: true,
          focusNode: focusNode,
          controller: textEditingController,
          onSubmitted: onSendClick,
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
                  onTap: () => onSendClick(textEditingController.text),
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
    );
  }
}
