import 'package:flutter/material.dart';
import 'package:rtm_system/presenter/Customer/show_Notice.dart';
class NoticesPage extends StatefulWidget {
  const NoticesPage({Key key}) : super(key: key);

  final String title = "Thông báo";

  @override
  _NoticesPageState createState() => _NoticesPageState();
}

class _NoticesPageState extends State<NoticesPage> {
  @override
  Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Color(0xffEEEEEE),
        appBar: AppBar(
          backgroundColor: Color(0xFF0BB791),
          title: Text(widget.title, style: TextStyle(
            color: Colors.white,
          ),),
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
          child: new showNotice(),
        ));
  }

}
