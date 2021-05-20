import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';
import 'package:rtm_system/view/customer/Profile/profile.dart';
import 'package:rtm_system/view/customer/invoice/all_invoice.dart';
import 'package:rtm_system/view/customer/notice/all_notices.dart';


class HomeCustomerPage extends StatefulWidget {
  @override
  _HomeCustomerPageState createState() => _HomeCustomerPageState();
}

class _HomeCustomerPageState extends State<HomeCustomerPage> {
  GlobalKey _bottomNavigationKey = GlobalKey();
  int _index = 1;
  String txt = "Tất cả thông báo";
  Widget _widget;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _widget = InvoicePage();
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
          Icon(Icons.my_library_books_outlined, size: 30),
          Icon(Icons.assignment_outlined, size: 30),
          Icon(Icons.notifications_none, size: 30),
          // Icon(Icons.perm_contact_cal_outlined, size: 30),
          Icon(Icons.people_rounded, size: 30),
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
              _widget = InvoicePage();
            } else if (index == 2) {
              _widget = NoticesPage();
            } else if (index == 3){
              _widget = ProfilePage();
          }});
        },
        letIndexChange: (index) => true,
      ),
    );
  }
}
