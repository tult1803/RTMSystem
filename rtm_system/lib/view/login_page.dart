import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rtm_system/model/model_login.dart';
import 'package:rtm_system/model/postAPI_login.dart';
import 'package:rtm_system/presenter/check_login.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';
import 'package:rtm_system/view/customer/home_customer_page.dart';
import 'package:rtm_system/view/manager/home_admin_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  LoginPageState createState() => LoginPageState();
}

ButtonState _buttonState = ButtonState.normal;
Timer _timer;
PostAPI getAPI = PostAPI();
DataLogin data;

class LoginPageState extends State<LoginPage> {
  static bool isLogin = false;
  var role_id = 0, accountId = 0;
  String username = "";
  String password = "";
  String access_token='';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _isLogin();
  }

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
             SizedBox(height: 10,),
             _txtUsername(),
             SizedBox(height: 10,),
             _txtPassword(),
             SizedBox(height: 15,),
             _checkLogin(),
           ],
         ),
       ),
      )
       );
  }

  int status;
  Future LoginApi()async{
    // Đỗ dữ liệu lấy từ api
    data = await getAPI.createLogin(
        username, password);
    status = await PostAPI.status;
    setState(() {
      role_id = data.role_id;
      access_token = data.access_token;
      accountId = data.accountId;
    });
  }

  Future afterLogin() async{
    await LoginApi();
    if(role_id == 3 && status == 200){
      isLogin = true;
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) => HomeCustomerPage())
          , (route) => false);
      _buttonState =  ButtonState.normal;
    }else if(role_id == 2 && status == 200){
      isLogin = true;
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) => HomeAdminPage())
          , (route) => false);
      _buttonState =  ButtonState.normal;
    }else {
      startTimer(false);
    }
  }

Widget _checkLogin() {
    return Container(
      color: welcome_color,
      width: 200,height: 50,
      child: Material(
          color: welcome_color,
  child: ProgressButton(
  child: Text("Đăng nhập"),
  onPressed: () {
  setState(() {
     _buttonState = ButtonState.inProgress;
     afterLogin();
  });
  },
  buttonState: _buttonState,
    backgroundColor: Colors.white60,
    progressColor: Colors.white,
  )),
    );
}

// Điều khiển Animation cua nut Login
  void startTimer(bool status) {
    const oneSec = const Duration(seconds: 1);
    _timer =  new Timer.periodic(
      oneSec,
          (Timer timer) => setState(
            () {
              if(status == false){
                _buttonState =  ButtonState.error;
                timer.cancel();
              }
        },
      ),
    );
  }

Widget _txtUsername(){
    return Container(
      width: 300,
      child: Material(
        borderRadius: BorderRadius.all(new Radius.circular(10)),
            child: Row(
              children: [
                Container(padding: EdgeInsets.only(left: 10,right: 10),child: Icon(Icons.person),),
                Expanded(
                  child: TextField(
                    onChanged: (value) {
                      username = value;
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(left: 0),
                      hintText: "Tên đăng nhập",
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
                onChanged: (value1) {
                  password = value1;
                },
                decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(left: 0),
                  hintText: "Mật Khẩu",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}