import 'package:flutter/material.dart';
import 'package:rtm_system/helpers/component.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';

import 'components/body.dart';


class OtpScreen extends StatelessWidget {
  final String phoneNumber;
  final bool isLogin;

  OtpScreen({this.phoneNumber, this.isLogin});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: leadingAppbar(context,colorIcon: Colors.white),
        centerTitle: true,
        title: titleAppBar("Xác thực OTP"),
      ),
      body: Theme(
          data: ThemeData(
            textSelectionTheme: TextSelectionThemeData(cursorColor: welcome_color),
          ),
          child: Body(phoneNumber: phoneNumber)),
    );
  }
}