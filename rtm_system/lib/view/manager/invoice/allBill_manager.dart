import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:rtm_system/presenter/Manager/invoice/showBill_manager.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';

class AllBill extends StatefulWidget {
  const AllBill({Key key}) : super(key: key);

  @override
  _AllBillState createState() => _AllBillState();
}

class _AllBillState extends State<AllBill> {
  String allMoney = "500.000.000đ";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: welcome_color,
        title: Center(
          child: AutoSizeText(
            "Quản lý ứng tiền",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w500, fontSize: 22),
          ),
        ),
        bottom: PreferredSize(
            child:  Expanded(
              child: AutoSizeText(
                allMoney,
                style: TextStyle(fontSize: 30, color: Colors.white),
              ),
            ),
            preferredSize: Size.fromHeight(60.0)),
      ),
      body: new showAllBill(),
    );
  }
}