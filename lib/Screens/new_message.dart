import 'package:flutter/material.dart';
import 'package:my_chats_appss/Screens/auth_screen.dart';

class NewMessage extends StatefulWidget {
  Function (String) message;
  NewMessage(this.message,{Key? key }) : super(key: key);

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  @override
  Widget build(BuildContext context) {
    // if(widget.reset){
    //   _controller.clear();
    // }
    return TextField(
      decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Enter your message...'
      ),
      onChanged: (value){
        widget.message(value);
      },
    );
  }
}
