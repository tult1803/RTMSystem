import 'package:flutter/material.dart';
import 'package:rtm_system/model/notice/getAPI_all_notice.dart';
import 'package:rtm_system/model/notice/model_all_notice.dart';
import 'package:rtm_system/view/customer/advance/detail_advance.dart';
import 'package:rtm_system/view/customer/invoice/detail_invoice.dart';
import 'package:shared_preferences/shared_preferences.dart';

class showAdvance extends StatefulWidget {
  const showAdvance({Key key}) : super(key: key);

  @override
  _showAdvanceState createState() => _showAdvanceState();
}

class _showAdvanceState extends State<showAdvance> {
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
    print(noticeList.length);
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
                return Column(
                  children: [
                    _cardInvoice(
                        'Mủ nước', '20/04/2021', '10,000,000', 'chưa trả'),
                  ],
                );
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
  Widget _cardInvoice(
      String product, String date, String price, String status) {
    return FlatButton(onPressed: (){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => DetailAdvancePage()),
      );
    }, child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 10,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Text(
              '${product}',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            subtitle: Column(
              children: [
                Row(
                  children: [
                    Text(
                      '${price} VND',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      '${date}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF0BB791),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            trailing: Text('${status}'),
          ),
        ],
      ),
    ));
  }
}
