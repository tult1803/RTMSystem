
import 'package:flutter/material.dart';
import 'package:rtm_system/model/getAPI_product.dart';
import 'package:rtm_system/model/model_product.dart';
import 'package:rtm_system/ultils/button.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../login_page.dart';

class AllNotice extends StatefulWidget {
  const AllNotice({Key key}) : super(key: key);

  @override
  _AllNoticeState createState() => _AllNoticeState();
}

class _AllNoticeState extends State<AllNotice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: welcome_color,
        title: Center(
          child: Text(
            "Quản lý thông báo",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w500, fontSize: 25),
          ),
        ),
        bottom: PreferredSize(
            child: btnMain(
                context, "Tạo thông báo", Icon(Icons.notifications_outlined)),
            preferredSize: Size.fromHeight(60.0)),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlatButton(
              onPressed: () async {
                List<dynamic> dataList = [];
                List<DataProduct> dataListProduct = [];
                GetProduct getProduct = GetProduct();
                SharedPreferences prefs = await SharedPreferences.getInstance();
                print('Click check api');

                // gọi APIProduct và lấy dữ liệu
                dataList = await getProduct.createLogin(prefs.getString("access_token"));
                //Parse dữ liệu
                dataList.forEach((element) {
                  Map<dynamic, dynamic> data= element;
                  dataListProduct.add(DataProduct.fromJson(data));
                  });
                print("List product: ${dataListProduct.length}");
                int count = 0;
                do{
                  print("Id: ${dataListProduct[count].id} - Name: ${dataListProduct[count].name} - Description: ${dataListProduct[count].description} - Price: ${dataListProduct[count].price}");
                  count++;
                }while(count != dataListProduct.length);
                },
              child: Text("Check Get API Product")),
            FlatButton(
                onPressed: () async {
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  prefs.clear();
                  print('Clear data login');
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                      (route) => false);
                },
                child: Text("Logout")),
          ],
        ),
      ),
    );
  }
}

// List<dynamic> data_list = [];
// List<DataNews> data_list_news = [];
// void _getNews() async{
//   int i = 0;
//   final prefs = await SharedPreferences.getInstance();
//   setState((){
//     token = prefs.getString('token');
//     print('${prefs.getString('id_emp')}');
//     // print("Token News: $token");
//   });
//   data_list = await getNew.getNews(token);
//   print('${data_list.length}');
//   data_list.forEach((element) {
//     Map<dynamic, dynamic> data= element;
//     data_list_news.add(DataNews.fromJson(data));
//   });