import 'package:flutter/material.dart';
import 'package:rtm_system/ultils/component.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';
import 'package:rtm_system/view/create_invoice.dart';

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
      // body: CreateInvoicePage(isNew: false, idProduct: "1",)
    );
  }
}
