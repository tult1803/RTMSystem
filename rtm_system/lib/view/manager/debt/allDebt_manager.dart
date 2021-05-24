import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';

class AllDebt extends StatefulWidget {
  const AllDebt({Key key}) : super(key: key);

  @override
  _AllDebtState createState() => _AllDebtState();
}

class _AllDebtState extends State<AllDebt> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: welcome_color,
        title: Center(
          child: AutoSizeText(
            "Quản lý nợ",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w500, fontSize: 22),
          ),
        ),

      ),
      // body: new showAllBill(),
    );
  }
}
