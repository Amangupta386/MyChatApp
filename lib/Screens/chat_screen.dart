import 'package:flutter_svg_image/flutter_svg_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_chats_appss/Screens/bubble_screen.dart';
import 'package:my_chats_appss/Screens/new_message.dart';

var _auth = FirebaseAuth.instance;
CollectionReference users = FirebaseFirestore.instance.collection('users');
FirebaseFirestore db = FirebaseFirestore.instance;

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String _enteredMessage='';
  Map<String,dynamic>? user;
  var _userImageUrl ;
  void onMessageInput(String messageValue) {
    setState(() {
      _enteredMessage = messageValue;
    });
  }

  void onSendMessage(){
    try {
      final docRef = db.collection("users").doc(_auth.currentUser!.uid);
      docRef.get().then(
            (DocumentSnapshot doc) {
          var data = doc.data() as Map<String, dynamic>;
          // print(data['imageUrl']);
          final chat = <String, dynamic>{
            "createdAt": Timestamp.now(),
            "text": _enteredMessage,
            "userId": _auth.currentUser!.uid,
            "userImage": data['imageUrl'],
            "userName": data['userName'],
          };
          db.collection('chats').doc().set(chat);

        },
        onError: (e) => print("Error getting document: $e"),
      );

    }
    catch(e){
      print('${e}');
    }
  }

  Future _getUser()async{
    var currentUserUid = FirebaseAuth.instance.currentUser!.uid;
    try{
      var docRef = await FirebaseFirestore.instance.collection('users').doc(currentUserUid).get();
      user = docRef.data();
    }
    catch (e){
      throw Exception('Something went wrong!');
    }
    return user;
  }

  @override
  void initState(){
    super.initState();
    _getUser().then((data){
      setState(() {
        if(data != null){
          _userImageUrl=data['imageUrl'];
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    // print(_enteredMessage);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 80,
        title: Padding(
          padding: const EdgeInsets.all(15.0),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            child: CircleAvatar(
              radius: 25,
              backgroundImage:(_userImageUrl != null)?
              NetworkImage(_userImageUrl):
              AssetImage('assets/images/chat.png') as ImageProvider,
            ),
            radius: 30,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.onSurface,
        actions: [
          Icon(
            Icons.menu,
            color: Colors.white,
            size: 28,
          ),
          SizedBox(
            width: 10,
          ),
          Icon(
            Icons.expand_more,
            color: Colors.white,
            size: 28,
          ),
          SizedBox(
            width: 10,
          ),
          IconButton(onPressed: (){
            // Provider.of<AuthServices>(context,listen: false).onSignout();
            _auth.signOut();
          }, icon: Icon(Icons.logout,color: Theme.of(context).colorScheme.onSecondary,))
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ClipPath(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 10,
              color: Theme.of(context).colorScheme.onSurface,
              child: ListTile(
                  leading: Image(
                     width: MediaQuery.of(context).size.width/10,
                    fit: BoxFit.contain,
                    image: SvgImage.asset(
                      'assets/images/hand.svg',
                    ),
                  ),
                  title: Text('We are online',
                      style: TextStyle(color: Theme.of(context).colorScheme.onSecondary))),
            ),
            clipper: Clipper(),
          ),
          BubbleMesssage(),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: NewMessage(onMessageInput),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.onSurface,
        onPressed: () {
          onSendMessage();
        },
        child: Icon(Icons.send),
      ),
    );
  }
}

//Costom CLipper class with Path
class Clipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height);
    path.quadraticBezierTo(
        size.width / 4, size.height - 40, size.width / 2, size.height - 20);
    path.quadraticBezierTo(
        3 / 4 * size.width, size.height, size.width, size.height - 30);
    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(Clipper oldClipper) => false;
}