import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rtm_system/model/getAPI_invoice.dart';
import 'package:rtm_system/model/model_invoice.dart';
import 'package:rtm_system/ultils/commonWidget.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';
import 'package:rtm_system/view/manager/formForDetail_page.dart';
import 'package:rtm_system/view/manager/invoice/createInvoice.dart';
import 'package:rtm_system/view/manager/invoice/processInvoice.dart';
import 'package:shared_preferences/shared_preferences.dart';

class showInvoiceByProduct extends StatefulWidget {
  const showInvoiceByProduct({Key key, this.isDeposit,this.idProduct, this.msg404}) : super(key: key);
  final bool isDeposit;
  final String msg404;
  final String idProduct;
  @override
  _showInvoiceByProductState createState() => _showInvoiceByProductState();
}

DateTime fromDate;
DateTime toDate;
var fDate = new DateFormat('dd-MM-yyyy');

class _showInvoiceByProductState extends State<showInvoiceByProduct> {
  String token;
  // List<DataInvoice> dataListInvoice = [];

  Future _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString("access_token");
    });
  }

  Future _getInvoice() async {
    List<dynamic> dataList = [];
    GetInvoice getInvoice = GetInvoice();
    //Nếu dùng hàm này thì FutureBuilder sẽ chạy vòng lập vô hạn
    //Phải gọi _getToken trước khi gọi hàm _getProduct
    // await _getToken();
    // gọi APIProduct và lấy dữ liệu

    //Khi click nhiều lần vào button "Sản phẩm" thì sẽ có hiện tượng dữ liệu bị ghi đè
    //Clear là để xoá dữ liệu cũ, ghi lại dữ liệu mới
    // dataListInvoice.clear();
    //
    // //Nếu ko có If khi FutureBuilder gọi hàm _getProduct lần đầu thì Token chưa trả về nên sẽ bằng null
    // //FutureBuilder sẽ gọi đến khi nào có giá trị trả về
    // //Ở lần gọi thứ 2 thì token mới có giá trị
    // if (token.isNotEmpty) {
    //   dataList = await getInvoice.createInvoice(token, 0, fromDate, toDate);
    //   //Parse dữ liệu
    //   dataList.forEach((element) {
    //     Map<dynamic, dynamic> data = element;
    //     dataListInvoice.add(DataInvoice.fromJson(data));
    //   });
    //
    //   return dataListInvoice;
    // }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    toDate = DateTime.now();
    fromDate = DateTime.now().subtract(Duration(days: 2));
    _getToken();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(top: 0, left: 20, right: 20),
        height:300,
        width: size.width,
        child: new FutureBuilder(
          future: _getInvoice(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return card(
                      context,
                      "${snapshot.data[index].customer_name}",
                      "Trạng thái",
                      "${snapshot.data[index].status_id}",
                      "${snapshot.data[index].total}",
                      snapshot.data[index].create_time,
                      Colors.black54,
                      FormForDetailPage(
                          tittle: "Chi tiết hóa đơn", bodyPage: null));
                },
              );
            } else {
              if(GetInvoice.statusInvoice == 404){
                return Container(
                    child: Center(child: Text("Không có dữ liệu. ${widget.msg404}",)));
              }else{
                return Container(
                    height: size.height * 0.7,
                    child: Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(welcome_color),
                        )));
              }
            }
          },
        ),
      ),
    );
  }
}
