import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rtm_system/ultils/button.dart';
import 'package:rtm_system/view/manager/processBill.dart';

class showAllBill extends StatefulWidget {
  const showAllBill({Key key}) : super(key: key);

  @override
  _showAllBillState createState() => _showAllBillState();
}

class _showAllBillState extends State<showAllBill> {
  var fDate = new DateFormat('dd-MM-yyyy');
  DateTime _nowDate;
  DateTime _lastDate;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _nowDate = DateTime.now();
    _lastDate = DateTime.now().subtract(Duration(days: -1));
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: size.width,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              btnMain(context, "Đơn chờ xử lý", Icon(Icons.update), processBill()),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  btnDateTime(context, "${fDate.format(_nowDate)}",
                      Icon(Icons.date_range)),
                  SizedBox(
                    width: 20,
                    child: Center(
                        child: Container(
                            alignment: Alignment.topCenter,
                            height: 45,
                            child: Text(
                              "-",
                              style: TextStyle(fontSize: 20),
                            ))),
                  ),
                  btnDateTime(context, "${fDate.format(_lastDate)}",
                      Icon(Icons.date_range)),
                ],
              ),
              Expanded(child: Container(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      card(context, "Lê Thanh Tú", "Trạng thái", "Hoàn thành", "10000000", "2021-05-20", Colors.green),
                      card(context, "Nguyen Thị C", "Trạng thái", "Trễ", "10000000", "2021-05-20", Colors.redAccent),
                      card(context, "Lê Thanh Tú", "Trạng thái", "Chờ", "10000000", "2021-05-20", Colors.orangeAccent),
                      card(context, "Lê Thanh Tú", "Trạng thái", "Hoàn thành", "10000000", "2021-05-20", Colors.green),
                      card(context, "Lê Thanh Tú", "Trạng thái", "Hoàn thành", "10000000", "2021-05-20", Colors.green),
                    ],
                  ),
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}