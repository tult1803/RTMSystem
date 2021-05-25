import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rtm_system/ultils/button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  String fullname = '', birthday = '', phone = '';
  int gender = 0;

  Future _getFullName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      if (prefs.getString("fullname") != null) {
        fullname = prefs.getString("fullname");
        gender = prefs.getInt("gender");
        birthday = prefs.getString("birthday");
        phone = prefs.getString("phone");
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getFullName();
  }

  @override
  Widget build(BuildContext context) {
    String genderShow = '';
    //show gender
    gender == 0? genderShow = 'Nữ' : genderShow = 'Nam';
    //format date
    DateTime date = DateTime.parse(birthday);
    final f = new DateFormat('dd-MM-yyyy');
    var size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Color(0xFF0BB791),
        body: Container(
          margin: EdgeInsets.fromLTRB(0, 24, 0, 0),
          decoration: BoxDecoration(
            color: Color(0xffEEEEEE),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0),
              topRight: Radius.circular(15.0),
            ),
          ),
          child: Column(
            children: [
              Container(
                  width: 100,
                  height: 100,
                  child: Center(
                    child: Image(
                      image: AssetImage("images/avt.png"),
                    ),
                  )),
              SizedBox(
                height: 10,
              ),
              btnLogout(context),
              SizedBox(
                height: 10,
              ),

              //data infor show here
              Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 12),
                  color: Colors.white,
                  child: Center(
                      child: Column(
                        children: [
                          _item(context, 'Họ và tên', fullname),
                          _item(context, 'Ngày sinh', f.format(date)),
                          _item(context, 'Số điện thoại', phone),
                          _item(context, 'Giới tính', genderShow),
                          _item(context, 'CMND', '09876543 giả'),
                          _item(context, 'Địa chỉ', 'abc giả'),
                          SizedBox(
                            height: 12,
                          ),
                        ],
                      )
                  )
              ),
              btnUpdateInfo(context, fullname ,gender, birthday, phone),
            ],
          ),
        ));
  }
}


Widget _item(context, header, value) {
  var size = MediaQuery.of(context).size;
  return Column(
    children: [
      ListTile(
        title: Text(header),
        trailing: Text(value),
      ),
      SizedBox(
        height: 1,
        width: size.width * 0.90,
        child: Container(
          color: Color(0xFFBDBDBD),
        ),
      ),
    ],
  );
}