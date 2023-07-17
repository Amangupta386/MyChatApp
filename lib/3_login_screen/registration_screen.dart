import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
var _auth = FirebaseAuth.instance;

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formkey = GlobalKey<FormState>();
  late String _enteredEmail = '';
  late String _enteredPassword = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Enter Your Email',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40)
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 5),
                  ),
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
                  onSaved: (value){
                    _enteredEmail = value!;
                  },

                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 7,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    focusColor: Theme
                        .of(context)
                        .colorScheme
                        .primary,
                    border: OutlineInputBorder(

                        borderRadius: BorderRadius.circular(40)
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 10),
                    hintText: 'Enter Your Password',

                  ),
                  textAlign: TextAlign.center,
                  validator: (value) {
                    if (value!.isEmpty || value==null ||value.trim().length <6) {
                      return 'Please Enter Password more than 6 characters';
                    }
                    return null;
                  },
                  onSaved: (value){
                    _enteredPassword = value!;
                  },
                ),
              ),
              SizedBox(height: 20,),
              ElevatedButton(onPressed: () {
                if(_formkey.currentState!.validate()){
                  _formkey.currentState!.save();
                  _auth.createUserWithEmailAndPassword(
                      email: _enteredEmail,
                      password: _enteredPassword);
                }
              },
                child: Text('Register', style: TextStyle(color: Theme
                    .of(context)
                    .colorScheme
                    .onTertiary)),
                style: ElevatedButton.styleFrom(
                    elevation: 3,
                    backgroundColor: Theme
                        .of(context)
                        .colorScheme
                        .onPrimary),),
            ],
          ),
        ),
      ),
    );
  }
}