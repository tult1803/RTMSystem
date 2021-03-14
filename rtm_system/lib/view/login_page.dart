
import 'package:flutter/material.dart';
import 'package:rtm_system/presenter/check_login.dart';
import 'package:rtm_system/ultils/color_ultils.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

ButtonState _buttonState = ButtonState.normal;

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: welcome_color,
      child: Center(
       child: _checkLogin(),
      )
       );
  }

Widget _checkLogin(){
    return Container(
      color: welcome_color,
      width: 200,height: 50,
      child: Material(
          color: welcome_color,
  child: ProgressButton(
  child: Text("Login"),
  onPressed: () {

  setState(() {
  if(_buttonState == ButtonState.normal){
    _buttonState = ButtonState.inProgress;
  }else if(_buttonState == ButtonState.inProgress){
    _buttonState = ButtonState.error;
  }else{
    _buttonState = ButtonState.normal;
  }
  print('Button State: $_buttonState');
  });
  },
  buttonState: _buttonState,
    backgroundColor: Colors.blueAccent,
    progressColor: Colors.white,
  )),
    );
}
}

// class _LoginPageState extends State<LoginPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: welcome_color,
//       child: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             GoogleSignInButton(
//               onPressed: () {
//
//               },),
//             AppleSignInButton(
//               onPressed: () {
//
//               },),
//             FacebookSignInButton(
//               onPressed: () {
//
//               },),
//
//         ],),
//       ),
//     );
//   }
// }
