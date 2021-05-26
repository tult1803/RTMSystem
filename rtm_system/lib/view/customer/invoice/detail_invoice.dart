import 'package:flutter/material.dart';
import 'package:rtm_system/ultils/component.dart';

class DetailInvoicePage extends StatefulWidget {
  const DetailInvoicePage({Key key}) : super(key: key);

  @override
  _DetailInvoicePageState createState() => _DetailInvoicePageState();
}

class _DetailInvoicePageState extends State<DetailInvoicePage> {
  String status = 'Chưa trả';
  String header;
  void _showHeader(){
    if( status == 'Chờ xác nhận'){
      setState(() {
        header = 'Xác nhận thông tin giao dịch';
      });
    } else {
      setState(() {
        header = 'Giao dịch thành công';
      });
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this._showHeader();
  }
  // Chờ xác nhận
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
      body: widgetContentInvoice(context, status, header),
    );
  }
}
