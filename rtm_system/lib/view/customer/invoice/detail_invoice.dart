import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rtm_system/ultils/button.dart';

class DetailInvoicePage extends StatefulWidget {
  const DetailInvoicePage({Key key}) : super(key: key);

  @override
  _DetailInvoicePageState createState() => _DetailInvoicePageState();
}

class _DetailInvoicePageState extends State<DetailInvoicePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0BB791),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(30.0),
        child: AppBar(
          backgroundColor: Color(0xFF0BB791),
          elevation: 0,
        ),
      ),
      body: widgetContentInvoice(context, ''),
    );
  }
}
