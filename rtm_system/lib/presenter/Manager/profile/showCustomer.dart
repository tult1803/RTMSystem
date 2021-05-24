import 'dart:html';

import 'package:flutter/material.dart';

class showAllCustomer extends StatefulWidget {
  const showAllCustomer({Key key}) : super(key: key);

  @override
  _showAllCustomerState createState() => _showAllCustomerState();
}

class _showAllCustomerState extends State<showAllCustomer> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Container(child: Text("Đang chờ API"),));
  }
}
