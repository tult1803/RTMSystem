import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:rtm_system/view/formChangePW.dart';
import 'package:rtm_system/view/formUpdateProfile.dart';

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
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEEEEEE),
      appBar: AppBar(
        backgroundColor: Color(0xFF0BB791),
        title: Container(
          margin: EdgeInsets.only(left: 34),
          child: Text(
            title,
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
