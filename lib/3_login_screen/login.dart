// import 'dart:io';
// // import 'package:chat_app/screens/chat_screen.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:my_chats_appss/Screens/auth_screen.dart';
//
// var _auth = FirebaseAuth.instance;
//
// class Login extends StatefulWidget {
//   const Login({Key? key}) : super(key: key);
//
//   @override
//   State<Login> createState() => _LoginState();
// }
//
// class _LoginState extends State<Login> {
//   final _formkey = GlobalKey<FormState>();
//   String _email = '';
//   String _password = '';
//   bool isloading=false;
//
//   void onLogin() async {
//     if (_formkey.currentState!.validate()) {
//       _formkey.currentState!.save();
//         try {
//           setState(() {
//             isloading = true;
//           });
//         UserCredential currentUser = await _auth.signInWithEmailAndPassword(
//             email: _email, password: _password);
//         setState(() {
//           isloading = false;
//         });
//         print('$currentUser CURRENTUSER');
//         Navigator.push(
//             context, MaterialPageRoute(builder: (context) => AuthScreen()));
//         } on FirebaseAuthException catch (e) {
//         // Platform.isIOS?showCupertinoAlert(e):showAlert(e);
//         showAlert(e);
//       }
//     }
//     else{
//       CircularProgressIndicator();
//     }
//   }
//
//
//   Future<void> showAlert(e) {
//     return showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text('Login'),
//             content: Text('${e.message}'),
//             actions: [
//               ElevatedButton(
//                   onPressed: () {
//                     _formkey.currentState!.reset();
//                     Navigator.pop(context);
//                   },
//                   child: Text('Ok'))
//             ],
//           );
//         });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: (isloading)?Center(child: CircularProgressIndicator()):Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Image(
//             height: 200,
//             width: 200,
//             image: AssetImage('assets/images/chat.png'),
//           ),
//           Form(
//               key: _formkey,
//               child: Padding(
//                 padding: const EdgeInsets.all(15.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: [
//                     TextFormField(
//                       textAlign: TextAlign.center,
//                       decoration: InputDecoration(
//                           hintText: 'Enter Your Email',
//                           border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(30.0))),
//                       validator: (value) {
//                         String p =
//                             r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
//                         RegExp regExp = RegExp(p);
//                         if (regExp.hasMatch(value!) || value == null) {
//                           return null;
//                         } else if (value.isEmpty) {
//                           return 'Please Enter Email';
//                         }
//                         return 'Please enter valid Email';
//                       },
//                       onSaved: (value) {
//                         _email = value!;
//                       },
//                     ),
//                     SizedBox(
//                       height: 10,
//                     ),
//                     TextFormField(
//                       textAlign: TextAlign.center,
//                       decoration: InputDecoration(
//                           hintText: 'Enter Your Password',
//                           border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(30.0))),
//                       validator: (value) {
//                         if (value!.isEmpty ||
//                             value == null ||
//                             value.trim().length < 6) {
//                           return 'Please Enter Password more than 6 characters';
//                         }
//                         return null;
//                       },
//                       onSaved: (value) {
//                         _password = value!;
//                       },
//                     ),
//                     SizedBox(
//                       height: 25,
//                     ),
//                     ElevatedButton(
//                       onPressed: (){
//                         onLogin();
//                         }
//                         ,
//                       child: Text('Log In'),
//                       style: ElevatedButton.styleFrom(
//                           backgroundColor:
//                           Theme.of(context).colorScheme.onPrimary,
//                           foregroundColor:
//                           Theme.of(context).colorScheme.onSecondary),
//                     ),
//                   ],
//                 ),
//               )),
//         ],
//       ),
//     );
//   }
// }