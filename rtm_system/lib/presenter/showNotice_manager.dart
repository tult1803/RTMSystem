import 'package:flutter/material.dart';
import 'package:rtm_system/model/notice/getAPI_all_notice.dart';
import 'package:rtm_system/model/notice/model_all_notice.dart';
import 'package:rtm_system/ultils/button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class showAllNotice extends StatefulWidget {
  const showAllNotice({Key key}) : super(key: key);

  @override
  _showAllNoticeState createState() => _showAllNoticeState();
}

class _showAllNoticeState extends State<showAllNotice> {
  String token = "";
  List<NoticeList> noticeList;

  Future _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString("access_token");
    });
  }

  Future _getNotice() async {
    GetAPIAllNotice getAPIAllNotice = GetAPIAllNotice();
    Notice notice;
    if (token.isNotEmpty) {
      // Đỗ dữ liệu lấy từ api
      notice = await getAPIAllNotice.getNotices(token);
      noticeList = notice.noticeList;
      return noticeList;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getToken();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: size.width,
      child: new FutureBuilder(
        future: _getNotice(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return containerButton(context,
                    snapshot.data[index].id,
                    snapshot.data[index].title,
                    snapshot.data[index].content,
                    "${snapshot.data[index].createDate}");
              },
            );
          }
          return Container(
              height: size.height * 0.7,
              child: Center(child: CircularProgressIndicator()));
        },
      ),
    );
  }
}
