import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chats/Gf01OikouiwP4einMbjm/messages/')
            .snapshots(),
        builder: (ctx, streamSnapshot) {
          if (streamSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final documents = streamSnapshot.data.documents;
          return ListView.builder(
            itemCount: streamSnapshot.data.docs.length,
            itemBuilder: (context, index) => Container(
              padding: EdgeInsets.all(8),
              child: Text(documents[index]['text']),
            ),
          );
        },
      ),
      floatingActionButton:
          FloatingActionButton(child: Icon(Icons.add), onPressed: () {
            FirebaseFirestore.instance
            .collection('chats/Gf01OikouiwP4einMbjm/messages/')
            .add({
              'text': 'This was added by cliecing the button!'
            });
          }),
    );
  }
}
