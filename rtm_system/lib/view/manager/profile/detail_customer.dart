import 'package:flutter/material.dart';
import 'package:rtm_system/ultils/commonWidget.dart';
import 'package:rtm_system/ultils/component.dart';
import 'package:rtm_system/ultils/getStatus.dart';

class DetailCustomer extends StatefulWidget {
  final Map<String, dynamic> map;

  DetailCustomer({this.map});

  @override
  _DetailCustomerState createState() => _DetailCustomerState();
}

class _DetailCustomerState extends State<DetailCustomer> {
  int id, account_id, advance, statusId;
  String cmnd, fullname, phone, birthday, address, gender, status;
  String vip;

  Future _getData(){
    setState(() {
      id = this.widget.map["id"];
      statusId = this.widget.map["status_id"];
      status = '${getStatus(status: this.widget.map["status_id"])}';
      account_id = this.widget.map["account_id"];
      advance = this.widget.map["advance"];
      cmnd = this.widget.map["cmnd"];
      fullname = this.widget.map["fullname"];
      phone = this.widget.map["phone"];
      birthday = this.widget.map["birthday"];
      address = this.widget.map["address"];
      if(this.widget.map["vip"]){
        vip = "VIP";
      }else vip = "Thường";
      if(this.widget.map["gender"] == 0){
        gender ="Nữ";
      }else gender = "Nam";
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
              account_id: account_id,
              fullname: fullname,
              address: address,
              advance: advance,
              birthday: birthday,
              cmnd: cmnd,
              gender: gender,
              phone: phone,
              status: status,
              vip: vip,
              statusId: statusId,
            ),
          )),
    );
  }
}