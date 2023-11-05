import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/app_AppBar.dart';
import '../widgets/chat/chat_messages.dart';
import '../widgets/chat/new_messages.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({required this.id, super.key});

  final String id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: App_AppBar(),
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
