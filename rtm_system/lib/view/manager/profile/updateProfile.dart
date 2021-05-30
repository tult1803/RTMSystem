import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../formUpdateProfile.dart';

class updateProfile extends StatefulWidget {
  const updateProfile({Key key}) : super(key: key);

  @override
  _updateProfileState createState() => _updateProfileState();
}
enum GenderCharacter { women, men }

class _updateProfileState extends State<updateProfile> {
  DateTime birthday = DateTime.now();
  String date, password;
  String fullname,phone;
  int gender;
  GenderCharacter character;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataProfile();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: welcome_color,
        title: Text(
            "Cập nhật thông tin",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w500, fontSize: 22),
        ),
      ),
      body: SingleChildScrollView(child: new formUpdateProfile(
        check: false,
        fullname: fullname,
        birthday: birthday,
        phone: phone,
        gender: gender,
        password: password,
        address: "manager",
        cmnd: "01234567890",
        list: [fullname,gender,phone,"01234567890", "manager", password, birthday],
      ))
    );
  }

  //Dùng để lấy thông tin khách hàng đã lưu trong máy
//Dùng cho updateProfile hiện tại là chỉ manager
  Future getDataProfile() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      fullname = prefs.getString("fullname");
      gender = prefs.get("gender");
      birthday = DateFormat("yyyy-MM-dd").parse(prefs.get("birthday"));
      phone = prefs.get("phone");
      password = prefs.get("password");
    });
  }
}
