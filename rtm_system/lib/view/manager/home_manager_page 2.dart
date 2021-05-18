import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';
import 'package:rtm_system/view/login_page.dart';
import 'package:rtm_system/view/manager/allNotice_manager.dart';
import 'package:rtm_system/view/manager/allProduct_manager_page.dart';

class HomeAdminPage extends StatefulWidget {
  @override
  _HomeAdminPageState createState() => _HomeAdminPageState();
}

class _HomeAdminPageState extends State<HomeAdminPage> {
  GlobalKey _bottomNavigationKey = GlobalKey();
  int _index = 2;
  String txt = "Tất cả thông báo";
  Widget _widget;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (LoginPageState.isLogin != true) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
          (route) => false);
    }
    _widget = AllProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widget,
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: _index,
        height: 50.0,
        items: <Widget>[
          Icon(Icons.perm_contact_cal_outlined, size: 30),
          Icon(Icons.my_library_books_outlined, size: 30),
          Icon(Icons.assignment_outlined, size: 30),
          Icon(Icons.notifications_none, size: 30),
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

            } else if (index == 1) {

            } else if (index == 2) {
              _widget = AllProduct();
            } else if (index == 3) {
              _widget = AllNotice();
            } else if (index == 4) {

            }
          });
        },
        letIndexChange: (index) => true,
      ),
    );
  }
}
