import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rtm_system/ultils/src/color_ultils.dart';
import 'package:rtm_system/ultils/src/url_api.dart';
import 'package:rtm_system/view/customer/notice/detail_notice.dart';
import 'package:rtm_system/model/notice/getAPI_all_notice.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NoticesPage extends StatefulWidget {
  final String title = "Thông báo";

  @override
  _NoticesPageState createState() => _NoticesPageState();
}
//
// GetAPIAllNotice getAPIAllNotice = GetAPIAllNotice();
// Notice data;

class _NoticesPageState extends State<NoticesPage> {
  // Future<Notice> getAllNotice;
  String noticeList, total;
  String access_token = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getAPINotice();
    print('alo');
  }
  int status;
  Future getAPINotice() async {
    // Đỗ dữ liệu lấy từ api
    var data = await http.get(
      Uri.http('${url_main}', '${url_notice}'),
    );
    print('result is'+'${data.statusCode}');
    status = await GetAPIAllNotice.status;
    // setState(() {
    //   noticeList = data.noticeList;
    //   total = data.total;
    //   access_token = data.access_token;
    //
    // });
  }

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
                children: [
                  Container(
                    child: _getNotice(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
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
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => DetailOfNotice()),
                (route) => false);
          },
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    // "${data.noticeList}",
                    'ha',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'TextButton with custom TextButton with custom TextButton with custom',
                style: TextStyle(
                  fontSize: 14,
                ),
                textAlign: TextAlign.left,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    '17/05/2021',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF0BB791),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 1,
                child: Container(
                  color: Color(0xFFBDBDBD),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
