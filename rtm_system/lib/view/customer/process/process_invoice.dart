import 'package:flutter/material.dart';
import 'package:rtm_system/presenter/Customer/show_process_invoice.dart';
class ProcessInvoicePage extends StatefulWidget {
  const ProcessInvoicePage({Key key}) : super(key: key);
  @override
  _ProcessInvoicePageState createState() => _ProcessInvoicePageState();
}



class _ProcessInvoicePageState extends State<ProcessInvoicePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffEEEEEE),
        body: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0),
              topRight: Radius.circular(15.0),
            ),
          ),
          child: new showProcessInvoice(),
        ));
  }

}