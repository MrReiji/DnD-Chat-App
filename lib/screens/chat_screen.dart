import 'package:flutter/material.dart';

import 'package:dnd_chat_app/widgets/app_AppBar.dart';
import 'package:dnd_chat_app/widgets/chat/chat_messages.dart';
import 'package:dnd_chat_app/widgets/chat/new_messages.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({required this.id, super.key});

  final String id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(),
      body: Column(
        children: [
          Expanded(
            child: ChatMessages(id: id),
          ),
          NewMessage(id: id),
        ],
      ),
    );
  }
}
