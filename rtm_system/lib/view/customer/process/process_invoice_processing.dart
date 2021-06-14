import 'package:flutter/material.dart';
import 'package:rtm_system/presenter/Customer/show_all_invoice.dart';
class ProcessInvoiceProcessing extends StatefulWidget {
  const ProcessInvoiceProcessing({Key key}) : super(key: key);
  @override
  _ProcessInvoiceProcessingState createState() => _ProcessInvoiceProcessingState();
}



class _ProcessInvoiceProcessingState extends State<ProcessInvoiceProcessing> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffEEEEEE),
        body: Container(
          child: new showAllInvoicePage(idProduct:  '0',
            isAll: true, status: 4,from: null,
            to: null,),
        ));
  }

}
