import 'package:flutter/material.dart';
import 'package:rtm_system/ultils/component.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';

class createInvoice extends StatefulWidget {
  const createInvoice({Key key}) : super(key: key);

  @override
  _createInvoiceState createState() => _createInvoiceState();
}

class _createInvoiceState extends State<createInvoice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: leadingAppbar(context),
        centerTitle: true,
        backgroundColor: welcome_color,
        title: Text(
          "Tạo hóa đơn",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w500, fontSize: 22),
        ),
      ),
      body: Center(child: new Text("Tạo hóa đơn")),
    );
  }
}
