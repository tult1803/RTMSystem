import 'package:flutter/material.dart';
import 'package:rtm_system/model/notice/getAPI_all_notice.dart';
import 'package:rtm_system/model/notice/model_all_notice.dart';
import 'package:rtm_system/ultils/button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class showNotice extends StatefulWidget {
  const showNotice({Key key}) : super(key: key);

  @override
  _showNoticeState createState() => _showNoticeState();
}

class _showNoticeState extends State<showNotice> {
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
    notice = await getAPIAllNotice.getNotices(token);
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
                return containerButton(
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
