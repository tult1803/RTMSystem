import 'package:flutter/material.dart';
import 'package:rtm_system/helpers/component.dart';
import 'package:rtm_system/presenter/Customer/show_Notice.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';

class NoticesPage extends StatefulWidget {
  const NoticesPage({Key key}) : super(key: key);
  @override
  _NoticesPageState createState() => _NoticesPageState();
}

class _NoticesPageState extends State<NoticesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: titleAppBar("Thông báo"),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(0, 24, 0, 0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.0),
            topRight: Radius.circular(15.0),
          ),
        ),
        child: showNotice(),
      ),
    );
  }
}
