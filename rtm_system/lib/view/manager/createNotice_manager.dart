import 'package:flutter/material.dart';
import 'package:rtm_system/presenter/Manager/showCreateNotice.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';

class createNotice extends StatefulWidget {
  const createNotice({Key key}) : super(key: key);

  @override
  _createNoticeState createState() => _createNoticeState();
}

class _createNoticeState extends State<createNotice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: welcome_color,
        title: Center(
          child: Text(
            "Tạo thông báo",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w500, fontSize: 22),
          ),
        ),
      ),
      body: new showCreateNotice(),
    );
  }
}
