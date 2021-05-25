import 'package:flutter/material.dart';
import 'package:rtm_system/ultils/getData.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';

class processCreateCustomer extends StatefulWidget {
  final String _tittle;
  final List _listCustomer;
  processCreateCustomer(this._tittle, this._listCustomer);

  @override
  _processCreateCustomerState createState() => _processCreateCustomerState();
}

class _processCreateCustomerState extends State<processCreateCustomer> {
  String fullname, phone, cmnd, address, password, birthday;
  int gender;

  Future<void> _getData() {
    setState(() {
      fullname = this.widget._listCustomer[0];
      gender = this.widget._listCustomer[1];
      phone = this.widget._listCustomer[2];
      cmnd = this.widget._listCustomer[3];
      address = this.widget._listCustomer[4];
      password = this.widget._listCustomer[5];
      birthday = this.widget._listCustomer[6];
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20, bottom: 20),
      width: 200,
      height: 40,
      decoration: BoxDecoration(
        color: welcome_color,
        borderRadius: BorderRadius.circular(5),
      ),
      child: TextButton(
          onPressed: () {
            doCreateCustomer(context, phone, password, fullname, gender, cmnd, address, birthday, 4);
          },
          child: Text(
            "${this.widget._tittle}",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w500, fontSize: 18),
          )),
    );
  }
}
