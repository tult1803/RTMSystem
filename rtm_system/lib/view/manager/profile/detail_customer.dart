import 'package:flutter/material.dart';
import 'package:rtm_system/ultils/commonWidget.dart';
import 'package:rtm_system/ultils/component.dart';
import 'package:rtm_system/ultils/helpers.dart';

class DetailCustomer extends StatefulWidget {
  final Map<String, dynamic> map;
  final String token;
  DetailCustomer({this.token, this.map});

  @override
  _DetailCustomerState createState() => _DetailCustomerState();
}

class _DetailCustomerState extends State<DetailCustomer> {
  int id, accountId, advance, statusId;
  String cmnd, fullName, phone, birthday, address, gender, status;
  String vip;

  Future _getData(){
    setState(() {
      id = this.widget.map["id"];
      statusId = this.widget.map["status_id"];
      status = '${getStatus(status: this.widget.map["status_id"])}';
      accountId = this.widget.map["account_id"];
      advance = this.widget.map["advance"];
      cmnd = this.widget.map["cmnd"];
      fullName = this.widget.map["fullname"];
      phone = this.widget.map["phone"];
      birthday = this.widget.map["birthday"];
      address = this.widget.map["address"];
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    _getData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: SingleChildScrollView(
          child: containerDetail(context,
            componentContainerDetailCustomer(
                context,
              token: this.widget.token,
              account_id: accountId,
              fullname: fullName,
              address: address,
              advance: advance,
              birthday: birthday,
              cmnd: cmnd,
              gender: getGender(this.widget.map["gender"]),
              phone: phone,
              status: status,
              vip: getVip(this.widget.map["vip"]),
              statusId: statusId,
            ),
          )),
    );
  }
}