import 'package:flutter/material.dart';
import 'package:rtm_system/presenter/Manager/profile/show_customer.dart';
import 'package:rtm_system/helpers/common_widget.dart';
import 'package:rtm_system/helpers/component.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';

import '../home_manager_page.dart';
import 'create_new_customer.dart';

class AllCustomer extends StatefulWidget {
final Widget widgetToNavigator;

  const AllCustomer({this.widgetToNavigator});

  @override
  _AllCustomerState createState() => _AllCustomerState();
}

class _AllCustomerState extends State<AllCustomer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: leadingAppbar(context, widget: this.widget.widgetToNavigator == null ? HomeAdminPage(index: 4,): this.widget.widgetToNavigator),
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
