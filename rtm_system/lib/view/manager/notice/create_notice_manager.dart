import 'package:flutter/material.dart';
import 'package:rtm_system/presenter/Manager/notice/show_create_notice.dart';
import 'package:rtm_system/helpers/component.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';

// ignore: camel_case_types
class createNotice extends StatefulWidget {
  const createNotice({Key key}) : super(key: key);

  @override
  _createNoticeState createState() => _createNoticeState();
}

// ignore: camel_case_types
class _createNoticeState extends State<createNotice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: leadingAppbar(context),
        centerTitle: true,
        backgroundColor: welcome_color,
        title: titleAppBar("Tạo thông báo"),
      ),
      body: SingleChildScrollView(child: new showCreateNotice()),
    );
  }
}
