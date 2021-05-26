import 'package:flutter/material.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';

class processBill extends StatefulWidget {
  const processBill({Key key}) : super(key: key);

  @override
  _processBillState createState() => _processBillState();
}

class _processBillState extends State<processBill> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: welcome_color,
        title: Text(
            "Đơn chờ xủ lý",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w500, fontSize: 22),
          ),
      ),
      body: new Container(),
    );
  }
}
