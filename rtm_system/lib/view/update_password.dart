import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rtm_system/ultils/component.dart';
import 'package:rtm_system/view/formChangePW.dart';

class UpdatePasswordPage extends StatefulWidget {
  UpdatePasswordPage({this.password, this.account_id});
  String password;
  int account_id;

  @override
  _UpdateProfilePageState createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdatePasswordPage> {
  String title = "Thay đổi mật khẩu";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEEEEEE),
      appBar: AppBar(
        leading: leadingAppbar(context),
        backgroundColor: Color(0xFF0BB791),
        centerTitle: true,
        title: Container(
          margin: EdgeInsets.only(left: 34),
          child: Text(
            title,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: new formUpdatePasswordPage(
          currentPassword: widget.password,
          account_id: widget.account_id,
        ),
      ),
    );
  }
}
