import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';
import 'package:rtm_system/view/customer/Profile/profile.dart';
import 'package:rtm_system/view/customer/home_menu.dart';
import 'package:rtm_system/view/customer/invoice/allInvoiceTab.dart';
import 'package:rtm_system/view/customer/notice/all_notices.dart';

import 'advance/all_advance.dart';

class HomeCustomerPage extends StatefulWidget {
  int index, indexAdvance, indexInvoice;

  HomeCustomerPage({this.index, this.indexAdvance, this.indexInvoice});

  @override
  _HomeCustomerPageState createState() => _HomeCustomerPageState();
}

class _HomeCustomerPageState extends State<HomeCustomerPage> {
  GlobalKey _bottomNavigationKey = GlobalKey();
  int _index;
  Widget _widget;

  @override
  void initState() {
    super.initState();
    _index = widget.index;
    if (_index == 0) {
      _widget = HomeMenu();
    } else if (_index == 1) {
      _widget = InvoiceTab(index: widget.indexInvoice == null? 0: widget.indexInvoice);
    } else if (_index == 2) {
      _widget = AdvancePage(index: widget.indexAdvance == null? 0: widget.indexAdvance);
    } else if (_index == 3) {
      _widget = NoticesPage();
    } else if (_index == 4) {
      _widget = ProfilePage();
    }
  }

  @override
  void dispose() {
    super.dispose();
    widget.indexAdvance = 0;
    widget.indexInvoice = 0;
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
          Icon(
            Icons.home,
            size: 30,
          ),
          Icon(
            Icons.my_library_books_outlined,
            size: 30,
          ),
          Icon(Icons.monetization_on_outlined, size: 30),
          Icon(Icons.notifications_none, size: 30),
          Icon(Icons.people_rounded, size: 30),
          // Icon(Icons.contacts_outlined, size: 30),
        ],
        color: Colors.white,
        buttonBackgroundColor: primaryColor,
        backgroundColor: Colors.white,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 400),
        onTap: (index) {
          setState(() {
            if (index == 0) {
              _widget = HomeMenu();
            } else if (index == 1) {
              _widget = InvoiceTab(index: widget.indexInvoice == null? 0: widget.indexInvoice);
            } else if (index == 2) {
              _widget = AdvancePage(index: widget.indexAdvance == null? 0: widget.indexAdvance);
            } else if (index == 3) {
              _widget = NoticesPage();
            } else if (index == 4) {
              _widget = ProfilePage();
            }
          });
        },
        letIndexChange: (index) => true,
      ),
    );
  }
}
