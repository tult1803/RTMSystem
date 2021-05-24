import 'package:flutter/material.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';

class ProcessCreateCustomer extends StatefulWidget {
  //Chuỗi dữ liệu của list được truyền vào sẽ theo thứ tự sau:
  // fullname, gender, phone, CMND, address, username, password
  final List listCustomer;

  ProcessCreateCustomer(this.listCustomer);

  @override
  _ProcessCreateCustomerState createState() => _ProcessCreateCustomerState();
}

class _ProcessCreateCustomerState extends State<ProcessCreateCustomer> {
  String fullname, phone, cmnd, address, username, password, birthday;
  int gender;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('List create customer: ${this.widget.listCustomer}');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Phiếu xác nhận"),
        backgroundColor: welcome_color,
      ),
      body: Container(
        color: welcome_color,
      ),
    );
  }
}
