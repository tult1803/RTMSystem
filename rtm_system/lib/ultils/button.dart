import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../view/customer/notice/detail_notice.dart';
import 'component.dart';
import 'src/color_ultils.dart';

const double defaultBorderRadius = 3.0;

class StretchableButton extends StatelessWidget {
  final VoidCallback onPressed;
  final double borderRadius;
  final double buttonPadding;
  final Color buttonColor, splashColor;
  final Color buttonBorderColor;
  final List<Widget> children;
  final bool centered;

  StretchableButton({
    @required this.buttonColor,
    @required this.borderRadius,
    @required this.children,
    this.splashColor,
    this.buttonBorderColor,
    this.onPressed,
    this.buttonPadding,
    this.centered = false,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        var contents = List<Widget>.from(children);

        if (constraints.minWidth == 0) {
          contents.add(SizedBox.shrink());
        } else {
          if (centered) {
            contents.insert(0, Spacer());
          }
          contents.add(Spacer());
        }

        BorderSide bs;
        if (buttonBorderColor != null) {
          bs = BorderSide(
            color: buttonBorderColor,
          );
        } else {
          bs = BorderSide.none;
        }

        return ButtonTheme(
          height: 40.0,
          padding: EdgeInsets.all(buttonPadding),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: bs,
          ),
          child: RaisedButton(
            onPressed: onPressed,
            color: buttonColor,
            splashColor: splashColor,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: contents,
            ),
          ),
        );
      },
    );
  }
}

//btnMain khong biet de ten gi cho hop ly
// Dung cho 'Cap nhat gia', 'Don cho xu ly', 'Tao thong bao'
Widget btnMain(BuildContext context, String tittle, Icon icon) {
  var size = MediaQuery.of(context).size;
  return Stack(
    children: <Widget>[
      Container(
        margin: EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: button_color,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.black, width: 0.5),
        ),
        height: 35.0,
        width: 150,
        child: Row(children: [
          Container(
              padding: EdgeInsets.only(left: 5),
              height: size.height,
              child: icon),
          Expanded(
              child: Container(
            height: size.height,
            child: Center(
                child: AutoSizeText(
              "$tittle",
              style: TextStyle(fontWeight: FontWeight.w600),
            )),
          ))
        ]),
      ),
      Container(
        decoration: BoxDecoration(
          color: Colors.white10,
          borderRadius: BorderRadius.circular(5),
          // border: Border.all(color: Colors.black, width: 0.5),
        ),
        height: 35.0,
        width: 150,
        child: FlatButton(
          onPressed: () {
            // Code here
          },
        ),
      ),
    ],
  );
}

Widget btnDateTime(BuildContext context, String tittle, Icon icon) {
  var size = MediaQuery.of(context).size;
  return Stack(
    children: <Widget>[
      Container(
        margin: EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: buttonDate_color,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.black, width: 0.5),
        ),
        height: 35.0,
        width: 120,
        child: Row(children: [
          Container(
              padding: EdgeInsets.only(left: 5),
              height: size.height,
              child: icon),
          Expanded(
              child: Container(
                height: size.height,
                child: Center(
                    child: AutoSizeText(
                      "$tittle",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    )),
              ))
        ]),
      ),
      Container(
        decoration: BoxDecoration(
          color: Colors.white10,
          borderRadius: BorderRadius.circular(5),
          // border: Border.all(color: Colors.black, width: 0.5),
        ),
        height: 35.0,
        width: 120,
        child: FlatButton(
          onPressed: () {
            // Code here
          },
        ),
      ),
    ],
  );
}

Widget card(BuildContext context, String tittle, String type, String detailType, String price,
    String date, Color color) {
  //Format lại ngày
  String dateTime = date.substring(8, 10) +
      "-" +
      date.substring(5, 7) +
      "-" +
      date.substring(0, 4);
  //Format lại giá
  final oCcy = new NumberFormat("#,##0", "en_US");
  //Lấy size của màn hình
  var size = MediaQuery.of(context).size;

  return Card(
    margin: EdgeInsets.only(top: 15),
    color: Colors.white,
    shape: RoundedRectangleBorder(
      side: BorderSide(color: Colors.black, width: 0.5),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Container(
      height: 78,
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        onPressed: () {},
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10)),
              ),
              alignment: Alignment.centerLeft,
              width: size.width * 0.5,
              child: Padding(
                padding: const EdgeInsets.only(top: 2.0),
                child: componentCardS(
                    tittle, "${type}", "${detailType}", CrossAxisAlignment.start, color),
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(top: 2.0),
                alignment: Alignment.centerRight,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                ),
                child: componentCardE("${oCcy.format(double.parse(price))}đ",
                    dateTime, CrossAxisAlignment.end, Colors.black54),
              ),
            ),
            // SizedBox(
            //   width: 10,
            // ),
            // TextButton(
            //     onPressed: () {
            //       // Navigate here
            //     },
            //     child: Container(
            //         height: size.height,
            //         child: Center(
            //           child: AutoSizeText("Chi tiết",
            //               style: TextStyle(color: Colors.black54)),
            //         ))),
          ],
        ),
      ),
    ),
  );
}

Widget containerButton(int id, String tittle, String content, String date) {
  //Format lại ngày
  String dateTime = date.substring(11, 16) +
      " " +
      date.substring(8, 10) +
      "-" +
      date.substring(5, 7) +
      "-" +
      date.substring(0, 4);
  return Container(
      margin: EdgeInsets.all(5),
      height: 96,
      child: Material(
        child: TextButton(
          style: TextButton.styleFrom(
            primary: Colors.black, // foreground
            textStyle: TextStyle(
              fontSize: 16,
            ),
          ),
          onPressed: () {
            //Navigate here
            print('Id: $id');
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  AutoSizeText(
                    "$tittle",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              AutoSizeText(
                "$content",
                style: TextStyle(
                  fontSize: 14,
                ),
                textAlign: TextAlign.left,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  AutoSizeText(
                    "$dateTime",
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF0BB791),
                    ),
                    textAlign: TextAlign.left,
                  ),
                  Expanded(
                      child: Container(
                    margin: EdgeInsets.only(right: 10),
                    alignment: Alignment.centerRight,
                    child: AutoSizeText(
                      "Chi tiết",
                      style: TextStyle(fontSize: 10, color: Colors.black54),
                    ),
                  )),
                ],
              ),
              SizedBox(
                height: 9,
              ),
              SizedBox(
                height: 1,
                child: Container(
                  color: Color(0xFFBDBDBD),
                ),
              ),
            ],
          ),
        ),
      ));
}

//Hiện tại đang dùng cho trang "Profile"
Widget buttonProfile(double left, double right, double top, double bottom, String tittle){
  return  Container(
    margin: EdgeInsets.only(left: left ,top: top, right: right, bottom: bottom),
    child: FlatButton(
      onPressed: () {
        // Code here
      },
      child: Column(
        children: [
          Container(
            child:Row(
              children: [
                Expanded(child: Text(tittle, style: TextStyle(color: Colors.black54),)),
                Icon(Icons.arrow_forward_ios_outlined, color:  Colors.black54, size: 15,),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 5),
            color: Colors.black45,
            height: 1,
          ),
        ],
      ),
    ),
  );
}

Widget containerButton(
    context, int id, String tittle, String content, String date) {
  //Format lại ngày
  String dateTime = date.substring(8, 10) +
      "-" +
      date.substring(5, 7) +
      "-" +
      date.substring(0, 4) +
      "-" +
      date.substring(11, 16);
  return Container(
      margin: EdgeInsets.all(5),
      height: 96,
      child: Material(
        child: TextButton(
          style: TextButton.styleFrom(
            primary: Colors.black, // foreground
            textStyle: TextStyle(
              fontSize: 16,
            ),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DetailOfNotice( titleNotice: tittle, contentNotice: content,)),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  AutoSizeText(
                    "$tittle",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              AutoSizeText(
                "$content",
                style: TextStyle(
                  fontSize: 14,
                ),
                textAlign: TextAlign.left,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  AutoSizeText(
                    "$dateTime",
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF0BB791),
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
              SizedBox(
                height: 9,
              ),
              SizedBox(
                height: 1,
                child: Container(
                  color: Color(0xFFBDBDBD),
                ),
              ),
            ],
          ),
        ),
      ));
}
// Dùng cho đăng xuất, xóa thông tin.
Widget btnLogout(){
  return Center(
      child: Container(
        child: FlatButton(
            onPressed: () {
              //Code here
            },
            child: Text("Đăng xuất", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),)),
      ));
}
