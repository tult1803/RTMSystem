import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rtm_system/presenter/Customer/show_all_advance.dart';
import 'package:rtm_system/ultils/component.dart';

class AdvancePage extends StatefulWidget {
  const AdvancePage({Key key}) : super(key: key);

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
        preferredSize: Size.fromHeight(20.0),
        child: AppBar(
          backgroundColor: Color(0xFF0BB791),
          elevation: 0,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
            margin: EdgeInsets.only(bottom: 12,),
            child: Column(
              children: [
                headerInvoice('Ứng tiền', 'Tổng số tiền phải trả', '37,000,000 VND'),
                _showProcessDate(),
                SizedBox(
                  height: 12,
                ),
                _showBottomButton(),
                showAdvance(),
              ],
            )),
      ),
    );
  }

  Widget _showProcessDate() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 150,
              child: RaisedButton(
                color: Color(0xFFF8D375),
                onPressed: () => {
                  // chuyển đến trang cần xử lý
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
            Text('      '),
            SizedBox(
              width: 150,
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
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 150,
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
            Text('      '),
            SizedBox(
              width: 150,
              child: RaisedButton(
                color: Color(0xFF0BB791),
                onPressed: () {},
                child: Text(
                  'Lấy tiền',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 10,
              ),
            ),
          ],
        ),
        SizedBox(
          width: 320,
          child: RaisedButton(
              color: Color(0xFF0BB791),
              onPressed: () {},
              child: Text(
                'Gửi yêu cầu bán hàng',
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
    );
  }
}
