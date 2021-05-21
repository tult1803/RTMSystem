
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';

class SupportPage extends StatefulWidget {
  const SupportPage({Key key}) : super(key: key);

  @override
  _SupportPageState createState() => _SupportPageState();
}

class _SupportPageState extends State<SupportPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: welcome_color,
        title: Center(
          child: AutoSizeText(
            "Trung tâm hỗ trợ",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w500, fontSize: 22),
          ),
        ),

      ),
      // body: new showAllBill(),
    );
  }
}
