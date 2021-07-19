import 'package:flutter/material.dart';
import 'package:rtm_system/helpers/common_widget.dart';
import 'package:rtm_system/helpers/component.dart';
import 'package:rtm_system/model/model_all_customer.dart';
import 'package:rtm_system/ultils/get_data.dart';

class DetailCustomer extends StatefulWidget {
  final CustomerList customerList;
  final String token;
  DetailCustomer({this.token, this.customerList});

  @override
  _DetailCustomerState createState() => _DetailCustomerState();
}

class _DetailCustomerState extends State<DetailCustomer> {
  int id, advance, statusId;
  String cmnd, fullName, phone, birthday, address, gender, status, accountId;

  // ignore: missing_return
  Future _getData(){
    setState(() {
      id = widget.customerList.id;
      statusId = widget.customerList.statusId;
      status = '${getStatus(status: widget.customerList.statusId)}';
      accountId = widget.customerList.accountId;
      advance = widget.customerList.advance;
      cmnd = widget.customerList.cmnd;
      fullName = widget.customerList.fullName;
      phone = widget.customerList.phone;
      birthday = widget.customerList.birthday;
      address = widget.customerList.address;
    });
  }

  @override
  void initState() {
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
              accountId: accountId,
              fullName: fullName,
              address: address,
              advance: advance,
              birthday: birthday,
              cmnd: cmnd,
              gender: getGender(widget.customerList.gender),
              phone: phone,
              status: status,
              level: "${getLevel(level: widget.customerList.level)}",
              statusId: statusId,
            ),
          )),
    );
  }
}