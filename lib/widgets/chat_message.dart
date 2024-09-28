import 'package:chat_app/widgets/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class ChatMessages extends StatelessWidget {
  const ChatMessages ({super.key});

  @override
  Widget build(BuildContext context) {


    final authenticatedUser= FirebaseAuth.instance.currentUser!;

    return StreamBuilder(
      stream: FirebaseFirestore
      .instance.collection('Chat')
      .orderBy('createdAt',
      descending: true)
      .snapshots(),
       builder: (ctx, chatSnapShots){
        if(chatSnapShots.connectionState == ConnectionState.waiting){
        return const Center(
          child: CircularProgressIndicator(),
          );
        }
        if(!chatSnapShots.hasData || chatSnapShots.data!.docs.isEmpty){
          return const Center(
          child:  Text('No new Messages'),
          );
        }

        if(chatSnapShots.hasError){

           return const Center(
          child:  Text('Oops! Something went Wrong'),
          );

        }

        final loadedMessages=chatSnapShots.data!.docs;
        return ListView
        .builder(
        padding: const EdgeInsets.only(
        bottom:40,
        left: 13,
        right: 13,
        ),
        reverse: true,
        itemCount: loadedMessages
        .length,itemBuilder: (ctx,index){
          final chatMessage=loadedMessages[index].data();
          final nextChatMessage= index+1<loadedMessages.length?loadedMessages[index+1].data():null;
          final currentMessageUserId=chatMessage['userId'];
          final nextMessageuserId=nextChatMessage!=null?nextChatMessage['userId']:null;
          final nextUserIsSame=currentMessageUserId==nextMessageuserId;

          if(nextUserIsSame){
            return MessageBubble.next(
              message: chatMessage['text'],
              isMe:
               authenticatedUser.uid==currentMessageUserId
               );
            } else  {

              return MessageBubble.first(
                userImage: chatMessage['userImage'],
                username: chatMessage['userName'],
                message: chatMessage['text'],
                isMe: authenticatedUser.uid==currentMessageUserId
            );
          }
        },
        );
      }
    );
  }
}