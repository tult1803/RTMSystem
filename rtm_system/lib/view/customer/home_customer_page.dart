import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';
import 'package:rtm_system/view/customer/Profile/profile.dart';
import 'package:rtm_system/view/customer/contact/ContactPage.dart';
import 'package:rtm_system/view/customer/invoice/allInvoiceTab.dart';
import 'package:rtm_system/view/customer/notice/all_notices.dart';

import 'advance/all_advance.dart';

class HomeCustomerPage extends StatefulWidget {
  final index;

  HomeCustomerPage({this.index});

  @override
  _HomeCustomerPageState createState() => _HomeCustomerPageState();
}

class _HomeCustomerPageState extends State<HomeCustomerPage> {
  GlobalKey _bottomNavigationKey = GlobalKey();
  int _index;
  Widget _widget;

  //call api return money advance

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _index = widget.index;
    if (_index == 0) {
      _widget = InvoiceTab();
    } else if (_index == 1) {
      _widget = AdvancePage();
    } else if (_index == 2) {
      _widget = NoticesPage();
    } else if (_index == 3) {
      _widget = ProfilePage();
    }else if (_index == 4) {
      _widget = ContactPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widget,
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: _index,
        height: 70.0,
        items: <Widget>[
          Icon( Icons.my_library_books_outlined, size: 30, ),
          Icon(Icons.monetization_on_outlined, size: 30),
          Icon(Icons.notifications_none, size: 30),
          Icon(Icons.people_rounded, size: 30),
          Icon(Icons.contacts_outlined, size: 30),
        ],
        color: Colors.white,
        buttonBackgroundColor: primaryColor,
        backgroundColor: Colors.white,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 400),
        onTap: (index) {
          setState(() {
            if (index == 0) {
              _widget = InvoiceTab();
            } else if (index == 1) {
              _widget = AdvancePage();
            } else if (index == 2) {
              _widget = NoticesPage();
            } else if (index == 3) {
              _widget = ProfilePage();
            }else if (index == 4) {
              _widget = ContactPage();
            }
          });
        },
        letIndexChange: (index) => true,
      ),
    );
  }
}
