import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:rtm_system/view/formUpdateProfile.dart';

class UpdateProfilePage extends StatefulWidget {
  const UpdateProfilePage({
    Key key,
    this.fullname,
    this.phone,
    this.gender,
    this.password,
    this.cmnd,
    this.address,
    this.birthday,
    this.check,
    this.account_id,
  }) : super(key: key);
  final String cmnd;
  final String fullname;
  final int gender;
  final String phone;
  final String password;
  final DateTime birthday;
  final String address;
  final bool check;
  final int account_id;

  @override
  _UpdateProfilePageState createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  String title = "Thông tin cá nhân";
  int selectedRadio;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //set value nam or nu
    selectedRadio = widget.gender;
  }

  setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
    });
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
        child: new formUpdateProfile(
          fullname: widget.fullname,
          phone: widget.phone,
          cmnd: widget.cmnd,
          address: widget.address,
          password: widget.password,
          birthday: widget.birthday,
          gender: widget.gender,
          check: true,
          isUpdate: true,
          typeOfUpdate: 1,
          account_id: widget.account_id,
        ),
      ),
    );
  }
}
