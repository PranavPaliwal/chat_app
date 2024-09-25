import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({super.key});

  @override
  State<NewMessage> createState() {
    return _NewMessageState();
  }
}

class _NewMessageState extends State<NewMessage> {

  final _messageController=TextEditingController();

  @override
  void dispose(){
    _messageController.dispose();
    super.dispose();
  }

  void _submitMessage()async{
    final enteredMessage=_messageController.text;

    if(enteredMessage.trim().isEmpty){
      return;
    }
    FocusScope.of(context).unfocus();
    _messageController.clear();

    final user=FirebaseAuth.instance.currentUser!;

    final userData=await FirebaseFirestore.instance.collection('user').doc(user.uid).get();
    

    FirebaseFirestore.instance
    .collection('Chat')
    .add({
      'text': enteredMessage,
      'createdAt': Timestamp.now(),
      'userId':user.uid,
      'userName':userData.data()!['username'], 
      'userImage':userData.data()!['imageUrl'],
    });

  }



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:const EdgeInsets.only(left: 15, right: 1, bottom: 14),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              textCapitalization: TextCapitalization.sentences,
              enableSuggestions: true,
              decoration:const InputDecoration(
                labelText: 'Send a Message...'
              ),
            ),
         ),
            IconButton( icon: const Icon(
              Icons.send_rounded,
            ),
             onPressed: _submitMessage,
             ),
        ],
      ),
      );
  }
}