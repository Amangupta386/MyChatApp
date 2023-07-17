// import 'package:chat_app/constants/firebase_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_chats_appss/constants/firebase_constant.dart';

class ChatProvider {
  Map<String, dynamic>? imageData;
  final _auth = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;

  Future<Map<String, dynamic>?> getUser() async {
    final docRef =
    await db
        .collection(FirestoreConstants.users)
        .doc(_auth.currentUser!.uid)
        .get();
    Map<String, dynamic>? user = docRef.data();

    return user;
  }

  Future<void> setUserChat(String enteredMessage) async {
    Map<String, dynamic>? user = await getUser();
    if (user != null) {

      final chat = <String, dynamic>{
        FirestoreConstants.createdAt: Timestamp.now(),
        FirestoreConstants.text: enteredMessage,
        FirestoreConstants.userId: _auth.currentUser!.uid,
        FirestoreConstants.userImage: user[FirestoreConstants.imageUrl],
        FirestoreConstants.userName: user[FirestoreConstants.userName],
      };

      await db.collection(FirestoreConstants.chats).doc().set(chat);
    } else {
      return;
    }

  }
}

