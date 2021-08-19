import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rtm_system/helpers/component.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../form_update_profile.dart';

// ignore: camel_case_types
class updateProfile extends StatefulWidget {
  final String fullname, accountId;
  final int gender;
  updateProfile({this.fullname, this.gender, this.accountId});

  @override
  _updateProfileState createState() => _updateProfileState();
}

enum GenderCharacter { women, men }

// ignore: camel_case_types
class _updateProfileState extends State<updateProfile> {
  DateTime birthday = DateTime.now();
  String date;
  String phone;

  @override
  void initState() {
    super.initState();
    getDataProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: leadingAppbar(context),
          centerTitle: true,
          backgroundColor: welcome_color,
          title: titleAppBar("Cập nhật thông tin"),
        ),
        body: SingleChildScrollView(
            child: new formUpdateProfile(
          isCreate: false,
          isUpdate: true,
          typeOfUpdate: 1,
          accountId: this.widget.accountId,
          isCustomer: false,
          isUpgrade: false,
          check: false,
          fullname: this.widget.fullname,
          birthday: birthday,
          phone: phone,
          gender: widget.gender,
          list: [
            this.widget.fullname,
            widget.gender,
            phone,
            "",
            "",
            birthday
          ],
        )));
  }

  //Dùng để lấy thông tin khách hàng đã lưu trong máy
//Dùng cho updateProfile hiện tại là chỉ manager
  Future getDataProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      birthday = DateFormat("yyyy-MM-dd").parse(prefs.get("birthday"));
      phone = prefs.get("phone");
    });
  }
}
