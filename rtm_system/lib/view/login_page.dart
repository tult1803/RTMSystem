import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rtm_system/model/model_login.dart';
import 'package:rtm_system/model/postAPI_login.dart';
import 'package:rtm_system/presenter/check_login.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';
import 'package:rtm_system/view/customer/home_customer_page.dart';
import 'package:rtm_system/view/manager/home_manager_page.dart';

class LoginPage extends StatefulWidget {
  @override
  LoginPageState createState() => LoginPageState();
}

ButtonState _buttonState = ButtonState.normal;
Timer _timer;
PostLogin getAPI = PostLogin();
DataLogin data;

class LoginPageState extends State<LoginPage> {
  static bool isLogin = false;
  var role_id = 0, accountId = 0;
  String username = "";
  String password;
  String access_token = '';
  String fullname = "";
  int gender = 0;
  String phone ='';
  String birthday ='';
  String error="";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkSaveLogin(context);
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
                  child: Image(image: AssetImage("images/icon.png")),
                ),
                Text(error, style: TextStyle(fontSize: 25, decoration: TextDecoration.none, color: Colors.redAccent)),
                _txtUsername(),
                SizedBox(
                  height: 10,
                ),
                _txtPassword(),
                SizedBox(
                  height: 15,
                ),
                _checkLogin(),
              ],
            ),
          ),
        ));
  }

  int status;

  Future LoginApi() async {
    // Đỗ dữ liệu lấy từ api
    data = await getAPI.createLogin(username, password);
    status = await PostLogin.status;
    print('STS ne');
    print(status);
    setState(() {
      role_id = data.roles[0];
      access_token = data.access_token;
      accountId = data.accountId;
      fullname = data.fullname;
      phone = data.phone;
      birthday = data.birthday;
      gender = data.gender;
    });
  }

  Future afterLogin() async {
    try {
      await LoginApi();
      print('Role ID: ${role_id}');
    }catch (e){
      print('Error from LoginApi !!!');
    }
    if (role_id == 3 && status == 200) {
      savedInfoLogin(role_id, accountId, gender,access_token, fullname, phone,birthday, password);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomeCustomerPage(index: 2,)),
          (route) => false);
      print('Status button: Done');
      _buttonState = ButtonState.normal;
    } else if (role_id == 2 && status == 200) {
      savedInfoLogin(role_id, accountId, gender,access_token, fullname, phone, birthday, password);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomeAdminPage(index: 2,)),
          (route) => false);
      print('Status button: Done');
      _buttonState = ButtonState.normal;
    } else {
      startTimer(false);
    }
  }


  Widget _checkLogin() {
    return Container(
      color: welcome_color,
      width: 200,
      height: 50,
      child: Material(
          color: welcome_color,
          child: ProgressButton(
            child: Text("Đăng nhập"),
            onPressed: () {
              setState(() {
                error = "";
                _buttonState = ButtonState.inProgress;
                print('Status button: Process');
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
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (status == false) {
            _buttonState = ButtonState.error;
            print('Status button: Error');
            error = "Lỗi đăng nhập !!!";
            timer.cancel();
          }
        },
      ),
    );
  }

  Widget _txtUsername() {
    return Container(
      width: 300,
      child: Material(
        borderRadius: BorderRadius.all(new Radius.circular(10)),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Icon(Icons.person),
            ),
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

  Widget _txtPassword() {
    return Container(
      width: 300,
      child: Material(
        borderRadius: BorderRadius.all(new Radius.circular(10)),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Icon(Icons.lock_outline),
            ),
            Expanded(
              child: TextField(
                obscureText: true,
                onChanged: (value1) {
                  setState(() {
                    password = value1;
                  });
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
