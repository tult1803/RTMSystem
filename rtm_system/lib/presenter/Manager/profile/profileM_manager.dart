import 'package:flutter/material.dart';
import 'package:rtm_system/helpers/button.dart';
import 'package:rtm_system/helpers/component.dart';
import 'package:rtm_system/view/customer/contact/ContactPage.dart';
import 'package:rtm_system/view/manager/profile/allCustomer_manager.dart';
import 'package:rtm_system/view/manager/profile/update_profile.dart';
import 'package:rtm_system/view/update_password.dart';
import 'package:shared_preferences/shared_preferences.dart';

class profilePage extends StatefulWidget {
  const profilePage({Key key}) : super(key: key);

  @override
  _profilePageState createState() => _profilePageState();
}

class _profilePageState extends State<profilePage> {
  String fullname = " ";
  String password;
  String accountId;
  Future _getFullName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
       password = prefs.get("password");
       accountId = "${prefs.get("accountId")}";
      if (prefs.getString("fullname") != null) {
        fullname = prefs.getString("fullname");
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _getFullName();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(top: 10),
      height: size.height,
      width: size.width,
      child: Column(
        children: [
          headerProfile(),
          buttonProfile(context, 15, 15, 20, 0, "Thông tin các cửa hàng", ContactPage()),
          buttonProfile(context,15, 15, 20, 0, "Quản lý khách hàng", AllCustomer()),
          buttonProfile(context,15, 15, 20, 0, "Thay đổi mật khẩu", UpdatePasswordPage(accountId: accountId, password: password, isCustomer: false,)),
          btnLogout(context),
        ],
      ),
    );
  }

  Widget headerProfile() {
    return Container(
      height: 100,
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.white10,
              child: Image.asset(
                "images/logo_profile.png",
                fit: BoxFit.fill,
              ),
              radius: 50,
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                txtFullNameProfile("$fullname"),
                txtCanClick(context, updateProfile(fullname: fullname,accountId: accountId,password: password, ),"Cập nhật thông tin"),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
