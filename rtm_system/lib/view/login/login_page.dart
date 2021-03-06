import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rtm_system/model/model_login.dart';
import 'package:rtm_system/model/post/postAPI_login.dart';
import 'package:rtm_system/presenter/check_login.dart';
import 'package:rtm_system/ultils/check_data.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';
import 'package:rtm_system/ultils/src/message_list.dart';
import 'package:rtm_system/view/customer/home_customer_page.dart';
import 'package:rtm_system/view/manager/home_manager_page.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:keyboard_actions/keyboard_actions_config.dart';

import 'check_phone.dart';

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
  final FocusNode _nodeUsername = FocusNode();
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
  void dispose() {
    super.dispose();
    _nodeUsername.dispose();
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
                loginOTP(context),
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

  Widget loginOTP(BuildContext context){
   return GestureDetector(
     onTap: () {
       Navigator.of(context).push(MaterialPageRoute(builder: (context) => CheckPhone(isLogin: true,)));
     },
     child: Container(
         width: MediaQuery.of(context).size.width,
         margin: EdgeInsets.only(left: 50, right: 40),
         child: Text("????ng nh???p b???ng sms", style: GoogleFonts.roboto(color: Colors.blueAccent, fontWeight: FontWeight.w400,),)),
   ) ;
  }

  Widget forgotPassword() {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => CheckPhone(isLogin: false,)));
      },
      child: Text(
        "Qu??n m???t kh???u",
        style: GoogleFonts.roboto(color: welcome_color, fontSize: 16),
      ),
    );
  }

  Future loginApi() async {
    // ????? d??? li???u l???y t??? api
    data = await getAPI.createLogin(username, password: password, firebaseToken: "");
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
          birthday);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => HomeCustomerPage(
                    index: 0, indexAdvance: 0, indexInvoice: 0,
                  )),
          (route) => false);
      print('Status button: Done');
      _buttonState = ButtonState.normal;
    } else if (roleId == 2 && status == 200) {
      savedInfoLogin(roleId, accountId, gender, accessToken, fullName, phone,
          birthday);
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
          "????ng nh???p",
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

// ??i???u khi???n Animation cua nut Login
  void startTimer(bool status) {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (status == false) {
            _buttonState = ButtonState.error;
            print('Status button: Error');
            error = showMessage("S??? ??i???n tho???i ho???c m???t kh???u", MSG020);
            timer.cancel();
          }
        },
      ),
    );
  }

  void _checkTextLogin() {
    setState(() {
      error = "";
      errorUsername = checkPhoneNumber(username);
      errorPassword = checkPassword(password, 0);
      if (errorUsername == null && errorPassword == null) {
        _buttonState = ButtonState.inProgress;
        print('Status button: Process');
        afterLogin();
      }
    });
  }

  KeyboardActionsConfig keyBoardConfig(BuildContext context) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
      nextFocus: true,
      actions: [
        KeyboardActionsItem(
          focusNode: _nodeUsername,
          displayDoneButton: true,
          onTapAction: () {
            setState(() {
              errorUsername = checkPhoneNumber(username);
            });
          },
        ),
      ],
    );
  }

  Widget _txtUsername() {
    return Container(
      margin: EdgeInsets.only(left: 40, right: 40),
      child: KeyboardActions(
        disableScroll: true,
        config: keyBoardConfig(context),
        child: TextField(
          focusNode: _nodeUsername,
          maxLength: 11,
          onChanged: (value) {
            username = value.trim();
          },
          onSubmitted: (value) {
            setState(() {
              errorUsername = checkPhoneNumber(username);
            });
          },
          cursorColor: welcome_color,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
          ],
          decoration: InputDecoration(
            border: UnderlineInputBorder(),
            counterText: "",
            labelText: "S??? ??i???n tho???i",
            labelStyle: TextStyle(color: Colors.black54),
            contentPadding: EdgeInsets.only(top: 14, left: 10),
            //Sau khi click v??o "Nh???p ti??u ?????" th?? m??u vi???n s??? ?????i
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: welcome_color),
            ),
            //Hi???n th??? Icon g??c ph???i
            suffixIcon: Icon(
              Icons.phone_iphone,
              color: Colors.black54,
            ),
            //Hi???n th??? l???i
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.redAccent),
            ),
            //Nh???n th??ng b??o l???i
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
          onSubmitted: (value) {
            setState(() {
              errorPassword = checkPassword(password, 0);
            });
          },
          obscureText: obscureTextPassword,
          cursorColor: welcome_color,
          decoration: InputDecoration(
            border: UnderlineInputBorder(),
            labelText: "M???t kh???u",
            labelStyle: TextStyle(color: Colors.black54),
            contentPadding: EdgeInsets.only(top: 14, left: 10),
            //Sau khi click v??o "Nh???p ti??u ?????" th?? m??u vi???n s??? ?????i
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: welcome_color),
            ),
            //Hi???n th??? Icon g??c ph???i
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
            //Hi???n th??? l???i
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.redAccent),
            ),
            //Nh???n th??ng b??o l???i
            errorText: errorPassword,
          ),
        ),
      ),
    );
  }
}
