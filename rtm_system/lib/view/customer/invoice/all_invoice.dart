import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:rtm_system/ultils/button.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';

class InvoicePage extends StatefulWidget {
  const InvoicePage({Key key}) : super(key: key);

  @override
  _InvoicePageState createState() => _InvoicePageState();
}

class _InvoicePageState extends State<InvoicePage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xffEEEEEE),
      appBar: AppBar(
        backgroundColor: Color(0xFF0BB791),
        title: Center(
          child: Text("Tất cả hóa đơn"),
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 0, left: 20, right: 20),
        height: size.height,
        width: size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              cardProduct(
                  context, "Mủ nước", "Mủ lỏng", "100000", "17-05-2021"),
              cardProduct(context, "Mủ dây", "Mủ đặc", "165323", "17-05-2021"),
              cardProduct(context, "Mủ ké", "Mủ đặc", "90776", "17-05-2021"),
              cardProduct(context, "Mủ đất", "Mủ đặc", "100000", "17-05-2021"),
              cardProduct(context, "Mủ chén", "Mủ đặc", "265378", "17-05-2021"),
              cardProduct(context, "Mủ đông", "Mủ đặc", "1000", "17-05-2021"),
              cardProduct(context, "Mủ nước", "Mủ đặc", "10000", "17-05-2021"),
            ],
          ),
        ),
      ),
    );
  }

  Widget getListInvoice() {
    var size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          children: [
            Text(
              "1000000",
              style: TextStyle(
                fontWeight: FontWeight.w500,
              ),
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.left,
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        SizedBox(
          width: size.width,
          child: Text(
            "20/05/2020",
            style: TextStyle(
              fontSize: 14,
            ),
            textAlign: TextAlign.left,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Expanded(
          child: Container(
            alignment: Alignment.centerRight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
            ),
            child: Text(
              "20/05/2020",
              style: TextStyle(
                fontSize: 14,
              ),
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
  }
}
