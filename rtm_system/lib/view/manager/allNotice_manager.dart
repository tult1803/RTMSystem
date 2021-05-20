import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:rtm_system/presenter/showNotice_manager.dart';
import 'package:rtm_system/ultils/button.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';

class AllNotice extends StatefulWidget {
  const AllNotice({Key key}) : super(key: key);

  @override
  _AllNoticeState createState() => _AllNoticeState();
}

class _AllNoticeState extends State<AllNotice> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: welcome_color,
        title: Center(
          child: AutoSizeText(
            "Quản lý thông báo",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w500, fontSize: 25),
          ),
        ),
        bottom: PreferredSize(
            child: btnMain(
                context, "Tạo thông báo", Icon(Icons.notifications_outlined)),
            preferredSize: Size.fromHeight(60.0)),
      ),
      body: new showAllNotice(),
    );
  }
}

