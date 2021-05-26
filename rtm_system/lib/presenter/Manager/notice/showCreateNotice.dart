import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rtm_system/ultils/commonWidget.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';

class showCreateNotice extends StatefulWidget {
  const showCreateNotice({Key key}) : super(key: key);

  @override
  _showCreateNoticeState createState() => _showCreateNoticeState();
}

class _showCreateNoticeState extends State<showCreateNotice> {
  String tittle="", description="";
  var fDate = new DateFormat('dd-MM-yyyy');

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Card(
              margin: EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black, width: 1),
                ),
                width: size.width,
                // height: 300,
                child: Container(
                  margin: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _txt("Tiêu đề"),
                      _txtfield('Nhập tiêu đề', 3, 1, 0),
                      SizedBox(
                        height: 10,
                      ),
                      _txt("Nội dung"),
                      _txtfield('Nhập nội dung', 10, 1, 1),
                      SizedBox(
                        height: 10,
                      ),
                      _txt("Ngày tạo: ${fDate.format(DateTime.now())}")
                    ],
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                btnSubmitOrCancel(context, 140, 40, Colors.redAccent, "Hủy",
                    tittle, description, null,false, 3),
                SizedBox(width: 20),
                btnSubmitOrCancel(context, 140, 40, welcome_color, "Tạo",
                    tittle, description, "Tiêu để đang bị để trống.",true, 3),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _txt(String tittle) {
    return Container(
      child: Text(
        tittle,
        style: TextStyle(color: Colors.black54),
      ),
    );
  }

  Widget _txtfield(String hintText, int maxLines, int minLines, int check) {
    return Container(
      child: TextField(
        onChanged: (value) {
          if (check == 0) {
            setState(() {
              tittle = value;
            });
            print('_txtfield Tittle: $tittle');
          } else {
            setState(() {
              description = value;
            });
            print('_txtfield Content: $description');
          }
        },
        maxLines: maxLines,
        keyboardType: TextInputType.text,
        style: TextStyle(fontSize: 15),
        cursorColor: welcome_color,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: '$hintText',
            //Sau khi click vào "Nhập tiêu đề" thì màu viền sẽ đổi
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: welcome_color),
            ),
            contentPadding: EdgeInsets.all(10)),
      ),
    );
  }
}

