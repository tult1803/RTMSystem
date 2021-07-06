import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:rtm_system/presenter/Manager/notice/show_notice_manager.dart';
import 'package:rtm_system/helpers/common_widget.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';
import 'package:rtm_system/view/manager/notice/create_notice_manager.dart';

class AllNotice extends StatefulWidget {
  const AllNotice({Key key}) : super(key: key);

  @override
  _AllNoticeState createState() => _AllNoticeState();
}

class _AllNoticeState extends State<AllNotice> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        backgroundColor: welcome_color,
        title: Center(
          child: AutoSizeText(
            "Thông báo",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w500, fontSize: 25),
          ),
        ),
        bottom: PreferredSize(
            child: btnMain(
                context,150, "Tạo thông báo", Icon(Icons.notifications_outlined), createNotice()),
            preferredSize: Size.fromHeight(60.0)),
      ),
      body: new showAllNotice(),
    );
  }
}
