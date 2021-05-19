import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rtm_system/model/notice/model_all_notice.dart';
import 'package:rtm_system/view/customer/notice/detail_notice.dart';
import 'package:rtm_system/model/notice/getAPI_all_notice.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NoticesPage extends StatefulWidget {
  const NoticesPage({Key key}) : super(key: key);

  final String title = "Thông báo";

  @override
  _NoticesPageState createState() => _NoticesPageState();
}

GetAPIAllNotice getAPIAllNotice = GetAPIAllNotice();
Notice notice;
NoticeList noticeListsss;

class _NoticesPageState extends State<NoticesPage> {
  List<NoticeList> noticeList;
  int total;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getAPINotice();
  }

  int status;

  Future getAPINotice() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString('access_token');
    print(token);
    // Đỗ dữ liệu lấy từ api
    notice = await getAPIAllNotice.getNotices(token);
    status = await GetAPIAllNotice.status;
    noticeList = notice.noticeList;
    // setState(() {
    //   noticeList = notice.noticeList;
    //   total = notice.total;
    //   length = notice.noticeList.length;
    // });
    return noticeList;
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Color(0xffEEEEEE),
        appBar: AppBar(
          backgroundColor: Color(0xFF0BB791),
          title: Center(
            child: Text(widget.title),
          ),
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
          child: _getList(),
        ));
  }

  Widget _getList() {
    var size = MediaQuery.of(context).size;
    return FutureBuilder(
      future: getAPINotice(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              itemCount: noticeList.length,
              itemBuilder: (context, index) {
                return _getInfo(size, index);
              });
        }
        return Container(
            height: size.height * 0.7,
            child: Center(child: CircularProgressIndicator()));
      },
    );
  }
  Widget _getInfo(size, index){
    return Container(
      margin: EdgeInsets.fromLTRB(12, 0, 12, 0),
      child: Material(
        child: TextButton(
          style: TextButton.styleFrom(
            primary: Colors.black, // foreground
            textStyle: TextStyle(
              fontSize: 16,
            ),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DetailOfNotice()),);
          },
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    "${noticeList[index].title}",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: size.width,
                child: Text(
                  "${noticeList[index].content}",
                  style: TextStyle(
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    "${noticeList[index].createDate}",
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF0BB791),
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
              SizedBox(
                height: 9,
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
      ),);
  }
}
