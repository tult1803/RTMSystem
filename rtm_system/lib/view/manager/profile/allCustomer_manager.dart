import 'package:flutter/material.dart';
import 'package:rtm_system/presenter/Manager/profile/showCustomer.dart';
import 'package:rtm_system/ultils/commonWidget.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';

import 'createNewCustomer.dart';

class AllCustomer extends StatefulWidget {
  const AllCustomer({Key key}) : super(key: key);

  @override
  _AllCustomerState createState() => _AllCustomerState();
}

class _AllCustomerState extends State<AllCustomer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: welcome_color,
        title: Text(
              "Quản lý khách hàng",
              style: TextStyle(
                  color: Colors.white, fontWeight: FontWeight.w500, fontSize: 22),
            ),
        bottom: PreferredSize(
            child: btnMain(context, "Tạo khách hàng", Icon(Icons.person_add), CreateCustomer()),
            preferredSize: Size.fromHeight(60.0)),
      ),
      body: new showAllCustomer(),
    );
  }
}
