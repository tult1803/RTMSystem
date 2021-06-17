import 'package:flutter/material.dart';
import 'package:rtm_system/presenter/Manager/invoice/showAllInvoice.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';

class AllInvoice extends StatefulWidget {
  const AllInvoice({Key key}) : super(key: key);

  @override
  _AllInvoiceState createState() => _AllInvoiceState();
}

class _AllInvoiceState extends State<AllInvoice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: welcome_color,
        title: Center(
          child: Text(
            "Quản lý hóa đơn",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w500, fontSize: 22),
          ),
        ),
      ),
      body: new showAllInvoice(),
    );
  }
}
