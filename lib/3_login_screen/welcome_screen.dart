// import 'package:flutter/material.dart';
// import 'package:my_chats_appss/3_login_screen/login.dart';
// import 'package:my_chats_appss/3_login_screen/registration_screen.dart';
// // import 'package:my_chats_appss/Screens/registration_screen.dart';
//
// class Welcome_Screen extends StatelessWidget {
//   const Welcome_Screen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return  Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             ElevatedButton(onPressed: (){
//               Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
//             },
//               child: Text('Log In', style: TextStyle(color: Theme.of(context).colorScheme.onTertiary),),
//               style: ElevatedButton.styleFrom(
//                   backgroundColor: Theme.of(context).colorScheme.onPrimary),),
//             SizedBox(height: 7,),
//             ElevatedButton(onPressed: (){
//               Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterScreen()));
//             },
//               child: Text('Register',style: TextStyle(color: Theme.of(context).colorScheme.onTertiary)),
//               style: ElevatedButton.styleFrom(
//                   backgroundColor: Theme.of(context).colorScheme.onSecondary),),
//           ],
//         ),
//       ),
//     );
//   }
// }
