import 'package:chat_app/widgets/chat_message.dart';
import 'package:chat_app/widgets/new_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chating.."),
        actions: [
          IconButton(
            onPressed:(){
              FirebaseAuth.instance.signOut();
            }
           ,icon: Icon(
            Icons.exit_to_app_rounded,
            color: Theme.of(context).colorScheme.primary,
           ))
        ],
      ),
      body: Column( 
        children: const[
          Expanded(
       child:  ChatMessages(),
                  ),
        NewMessage(),
      ],
      )
    );
    
  }
}