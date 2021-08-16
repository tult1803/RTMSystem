import 'package:flutter/material.dart';
import 'package:rtm_system/presenter/Manager/profile/show_customer.dart';
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
        title: titleAppBar("Quản lý khách hàng"),
      ),
      body: showAllCustomer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CreateCustomer()),
          );
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 25,
        ),
        backgroundColor: primaryColor,
      )
    );
  }
}
