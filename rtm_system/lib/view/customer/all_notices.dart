import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';

class NoticesPage extends StatefulWidget {
  final String title = "Thông báo";

  @override
  _NoticesPageState createState() => _NoticesPageState();
}

class _NoticesPageState extends State<NoticesPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isGetAllNotice();
  }

  void _isGetAllNotice() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF0BB791),
          title: Center(
            child: Text(widget.title),
          ),
        ),
        body: Container(
          color: Color(0xffEEEEEE),
          child: Container(
            // color: Color(0xffEEEEEE),
            margin: EdgeInsets.fromLTRB(0, 24, 0, 0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.0),
                topRight: Radius.circular(15.0),
              ),
            ),
            child: Center(
              child: SafeArea(
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: _getNotice(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  Widget _getNotice() {
    return Container(
      margin: EdgeInsets.fromLTRB(12, 20, 12, 0),
      child: Material(
          child: TextButton(
              style: TextButton.styleFrom(
                primary: Colors.black, // foreground
                textStyle: TextStyle(
                  fontSize: 16,
                ),
              ),
              onPressed: () {

              },
              child: Column(
                children: [
                  Row(children: [
                    Text(
                      'TextButton with custom foregroundTextButton',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],),
                  SizedBox(height: 10,),
                  Row(children: [
                    Text(
                      'TextButton with custom foregroundTextButton with cu',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ],),
                  SizedBox(height: 10,),
                  Row(children: [
                    Text(
                      '17/05/2021',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF0BB791),
                      ),
                    ),
                  ],),
                  SizedBox(height: 10,),
                  SizedBox(height: 1, child: Container(
                    color: Color(0xFFBDBDBD),
                  ),),
                ],
              )

              // onPressed: () {
              //   setState(() {
              //     _buttonState = ButtonState.inProgress;
              //     afterLogin();
              //   });
              // },
              )),
    );
  }
}
