import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:rtm_system/helpers/component.dart';
import 'package:rtm_system/presenter/Manager/notice/show_notice_manager.dart';
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
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: welcome_color,
        centerTitle: true,
        title: titleAppBar("Thông báo")
      ),
      body:  Container(
         margin: EdgeInsets.fromLTRB(0, 24, 0, 0),
         decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.0),
            topRight: Radius.circular(15.0),
          ),
        ),
        child: showAllNotice()),
      floatingActionButton: new FloatingActionButton(
        //
        onPressed: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => createNotice())),
        child: new Icon(
          Icons.notification_add_outlined,
          color: Colors.white,
          size: 30,
        ),
        elevation: 2,
      ),

    );
  }
}

