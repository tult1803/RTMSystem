import 'package:flutter/material.dart';
import 'package:rtm_system/presenter/Manager/profile/showCustomer.dart';
import 'package:rtm_system/ultils/commonWidget.dart';
import 'package:rtm_system/ultils/component.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';

import '../home_manager_page.dart';
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
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_outlined, color: Colors.white),
          onPressed: () => Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=> HomeAdminPage(index: 4)), (route) => false)),
        centerTitle: true,
        backgroundColor: welcome_color,
        title: Text(
              "Quản lý khách hàng",
              style: TextStyle(
                  color: Colors.white, fontWeight: FontWeight.w500, fontSize: 22),
            ),
        bottom: PreferredSize(
            child: btnMain(context,150, "Tạo khách hàng", Icon(Icons.person_add), CreateCustomer()),
            preferredSize: Size.fromHeight(60.0)),
      ),
      body: new showAllCustomer(),
    );
  }
}
