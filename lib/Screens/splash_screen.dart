import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(image: AssetImage('assets/images/chat.png'),
                width: MediaQuery.of(context).size.width/5,
                height: MediaQuery.of(context).size.height/5,),
              Text('loading...'),
            ],
          ),
        ),
      ),
    );
  }
}
