import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rtm_system/demo.dart';
import 'package:rtm_system/model/model_login.dart';
import 'package:rtm_system/model/post/postAPI_login.dart';
import 'package:rtm_system/presenter/check_login.dart';
import 'package:rtm_system/ultils/check_data.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';
import 'package:rtm_system/ultils/src/message_list.dart';
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
  int status;
  String username = "", accountId = "";
  String password;
  String accessToken = '';
  String fullName = "";
  int gender = 0;
  String phone = '';
  String birthday = '';
  String error = "", errorUsername, errorPassword;

  @override
  void initState() {
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
                SizedBox(
                  height: 15,
                ),
                forgotPassword(),
              ],
            ),
          ),
        ));
  }

  Widget forgotPassword(){
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => OTPLogin(),));
      },
      child: Text("Quên mật khẩu", style: GoogleFonts.roboto(color: welcome_color, fontSize: 16),),
    );
  }

  Future loginApi() async {
    // Đỗ dữ liệu lấy từ api
    data = await getAPI.createLogin(username, password);

    status = PostLogin.status;
    setState(() {
      roleId = data.roleId;
      accessToken = data.accessToken;
      accountId = data.accountId;
      fullName = data.fullName;
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
      savedInfoLogin(roleId, accountId, gender, accessToken, fullName, phone,
          birthday, password);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => HomeCustomerPage(
                    index: 0,
                  )),
          (route) => false);
      print('Status button: Done');
      _buttonState = ButtonState.normal;
    } else if (roleId == 2 && status == 200) {
      savedInfoLogin(roleId, accountId, gender, accessToken, fullName, phone,
          birthday, password);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => HomeAdminPage(
                    index: 0,
                  )),
          (route) => false);
      print('Status button: Done');
      _buttonState = ButtonState.normal;
    } else {
      startTimer(false);
    }
  }


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
            error = showMessage("Số điện thoại hoặc mật khẩu", MSG020);
            timer.cancel();
          }
        },
      ),
    );
  }

  void _checkTextLogin() {
    setState(() {
      error = "";
        errorUsername =  checkPhoneNumber(username);
      if (password == null || password == "") {
        errorPassword = "Mật khẩu trống";
      } else {
        errorPassword = null;
      }

      if (errorUsername == null && errorPassword == null) {
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
          onSubmitted: (value) {
            setState(() {
              errorUsername =  checkPhoneNumber(username);
            });
          },
          cursorColor: welcome_color,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
          ],
          decoration: InputDecoration(
            border: UnderlineInputBorder(),
            labelText: "Số điện thoại",
            labelStyle: TextStyle(color: Colors.black54),
            contentPadding: EdgeInsets.only(top: 14, left: 10),
            //Sau khi click vào "Nhập tiêu đề" thì màu viền sẽ đổi
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: welcome_color),
            ),
            //Hiển thị Icon góc phải
            suffixIcon: Icon(
              Icons.phone_iphone,
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
