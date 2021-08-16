import 'package:flutter/material.dart';
import 'package:rtm_system/presenter/Manager/debt/show_all_advance_bill.dart';

class AllDebt extends StatefulWidget {
  const AllDebt({Key key}) : super(key: key);

  @override
  _AllDebtState createState() => _AllDebtState();
}

class _AllDebtState extends State<AllDebt> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: showAllBill(),
    );
  }
}
