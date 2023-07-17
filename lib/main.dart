import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:my_chats_appss/Screens/auth_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:my_chats_appss/Screens/chat_screen.dart';
import 'package:my_chats_appss/Screens/splash_screen.dart';
import 'package:my_chats_appss/Theme/theme.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseMessaging.instance.getInitialMessage();
  runApp(MyApp());
}

final ThemeData _themeColor = LightTheme.buildTheme();

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _messageText = '';

  void messageText(String messageValue) {
    setState(() {
      _messageText = messageValue;
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    bool expression = false;

    return MaterialApp(
      title: 'Flutter Demo',
      theme: _themeColor,
    home: StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, AsyncSnapshot snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
          return SplashScreen();
        }
        if(snapshot.hasData){
          print('${snapshot.hasData} snapshot data');
          return ChatScreen();
        }
        if(snapshot.hasError){
          ScaffoldMessenger.
          of(context).
          showSnackBar(SnackBar(
              content:
              Text('error')));
        }
        return AuthScreen();
      },
    )
    // AuthScreen(),
    );
  }
}
