import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rtm_system/ultils/button.dart';
import 'package:rtm_system/view/customer/invoice/detail_invoice.dart';

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
      body: SingleChildScrollView(
        child: Container(
            margin: EdgeInsets.only(top: 12, ),
            child: Column(
              children: [
                _showProcessDate(),
                SizedBox(
                  height: 12,
                ),
                _cardInvoice(
                    'Mủ nước', '20/04/2021', '10,000,000', 'chưa trả'),
                _showBottomButton(),
              ],
            )),
      )
    );
  }

  Widget _cardInvoice(
      String product, String date, String price, String status) {
    return FlatButton(onPressed: (){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => DetailInvoicePage()),
      );
    }, child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 10,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Text(
              '${product}',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            subtitle: Column(
              children: [
                Row(
                  children: [
                    Text(
                      '${price} VND',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      '${date}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF0BB791),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            trailing: Text('${status}'),
          ),
        ],
      ),
    ));
  }

  Widget _showProcessDate() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,          children: [
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
                        Text('Chờ xử lý', style: TextStyle(

                        ),),
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
            elevation: 1
          ),
        ),

        btnLogout(context)
      ],
    );
  }
}
