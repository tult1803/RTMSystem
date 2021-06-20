import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
// ignore: unused_element
Timer _timer;
PostLogin getAPI = PostLogin();
DataLogin data;

class LoginPageState extends State<LoginPage> {
  bool obscureTextPassword = true;
  Icon iconPassword = Icon(
    Icons.visibility_outlined,
    color: Colors.black54,
  );
  static bool isLogin = false;
  var roleId = 0;
  String username = "", accountId = "";
  String password;
  String accessToken = '';
  String fullname = "";
  int gender = 0;
  String phone = '';
  String birthday = '';
  String error = "", errorUsername, errorPassword;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkSaveLogin(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
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
                Text(error,
                    style: GoogleFonts.roboto(
                        fontSize: 14,
                        decoration: TextDecoration.none,
                        color: Colors.redAccent,
                        fontWeight: FontWeight.w500)),
                SizedBox(
                  height: 15,
                ),
                _txtUsername(),
                SizedBox(
                  height: 15,
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

  Future loginApi() async {
    // Đỗ dữ liệu lấy từ api
    data = await getAPI.createLogin(username, password);
    status = PostLogin.status;
    setState(() {
      roleId = data.role_id;
      accessToken = data.access_token;
      accountId = data.accountId;
      fullname = data.fullname;
      phone = data.phone;
      birthday = data.birthday;
      gender = data.gender;
    });
  }

  Future afterLogin() async {
    try {
      await loginApi();
      print('Role ID: $roleId');
    } catch (e) {
      print('Error from LoginApi !!!');
    }
    if (roleId == 3 && status == 200) {
      savedInfoLogin(roleId, accountId, gender, accessToken, fullname, phone,
          birthday, password);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => HomeCustomerPage(
                    index: 1,
                  )),
          (route) => false);
      print('Status button: Done');
      _buttonState = ButtonState.normal;
    } else if (roleId == 2 && status == 200) {
      savedInfoLogin(roleId, accountId, gender, accessToken, fullname, phone,
          birthday, password);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => HomeAdminPage(
                    index: 2,
                  )),
          (route) => false);
      print('Status button: Done');
      _buttonState = ButtonState.normal;
    } else {
      startTimer(false);
    }
  }

  bool isCheckU = false;
  bool isCheckP = false;

  Widget _checkLogin() {
    return Container(
      height: 45,
      margin: EdgeInsets.only(left: 40, right: 40),
      child: Material(
          child: ProgressButton(
        child: Text(
          "Đăng nhập",
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.w400),
        ),
        onPressed: () {
          _checkTextLogin();
        },
        buttonState: _buttonState,
        backgroundColor: welcome_color,
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
            error = "Sai Tên đăng nhập hoặc mật khẩu";
            timer.cancel();
          }
        },
      ),
    );
  }

  void _checkTextLogin() {
    setState(() {
      error = "";
      if (username == null || username == "") {
        isCheckU = false;
        errorUsername = "Tên đăng nhập trống";
      } else {
        isCheckU = true;
        errorUsername = null;
      }
      if (password == null || password == "") {
        isCheckP = false;
        errorPassword = "Mật khẩu trống";
      } else {
        isCheckP = true;
        errorPassword = null;
      }
      if (isCheckU && isCheckP) {
        _buttonState = ButtonState.inProgress;
        print('Status button: Process');
        afterLogin();
      }
    });
  }

  Widget _txtUsername() {
    return Container(
      margin: EdgeInsets.only(left: 40, right: 40),
      child: Material(
        child: TextField(
          onChanged: (value) {
            username = value.trim();
          },
          cursorColor: welcome_color,
          decoration: InputDecoration(
            border: UnderlineInputBorder(),
            labelText: "Tên đăng nhập",
            labelStyle: TextStyle(color: Colors.black54),
            contentPadding: EdgeInsets.only(top: 14, left: 10),
            //Sau khi click vào "Nhập tiêu đề" thì màu viền sẽ đổi
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: welcome_color),
            ),
            //Hiển thị Icon góc phải
            suffixIcon: Icon(
              Icons.person_outline_sharp,
              color: Colors.black54,
            ),
            //Hiển thị lỗi
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.redAccent),
            ),
            //Nhận thông báo lỗi
            errorText: errorUsername,
          ),
        ),
      ),
    );
  }

  Widget _txtPassword() {
    return Container(
      margin: EdgeInsets.only(left: 40, right: 40),
      child: Material(
        child: TextField(
          onChanged: (value1) {
            setState(() {
              password = value1.trim();
            });
          },
          obscureText: obscureTextPassword,
          cursorColor: welcome_color,
          decoration: InputDecoration(
            border: UnderlineInputBorder(),
            labelText: "Mật khẩu",
            labelStyle: TextStyle(color: Colors.black54),
            contentPadding: EdgeInsets.only(top: 14, left: 10),
            //Sau khi click vào "Nhập tiêu đề" thì màu viền sẽ đổi
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: welcome_color),
            ),
            //Hiển thị Icon góc phải
            suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    if (obscureTextPassword == true) {
                      obscureTextPassword = false;
                      iconPassword = Icon(
                        Icons.visibility,
                        color: Colors.black54,
                      );
                    } else {
                      obscureTextPassword = true;
                      iconPassword = Icon(
                        Icons.visibility_outlined,
                        color: Colors.black54,
                      );
                    }
                  });
                },
                child: iconPassword),
            //Hiển thị lỗi
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.redAccent),
            ),
            //Nhận thông báo lỗi
            errorText: errorPassword,
          ),
        ),
      ),
    );
  }
}
