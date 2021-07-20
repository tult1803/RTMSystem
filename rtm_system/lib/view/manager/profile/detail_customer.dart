import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rtm_system/helpers/common_widget.dart';
import 'package:rtm_system/helpers/component.dart';
import 'package:rtm_system/model/model_all_customer.dart';
import 'package:rtm_system/ultils/get_data.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';

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
  String imageCMNDF, imageCMNDB;
  bool needConfirm;

  // ignore: missing_return
  Future _getData() {
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
      imageCMNDB = widget.customerList.cmndBack;
      imageCMNDF = widget.customerList.cmndFront;
      needConfirm = widget.customerList.needConfirm;
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
      child: SingleChildScrollView(
          child: Column(
        children: [
          containerDetail(
              context,
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
                imageCMNDB: imageCMNDB,
                imageCMNDF: imageCMNDF,
                needConfirm: needConfirm,
              ),
              marginBottom: 50,
              marginRight: 10,
              marginLeft: 10,
              marginTop: 15),
        ],
      )),
    );
  }
}
