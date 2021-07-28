import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rtm_system/helpers/component.dart';
import 'package:rtm_system/ultils/check_data.dart';
import 'package:rtm_system/ultils/get_api_data.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';
import 'package:rtm_system/view/login_page.dart';

class InputNewPassword extends StatefulWidget {
  final String firebaseToken;
  const InputNewPassword({this.firebaseToken});

  @override
  _InputNewPasswordState createState() => _InputNewPasswordState();
}

class _InputNewPasswordState extends State<InputNewPassword> {
  String errPassword, errConfirmPassword, password, confirmPassword;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: leadingAppbar(context,
            colorIcon: Colors.white, widget: LoginPage()),
        centerTitle: true,
        title: titleAppBar("Quên mật khẩu"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black54,
                  blurRadius: 3,
                  offset: Offset(1, 1), // Shadow position
                ),
              ],
            ),
            width: size.width,
            height: 270,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _txtfield("Nhập mật khẩu", errPassword, 1),
                SizedBox(height: 20),
                _txtfield("Nhập lại mật khẩu", errConfirmPassword, 2),
                SizedBox(height: 20),
                Container(
                    width: 280,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: welcome_color,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black54,
                          blurRadius: 3,
                          offset: Offset(1, 1), // Shadow position
                        ),
                      ],
                    ),
                    // ignore: deprecated_member_use
                    child: FlatButton(
                        onPressed: () {
                          setState(() {
                            errPassword = checkPassword(password, 1);
                            errConfirmPassword = checkPassword(
                                confirmPassword, 2,
                                passwordCheck: password);
                          });
                          if (errPassword == null && errConfirmPassword == null)
                            doForgotPassword(context, widget.firebaseToken,
                                password, confirmPassword);
                        },
                        child: Text(
                          "Xác nhận",
                          style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 17),
                        )))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _txtfield(String hintText, String error, int type) {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      width: 300,
      child: TextField(
        textAlign: TextAlign.left,
        maxLines: 1,
        onChanged: (value) {
          setState(() {
            if (type == 1) {
              password = value.trim();
            } else {
              confirmPassword = value.trim();
            }
          });
        },
        onSubmitted: (value) {
          setState(() {
            if (type == 1) {
              errPassword = checkPassword(password, 1);
            } else {
              errConfirmPassword =
                  checkPassword(confirmPassword, 2, passwordCheck: password);
            }
          });
        },
        keyboardType: TextInputType.text,
        obscureText: true,
        style: TextStyle(fontSize: 20),
        cursorColor: welcome_color,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: welcome_color),
          ),
          hintText: '$hintText',
          //Sau khi click vào "Nhập tiêu đề" thì màu viền sẽ đổi
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: welcome_color),
          ),
          //Hiển thị Icon góc phải
          suffixIcon: Icon(
            type == 1 ? Icons.lock_outline : Icons.lock,
            color: Colors.black54,
          ),
          //Hiển thị lỗi
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.redAccent),
          ),
          //Nhận thông báo lỗi
          errorText: error,
          contentPadding: EdgeInsets.all(15),
        ),
      ),
    );
  }
}
