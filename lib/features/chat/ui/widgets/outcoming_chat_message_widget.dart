import 'package:flutter/material.dart';
import 'package:signalr_test_chat/features/chat/domain/models/outcoming_chat_message.dart';

class OutcomingChatMessageWidget extends StatelessWidget {
  final OutcomingChatMessage currentMessage;

  const OutcomingChatMessageWidget({required this.currentMessage, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.yellow[100],
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(currentMessage.message),
                    const SizedBox(height: 16.0),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Text(
                          '17:32',
                          style: TextStyle(
                            fontWeight: FontWeight.w200,
                            fontSize: 10.0,
                          ),
                        ),
                        Icon(Icons.abc),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
