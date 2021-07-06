import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rtm_system/helpers/component.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../form_update_profile.dart';

class updateProfile extends StatefulWidget {

  final String fullname, password, account_id;

  updateProfile({this.fullname, this.password, this.account_id});

  @override
  _updateProfileState createState() => _updateProfileState();
}
enum GenderCharacter { women, men }

class _updateProfileState extends State<updateProfile> {
  DateTime birthday = DateTime.now();
  String date;
  String phone;
  int gender;
  GenderCharacter character;
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
        title: Text(
            "Cập nhật thông tin",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w500, fontSize: 22),
        ),
      ),
      body: SingleChildScrollView(child: new formUpdateProfile(
        isUpdate: true,
        typeOfUpdate: 1,
        account_id: this.widget.account_id,
        isCustomer: false,
        check: false,
        fullname: this.widget.fullname,
        birthday: birthday,
        phone: phone,
        gender: gender,
        // Tai password mau dang la 1 nen bi bat validate
        password: this.widget.password,
        list: [this.widget.fullname,gender,phone,"", "", this.widget.password, birthday],
      ))
    );
  }

  //Dùng để lấy thông tin khách hàng đã lưu trong máy
//Dùng cho updateProfile hiện tại là chỉ manager
  Future getDataProfile() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      gender = prefs.get("gender");
      birthday = DateFormat("yyyy-MM-dd").parse(prefs.get("birthday"));
      phone = prefs.get("phone");
    });
  }
}
