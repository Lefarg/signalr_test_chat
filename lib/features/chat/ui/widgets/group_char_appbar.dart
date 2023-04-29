import 'package:flutter/material.dart';

class GroupChatAppBar extends StatelessWidget implements PreferredSize {
  const GroupChatAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      backgroundColor: Colors.white,
      title: Column(
        children: [
          const SizedBox(height: 24.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.star_border,
                color: Colors.black,
              ),
              const SizedBox(width: 24.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  SizedBox(height: 16.0),
                  Text(
                    'Младшая группа',
                    style: TextStyle(color: Colors.black),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    '6 участников',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12.0,
                    ),
                  ),
                  SizedBox(height: 24.0),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget get child => const SizedBox.shrink();

  @override
  Size get preferredSize => const Size.fromHeight(64.0);
}
