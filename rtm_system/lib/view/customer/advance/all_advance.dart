import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rtm_system/presenter/Customer/show_all_advance.dart';
import 'package:rtm_system/ultils/component.dart';
import 'package:rtm_system/view/customer/advance/create_request_advance.dart';
import 'package:rtm_system/view/customer/process/process_all.dart';

class AdvancePage extends StatefulWidget {
  const AdvancePage({Key key, this.money}) : super(key: key);
  final String money;

  @override
  _AdvancePageState createState() => _AdvancePageState();
}

class _AdvancePageState extends State<AdvancePage> {
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
    return Scaffold(
      backgroundColor: Color(0xffEEEEEE),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0.0),
        child: AppBar(
          backgroundColor: Color(0xFF0BB791),
          elevation: 0,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
            margin: EdgeInsets.only(
              bottom: 12,
            ),
            child: Column(
              children: [
                headerInvoice(
                    'Ứng tiền', 'Tổng số tiền phải trả', '${widget.money} VND'),
                _showProcessDate(),
                _showBottomButton(),
                showAdvance(),
              ],
            )),
      ),
    );
  }

  Widget _showProcessDate() {
    var size = MediaQuery.of(context).size;
    int index = 1;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: size.width * 0.4,
              child: RaisedButton(
                color: Color(0xFFF8D375),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProcessAllPage(indexPage: index)),
                  );
                },
                child: Row(
                  children: [
                    Column(
                      children: [
                        Icon(Icons.access_time_outlined),
                      ],
                    ),
                    Column(
                      children: [Text('  ')],
                    ),
                    Column(
                      children: [
                        Text(
                          'Chờ xử lý',
                          style: TextStyle(),
                        ),
                      ],
                    ),
                  ],
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 10,
              ),
            ),
            Container(
              width: size.width * 0.4,
              child: RaisedButton(
                onPressed: () => _selectDate(context),
                child: Row(
                  children: [
                    Column(
                      children: [
                        Icon(Icons.calendar_today),
                      ],
                    ),
                    Column(
                      children: [Text('  ')],
                    ),
                    Column(
                      children: [
                        Text(formatter.format(currentDate)),
                      ],
                    ),
                  ],
                ),
                color: Color(0xffEEEEEE),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 10,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _showBottomButton() {
    var size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: size.width * 0.4,
              child: RaisedButton(
                color: Color(0xffEEEEEE),
                onPressed: () {},
                child: Text('Trả nợ'),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 10,
              ),
            ),
            Container(
              width: size.width * 0.4,
              child: RaisedButton(
                  color: Color(0xFF0BB791),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CreateRequestAdvance()),
                    );
                  },
                  child: Text(
                    'Ung tien',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 1),
            ),
          ],
        ),

      ],
    );
  }
}
