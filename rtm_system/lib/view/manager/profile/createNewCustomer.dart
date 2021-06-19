import 'package:flutter/material.dart';
import 'package:rtm_system/ultils/component.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';
import 'package:rtm_system/view/formUpdateProfile.dart';

class CreateCustomer extends StatefulWidget {
  const CreateCustomer({Key key}) : super(key: key);

  @override
  _CreateCustomerState createState() => _CreateCustomerState();
}

class _CreateCustomerState extends State<CreateCustomer> {
  @override
  void initState() {
    // TODO: implement initState
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: leadingAppbar(context),
          backgroundColor: welcome_color,
          centerTitle: true,
          title: Text(
            "Tạo khách hàng",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w500, fontSize: 22),
          ),
        ),
        body: SingleChildScrollView(
            child: new formUpdateProfile(
              check: true,
          isCustomer: false,
          isUpdate: false,
          isCreate: true,
          birthday: DateTime.now(),
        )));
  }
}
