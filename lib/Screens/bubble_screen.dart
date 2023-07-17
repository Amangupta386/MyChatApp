import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
var _auth = FirebaseAuth.instance;


class BubbleMesssage extends StatefulWidget {
  const BubbleMesssage({Key? key}) : super(key: key);

  @override
  State<BubbleMesssage> createState() => _BubbleMesssageState();
}

class _BubbleMesssageState extends State<BubbleMesssage> {

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chats')
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            var data=snapshot.data!.docs;
            return ListView.builder(
              reverse: true,
              itemCount: data.length,
              itemBuilder: (context, index){
                    bool isMe = (_auth.currentUser?.uid != data[index]['userId']);
                    return Padding(
                      padding: const EdgeInsets.all(13.0),
                      child: Row(
                        textDirection: isMe?TextDirection.ltr:TextDirection.rtl,
                        children: [
                          CircleAvatar(
                          radius: 20,
                          child: Image.network(
                              data[index]['userImage']) ,
                        ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 15,
                          ),
                        Container(
                          padding: EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color:isMe? Theme.of(context).colorScheme.onTertiary:Theme.of(context).colorScheme.primary,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(18),
                              bottomLeft: Radius.circular(18),
                              bottomRight: Radius.circular(18),
                            ),
                          ),
                          child: Text(data[index]['text'],
                            style: TextStyle(color:Theme.of(context).colorScheme.onSecondary,), ),),
                      ]
                ),
                    );
                  });
          }
        },
      ),
    );
  }
}