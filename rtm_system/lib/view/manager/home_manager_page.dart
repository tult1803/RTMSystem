import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:rtm_system/ultils/src/checkConnectivity.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';
import 'package:rtm_system/view/manager/debt/allDebt_manager.dart';
import 'package:rtm_system/view/manager/notice/allNotice_manager.dart';
import 'package:rtm_system/view/manager/product/allProduct_manager_page.dart';
import 'package:rtm_system/view/manager/profile/profile_manager.dart';

import 'invoice/allInvoice_manager.dart';


class HomeAdminPage extends StatefulWidget {
  final int index, indexInsidePage;
  HomeAdminPage({this.index, this.indexInsidePage});

  @override
  _HomeAdminPageState createState() => _HomeAdminPageState();
}

class _HomeAdminPageState extends State<HomeAdminPage> {
  StreamSubscription<ConnectivityResult> subscription;
  GlobalKey _bottomNavigationKey = GlobalKey();
  int _index = 0;
  Widget _widget;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _index = widget.index;
    if (_index == 0) {
      _widget = AllProduct();
    } else if (_index == 1) {
      _widget = AllInvoice(index: widget.indexInsidePage,);
    } else if (_index == 2) {
      _widget = AllDebt();
    } else if (_index == 3) {
      _widget = AllNotice();
    } else if (_index == 4) {
      _widget = ProfileManager();
    }
    subscription = Connectivity()
          .onConnectivityChanged
          .listen((ConnectivityResult result) {
        checkConnectivity(context, result);
      });
    }

    @override
    void dispose() {
      // TODO: implement dispose
      super.dispose();
      subscription.cancel();
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widget,
      bottomNavigationBar: SafeArea(
        bottom: true,
        child: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: _index,
          height: 40.0,
          items: <Widget>[
            Icon(Icons.home_outlined, size: 30),
            Icon(Icons.my_library_books_outlined, size: 30),
            Icon(Icons.addchart, size: 30),
            Icon(Icons.notifications_none, size: 30),
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
                _widget = AllProduct();
              } else if (index == 1) {
                _widget = AllInvoice();
              } else if (index == 2) {
                _widget = AllDebt();
              } else if (index == 3) {
                _widget = AllNotice();
              } else if (index == 4) {
                _widget = ProfileManager();
              }
            });
          },
          letIndexChange: (index) => true,
        ),
      ),
    );
  }
}
