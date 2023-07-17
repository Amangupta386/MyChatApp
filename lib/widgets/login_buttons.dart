import 'package:flutter/material.dart';
import 'package:my_chats_appss/3_login_screen/registration_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginButtons extends StatefulWidget {
  final VoidCallback onSignUp;
  final VoidCallback onResetHandler;
  final VoidCallback onLogin;
  const LoginButtons({Key? key,
    required this.onSignUp,
    required this.onResetHandler,
    required this.onLogin,
    }) : super(key: key);

  @override
  State<LoginButtons> createState() => _LoginButtonsState();
}

class _LoginButtonsState extends State<LoginButtons> {
  bool isToggle = false;

  void onToggle(){
    setState(() {
      isToggle = !isToggle;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10,),
        (isToggle)?
        ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            ),
            onPressed: (){
              onToggle();
              widget.onSignUp();
            },
            child: Text('Sign Up') ):
        ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            ),
            onPressed: (){
              onToggle();
              widget.onLogin();
            },
            child:  Text('Login')),

    SizedBox(height: 10,),
    TextButton(onPressed: (){
      onToggle();
      widget.onResetHandler();

    },
        child:(isToggle)?
        Text('I already have an account') :
        Text('Create an account'))
      ],
    );
  }
}
