import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:rtm_system/presenter/Manager/showCreateCustomer.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';

class CreateCustomer extends StatefulWidget {
  const CreateCustomer({Key key}) : super(key: key);

  @override
  _CreateCustomerState createState() => _CreateCustomerState();
}

class _CreateCustomerState extends State<CreateCustomer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: welcome_color,
        title: Center(
          child: Text(
            "Tạo khách hàng",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w500, fontSize: 22),
          ),
        ),
      ),
      body: SingleChildScrollView(child: new showCreateCustomer())
    );
  }
}
