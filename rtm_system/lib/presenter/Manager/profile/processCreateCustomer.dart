import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rtm_system/ultils/getData.dart';
import 'package:rtm_system/ultils/helpers.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';

class processCreateCustomer extends StatefulWidget {
  final String tittle, account_id;
  final List listCustomer;
  final bool isCustomer, isUpdate, isCreate;
  final int typeOfUpdate;
  processCreateCustomer({this.tittle, this.listCustomer, this.isCustomer, this.isUpdate,this.typeOfUpdate, this.account_id, this.isCreate});

  @override
  _processCreateCustomerState createState() => _processCreateCustomerState();
}

class _processCreateCustomerState extends State<processCreateCustomer> {
  String fullname, phone, cmnd, address, password;
  DateTime birthday;
  int gender;
  final fBirthday = new DateFormat('yyyy-MM-dd');
  Future<void> _getData() {
    setState(() {
      fullname = this.widget.listCustomer[0];
      gender = this.widget.listCustomer[1];
      phone = this.widget.listCustomer[2];
      cmnd = this.widget.listCustomer[3];
      address = this.widget.listCustomer[4];
      password = this.widget.listCustomer[5];
      birthday = this.widget.listCustomer[6];
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
            doCreateCustomer(context, phone, password, fullname, gender, cmnd, address, "${getDateTime("$birthday", dateFormat: 'yyyy-MM-dd')}", this.widget.isCustomer, this.widget.isUpdate, this.widget.typeOfUpdate,this.widget.account_id, isCreate: this.widget.isCreate);
          },
          child: Text(
            "${this.widget.tittle}",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w500, fontSize: 18),
          )),
    );
  }
}
