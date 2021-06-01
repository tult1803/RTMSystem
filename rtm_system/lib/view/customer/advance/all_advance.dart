import 'dart:ui';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rtm_system/presenter/Customer/show_all_advance.dart';
import 'package:rtm_system/ultils/commonWidget.dart';
import 'package:rtm_system/ultils/component.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';
import 'package:rtm_system/view/customer/advance/create_request_advance.dart';

class AdvancePage extends StatefulWidget {
  const AdvancePage({Key key, this.money}) : super(key: key);
  final String money;

  @override
  _AdvancePageState createState() => _AdvancePageState();
}

class _AdvancePageState extends State<AdvancePage> {
  int index = 1;
  var currentDate = new DateTime.now();
  var formatter = new DateFormat('dd-MM-yyyy');
  DateTime fromDate;
  DateTime toDate;
  String search = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    toDate = DateTime.now();
    fromDate = DateTime.now().subtract(Duration(days: 2));
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
                Container(
                  margin: EdgeInsets.only(top: 12, bottom: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _txtFormField(this.search, false, "Nhập mã hoá đơn", 1,
                          TextInputType.text),
                      btnWaitingProcess(context, index),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    btnDateTime(context, "${formatter.format(fromDate)}",
                        Icon(Icons.date_range), datePick()),
                    SizedBox(
                      child: Center(
                          child: Container(
                              alignment: Alignment.topCenter,
                              height: 20,
                              child: Text(
                                "-",
                                style: TextStyle(fontSize: 20),
                              ))),
                    ),
                    btnDateTime(context, "${formatter.format(toDate)}",
                        Icon(Icons.date_range), datePick()),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                _showBottomButton(),
                SizedBox(
                  height: 5,
                ),
                showAdvance(),
              ],
            )),
      ),
    );
  }

  Widget datePick() {
    return TextButton(
      onPressed: () {
        setState(() {
          pickedDate();
        });
      },
    );
  }

  Future pickedDate() async {
    final initialDateRange = DateTimeRange(start: fromDate, end: toDate);
    final ThemeData theme = Theme.of(context);
    DateTimeRange dateRange = await showDateRangePicker(
        context: context,
        firstDate: DateTime(2000),
        lastDate: DateTime.now(),
        initialDateRange: initialDateRange,
        saveText: "Xác nhận",
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
                //Dùng cho nút "X" của lịch
                appBarTheme: AppBarTheme(
                  iconTheme:
                      theme.primaryIconTheme.copyWith(color: Colors.white),
                ),
                //Dùng cho nút chọn ngày và background
                colorScheme: ColorScheme.light(
                  primary: welcome_color,
                )),
            child: child,
          );
        });
    if (dateRange != null) {
      setState(() {
        fromDate = dateRange.start;
        toDate = dateRange.end;
      });
    }
  }

  Widget btnDateTime(
      BuildContext context, String tittle, Icon icon, Widget widget) {
    var size = MediaQuery.of(context).size;
    return Stack(
      children: <Widget>[
        SizedBox(
          width: 140,
          child: RaisedButton(
            color: Colors.white70,
            onPressed: () {},
            child: Text('$tittle'),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 10,
          ),
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
                color: Colors.white70,
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

  Widget _txtFormField(String value, bool obscureText, String hintText,
      int maxLines, TextInputType txtType) {
    return SizedBox(
      width: 250,
      child: TextFormField(
        initialValue: value,
        obscureText: obscureText,
        onChanged: (value) {
          setState(() {
            this.search = value.trim();
          });
        },
        maxLines: maxLines,
        keyboardType: txtType,
        style: TextStyle(fontSize: 15),
        cursorColor: welcome_color,
        decoration: InputDecoration(
          border: UnderlineInputBorder(),
          hintText: '$hintText',
          //Sau khi click vào "Nhập tiêu đề" thì màu viền sẽ đổi
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: welcome_color),
          ),
          //Hiển thị Icon góc phải
          suffixIcon: Icon(
            Icons.search,
            color: Colors.black54,
          ),

          contentPadding: EdgeInsets.all(15),
        ),
      ),
    );
  }
}
