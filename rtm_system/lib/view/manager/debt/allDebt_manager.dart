import 'package:flutter/material.dart';
import 'package:rtm_system/presenter/Manager/debt/showAllAdvanceBill.dart';

class AllDebt extends StatefulWidget {
  const AllDebt({Key key}) : super(key: key);

  @override
  _AllDebtState createState() => _AllDebtState();
}

class _AllDebtState extends State<AllDebt> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new showAllBill(),
      // floatingActionButton: new FloatingActionButton(
      //   onPressed: () {
      //
      //   },
      //   child: new Icon(
      //     Icons.error,
      //     color: Colors.white,
      //     size: 30,
      //   ),
      //   elevation: 2,
      // ),
    );
  }
}
