import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rtm_system/ultils/button.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
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
              Container(
                  child: Center(
                child: Text(
                  'Thay đổi hình đại diện',
                  style: TextStyle(
                    color: Color(0xFF0BB791),
                  ),
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
                          ListTile(
                            title: Text('Họ và tên'),
                            trailing: Text('Bùi Thị Thùy Trang'),
                          ),
                          SizedBox(
                            height: 1,
                            width: 330,
                            child: Container(
                              color: Color(0xFFBDBDBD),
                            ),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                        ],
                      )
                  )
              ),
              btnUpdateInfo(context),
            ],
          ),
        ));
  }
}