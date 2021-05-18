import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
                child: Text(
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
          onPressed: () {},
        ),
      ),
    ],
  );
}


Widget card(BuildContext context, String tittle, String type,String price, String date) {
  //Format lại giá
  final oCcy = new NumberFormat("#,##0", "en_US");
  //Lấy size của màn hình
  var size = MediaQuery.of(context).size;
  return Card(
    margin: EdgeInsets.only(top: 25),
    color: Colors.white,
    shape: RoundedRectangleBorder(
      side: BorderSide(color: Colors.black, width: 0.5),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Container(
      height: 80,
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10)),
            ),
            alignment: Alignment.centerLeft,
            width: size.width * 0.3,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: componentCard(tittle, "Loại: ${type}", CrossAxisAlignment.start),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
              ),
              child: componentCard("${oCcy.format(double.parse(price))}đ", date, CrossAxisAlignment.end),
            ),
          ),
          SizedBox(width: 10,),
          TextButton(
              onPressed: () {
                // Navigate here
              },
              child: Container(
                  height: size.height,
                  child: Center(
                    child: Text("Chi tiết",
                        style: TextStyle(color: Colors.black54)),
                  ))),
        ],
      ),
    ),
  );
}
