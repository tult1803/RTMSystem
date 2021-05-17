import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';
import 'package:rtm_system/view/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeAdminPage extends StatefulWidget {
  @override
  _HomeAdminPageState createState() => _HomeAdminPageState();
}

class _HomeAdminPageState extends State<HomeAdminPage> {
  GlobalKey _bottomNavigationKey = GlobalKey();
  int _index = 2;
  String txt = "Tất cả thông báo";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // if (LoginPageState.isLogin != true) {
    //   Navigator.pushAndRemoveUntil(
    //       context,
    //       MaterialPageRoute(builder: (context) => LoginPage()),
    //       (route) => false);
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FlatButton(
                onPressed: () async{
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  prefs.clear();
                  print('Saved Info is deleted');
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                      (route) => false);
                },
                child: Text("Đăng xuất", style: TextStyle(fontSize: 15)),
              ),
              Text(
                txt,
                style: TextStyle(fontSize: 5),
                textScaleFactor: 5,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: _index,
        height: 50.0,
        items: <Widget>[
          Icon(Icons.perm_contact_cal_outlined, size: 30),
          Icon(Icons.my_library_books_outlined, size: 30),
          Icon(Icons.notifications_none, size: 30),
          Icon(Icons.assignment_outlined, size: 30),
          Icon(Icons.attach_money, size: 30),
        ],
        color: Colors.white,
        buttonBackgroundColor: welcome_color,
        backgroundColor: Colors.white,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 600),
        onTap: (index) {
          setState(() {
            if (index == 0) {
              txt = 'Tổng khách hàng';
            } else if (index == 1) {
              txt = 'Tổng hoá đơn';
            } else if (index == 2) {
              txt = 'Tất cả thông báo';
            } else if (index == 3) {
              txt = 'Tổng sản phẩm';
            } else if (index == 4) {
              txt = 'Tất cả nợ';
            }
          });
        },
        letIndexChange: (index) => true,
      ),
    );
  }
}
