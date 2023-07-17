// import 'package:chat_app/screens/chat_screen.dart';
// import 'package:chat_app/widgets/login_buttons.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:my_chats_appss/Screens/chat_screen.dart';
import 'package:my_chats_appss/widgets/user_imagepicker.dart';
// import 'package:image_picker/image_picker.dart';
FirebaseFirestore db = FirebaseFirestore.
instance;
var _auth = FirebaseAuth.instance;

// typedef void ImageUri (var imagePath);

class AuthScreen extends StatefulWidget {
  AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  String mtoken = '';
  var _imageUriPath;
  final _formkey = GlobalKey<FormState>();
  String _email='';
  String _password='';
  UserCredential? _userCredentials;
  bool isLogin =false;
  bool _isAuthenticating = false;
  String _userName = '' ;
  DateTime? _createdAt;
  String text = '';

  void getToken() async{
    await FirebaseMessaging.instance.getToken().then(
        (token){
          setState(() {
            mtoken = token!;
            print("my token is $mtoken");
          });
          saveToken(token!);
        }
    );
  }

  void saveToken(String token)async{
    await FirebaseFirestore.instance.collection('UserTokens').doc("user1").set({
      'token' : token,
    });
  }

  void requestPermission() async{
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
        announcement: false,
        badge:  true,
        carPlay: false,
        criticalAlert: false,
      provisional: false,
      sound: true,
    );
    if(settings.authorizationStatus == AuthorizationStatus.authorized){
      print('user granted permission');
    } else if(settings.authorizationStatus == AuthorizationStatus.provisional){
      print('user granted provisional permission');
    } else{
      print('User declined or has not accepted permission');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    requestPermission();
    getToken();
  }

  void onImageClickHandler(File imageUri){
    setState(() {
      _imageUriPath = imageUri;
    });
  }

  void onSubmit() async{
    if(_formkey.currentState!.validate() || _imageUriPath != null){
      _formkey.currentState!.save();
      try{
        setState(() {
          _isAuthenticating = true;
        });
        if (isLogin)
        {
          _userCredentials = await _auth.signInWithEmailAndPassword(
              email: _email, password: _password);
        }
        else{
          _userCredentials= await _auth
              .createUserWithEmailAndPassword(
              email: _email,
              password: _password);

          final storageRef =
          await FirebaseStorage.instance.ref().
          child("user_images").
          child('${_userCredentials!.user!.uid}.jpg');

          await storageRef.putFile(_imageUriPath);
          final imageUrl =
          await storageRef.getDownloadURL();

          final user = <String, String>{
            "userName": _userName,
            "imageUrl": imageUrl,
            "userEmail": _email,
          };
          db
              .collection("users")
              .doc('${_userCredentials!.user!.uid}')
              .set(user);

        }
        setState(() {
          _isAuthenticating = false;
        });
      }
      on FirebaseAuthException catch (e) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Login'),
                content: Text('${e.message}'),
                actions: [
                  ElevatedButton(
                      onPressed: () {
                        _formkey.currentState!.reset();
                      },
                      child: Text('Ok')),
                ],
              );
            }   );
      }
    }
    else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    // print(widget.messageText);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Image(
                height: 200,
                width: 200,
                image: AssetImage('assets/images/chat.png'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Form(
                      key: _formkey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if(!isLogin)UserImagePicker(imageUriPath: onImageClickHandler,),
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                                labelText: 'Email Address',
                                labelStyle: TextStyle(fontSize: 20)),
                            validator: (value) {
                              String p =
                                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                              RegExp regExp = RegExp(p);
                              if (regExp.hasMatch(value!) || value == null) {
                                return null;
                              } else if (value.isEmpty) {
                                return 'Please Enter Email';
                              }
                              return 'Please enter valid Email';
                            },
                            onSaved:(value) {
                              _email = value!;
                            },
                          ),
                          SizedBox(height: 15,),
                          if(!isLogin)
                            TextFormField(decoration: const InputDecoration(
                              labelText: 'Username',
                              labelStyle: TextStyle(fontSize: 20)),
                              onSaved: (value){
                                _userName = value!;
                            },),
                          SizedBox(height: 15,),

                          TextFormField(
                            keyboardType: TextInputType.text,
                            obscuringCharacter: '*',
                            obscureText: true,
                            decoration: const InputDecoration(
                              labelText: 'Password',
                              labelStyle: TextStyle(fontSize: 20),
                            ),
                            validator: (value) {
                              if (value!.isEmpty ||
                                  value == null ||
                                  value.trim().length < 6) {
                                return 'Please Enter Password more than 6 characters';
                              }
                              return null;
                            },
                            onSaved:(value) {
                              _password = value!;
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          if(_isAuthenticating)
                              CircularProgressIndicator(),
                          if(!_isAuthenticating)
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                              ),
                              onPressed: onSubmit,
                              child: (!isLogin)?Text('Sign Up') : Text('Login')),
                          if(!_isAuthenticating)
                          TextButton(
                              onPressed: () {
                                _formkey.currentState!.reset();
                                setState(() {
                                  isLogin = !isLogin;
                                });
                              },
                              child: (!isLogin)
                                  ? Text('I already have an account')
                                  : Text('Create an account'))
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
