
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
       child: SafeArea(
         child: Column(
           // mainAxisAlignment: MainAxisAlignment.center,
           children: [
             Container(
               height: 200,
               width: 200,
               child: Image(
                   image:  AssetImage("images/icon.png")),
             ),
             _txtPhone(),
             SizedBox(height: 10,),
             _txtPassword(),
             SizedBox(height: 10,),
             _checkLogin(),
           ],
         ),
       ),
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
  child: Text("Đăng nhập"),
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
    backgroundColor: Colors.white60,
    progressColor: Colors.white,
  )),
    );
}

Widget _txtPhone(){
    return Container(
      width: 300,
      child: Material(
        borderRadius: BorderRadius.all(new Radius.circular(10)),
            child: Row(
              children: [
                Container(padding: EdgeInsets.only(left: 10,right: 10),child: Icon(Icons.phone_android),),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(left: 0)
                    ),
          ),
                ),
              ],
            ),
      ),
    );
}

  Widget _txtPassword(){
    return Container(
      width: 300,
      child: Material(
        borderRadius: BorderRadius.all(new Radius.circular(10)),
        child: Row(
          children: [
            Container(padding: EdgeInsets.only(left: 10,right: 10),child: Icon(Icons.lock_outline),),
            Expanded(
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(left: 0)
                ),
              ),
            ),
          ],
        ),
      ),
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
