import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rtm_system/helpers/component.dart';
import 'package:rtm_system/view/form_change_password.dart';

class UpdatePasswordPage extends StatefulWidget {
  UpdatePasswordPage({this.password, this.account_id, this.isCustomer});
  final String password;
  final String account_id;
  final bool isCustomer;
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
        title: Text(
          title,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: new formUpdatePasswordPage(
          currentPassword: widget.password,
          account_id: widget.account_id,
          isCustomer: this.widget.isCustomer,
        ),
      ),
    );
  }
}
