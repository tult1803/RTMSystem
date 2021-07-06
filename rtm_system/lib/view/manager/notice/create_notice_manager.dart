import 'package:flutter/material.dart';
import 'package:rtm_system/presenter/Manager/notice/show_create_notice.dart';
import 'package:rtm_system/helpers/component.dart';
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
        leading: leadingAppbar(context),
        centerTitle: true,
        backgroundColor: welcome_color,
        title:  Text(
            "Tạo thông báo",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w500, fontSize: 22),
        ),
      ),
      body: SingleChildScrollView(child: new showCreateNotice()),
    );
  }
}
