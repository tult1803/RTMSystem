import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rtm_system/helpers/component.dart';
import 'package:rtm_system/view/form_update_profile.dart';

class UpdateProfilePage extends StatefulWidget {
  const UpdateProfilePage({
    Key key,
    this.fullname,
    this.gender,
    this.password,
    this.cmnd,
    this.address,
    this.birthday,
    this.phone,
    this.check,
    this.accountId,
  }) : super(key: key);
  final String cmnd;
  final String fullname;
  final int gender;
  final String password;
  final DateTime birthday;
  final String address;
  final String phone;
  final bool check;
  final String accountId;


  @override
  _UpdateProfilePageState createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  String title = "Thay đổi thông tin";
  int selectedRadio;
  bool checkShow = true, checkClick = false, checkPasswordSuccess = false;
  @override
  void initState() {
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
        leading: leadingAppbar(context),
        centerTitle: true,
        backgroundColor: Color(0xFF0BB791),
        title: Text(
          title,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: formUpdateProfile(
              fullname: widget.fullname,
              cmnd: widget.cmnd,
              phone: widget.phone,
              address: widget.address,
              password: widget.password,
              birthday: widget.birthday,
              gender: widget.gender,
              check: true,
              isUpdate: true,
              typeOfUpdate: 1,
              accountId: widget.accountId,
              isCustomer: true,
              isCreate: false,
              isUpgrade: false,
            ),
      ),
    );
  }
}
