import 'package:flutter/material.dart';
import 'package:rtm_system/presenter/Customer/show_process_advance.dart';
import 'package:rtm_system/presenter/Customer/show_process_invoice.dart';
class ProcessAdvancePage extends StatefulWidget {
  const ProcessAdvancePage({Key key}) : super(key: key);

  @override
  _ProcessAdvancePageState createState() => _ProcessAdvancePageState();
}



class _ProcessAdvancePageState extends State<ProcessAdvancePage> {
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
          child: new showProcessAdvance(),
        ));
  }

}
