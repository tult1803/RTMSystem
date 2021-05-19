import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InvoicePage extends StatefulWidget {
  const InvoicePage({Key key}) : super(key: key);

  @override
  _InvoicePageState createState() => _InvoicePageState();
}

class _InvoicePageState extends State<InvoicePage> {
  var currentDate = new DateTime.now();
  var formatter = new DateFormat('dd-MM-yyyy');

  Future<void> _selectDate(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(2015),
        lastDate: DateTime(2050));
    if (pickedDate != null && pickedDate != currentDate)
      setState(() {
        currentDate = pickedDate;
      });
  }

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
          margin: EdgeInsets.only(top: 12, left: 12, right: 12),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RaisedButton(
                          onPressed: () => {
                            // chuyển đến trang cần xử lý
                          },
                          child: Row(
                            children: [
                              Column(children: [
                                Icon(Icons.access_time_outlined),
                              ],),
                              Column(children: [ Text('  ')],),
                              Column(
                                children: [
                                Text('Chờ xử lý'),
                              ],),
                            ],
                          ),
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation: 10,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          RaisedButton(
                            onPressed: () => _selectDate(context),
                            child: Text(formatter.format(currentDate)),
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            elevation: 10,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 12,
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 10,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      title: Text('10,000,000'),
                      subtitle: Text('20/04/2021'),
                      trailing: Text('Chưa trả'),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
