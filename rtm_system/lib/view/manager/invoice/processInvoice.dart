import 'package:flutter/material.dart';
import 'package:rtm_system/ultils/component.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';

class processInvoice extends StatefulWidget {


  @override
  _processInvoiceState createState() => _processInvoiceState();
}

class _processInvoiceState extends State<processInvoice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: leadingAppbar(context),
        centerTitle: true,
        backgroundColor: welcome_color,
        title: Text(
          "Hóa đơn chờ xử lý",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w500, fontSize: 22),
        ),
      ),
      body: Center(child: new Text("Hóa đơn chờ xử lý")),
    );
  }
}
