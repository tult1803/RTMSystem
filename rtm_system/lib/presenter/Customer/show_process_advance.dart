import 'package:flutter/material.dart';
import 'package:rtm_system/model/notice/getAPI_all_notice.dart';
import 'package:rtm_system/model/notice/model_all_notice.dart';
import 'package:rtm_system/ultils/commonWidget.dart';
import 'package:rtm_system/ultils/component.dart';
import 'package:shared_preferences/shared_preferences.dart';

class showProcessAdvance extends StatefulWidget {
  const showProcessAdvance({Key key}) : super(key: key);

  @override
  _showProcessAdvanceState createState() => _showProcessAdvanceState();
}

class _showProcessAdvanceState extends State<showProcessAdvance> {
  GetAPIAllNotice getAPIAllNotice = GetAPIAllNotice();
  Notice notice;
  NoticeList noticeListsss;
  List<NoticeList> noticeList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getAPINotice();
  }

  Future getAPINotice() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString('access_token');
    print(token);
    // Đỗ dữ liệu lấy từ api
    // notice = await getAPIAllNotice.getNotices(token);
    noticeList = notice.noticeList;
    return noticeList;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: size.width,
      child: new FutureBuilder(
        future: getAPINotice(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return btnProcess(
                    context,
                    snapshot.data[index].id,
                    snapshot.data[index].title,
                    snapshot.data[index].content,
                    "${snapshot.data[index].createDate}",
                    false);
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