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

class showAllInvoice extends StatefulWidget {
  const showAllInvoice({Key key}) : super(key: key);

  @override
  _showAllInvoiceState createState() => _showAllInvoiceState();
}

DateTime fromDate;
DateTime toDate;
var fDate = new DateFormat('dd-MM-yyyy');

class _showAllInvoiceState extends State<showAllInvoice> {
  String token;
  List<DataInvoice> dataListInvoice = [];

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
    dataListInvoice.clear();

    //Nếu ko có If khi FutureBuilder gọi hàm _getProduct lần đầu thì Token chưa trả về nên sẽ bằng null
    //FutureBuilder sẽ gọi đến khi nào có giá trị trả về
    //Ở lần gọi thứ 2 thì token mới có giá trị
    if (token.isNotEmpty) {
      dataList = await getInvoice.createInvoice(token, 0, fromDate, toDate);
      //Parse dữ liệu
      dataList.forEach((element) {
        Map<dynamic, dynamic> data = element;
        dataListInvoice.add(DataInvoice.fromJson(data));
      });

      return dataListInvoice;
    }
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
    return Container(
      height: size.height,
      width: size.width,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  btnMain(context, 110, "Chờ xử lý", Icon(Icons.update),
                      processInvoice()),
                  SizedBox(
                    width: 20,
                  ),
                  btnMain(context, 120, "Tạo hóa đơn", Icon(Icons.post_add),
                      createInvoice()),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  btnDateTime(context, "${fDate.format(fromDate)}",
                      Icon(Icons.date_range), datePick()),
                  SizedBox(
                    width: 20,
                    child: Center(
                        child: Container(
                            alignment: Alignment.topCenter,
                            height: 45,
                            child: Text(
                              "-",
                              style: TextStyle(fontSize: 20),
                            ))),
                  ),
                  btnDateTime(context, "${fDate.format(toDate)}",
                      Icon(Icons.date_range), datePick()),
                ],
              ),
              Expanded(
                  child: Container(
                margin: EdgeInsets.only(top: 10, left: 20, right: 20),
                height: size.height,
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
                           child: Center(child: Text("Không có dữ liệu. Vui lòng chọn ngày khác",)));
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
              ))
            ],
          ),
        ),
      ),
    );
  }

//Copy nó để tái sử dụng cho các trang khác nếu cần
// Không thể tách vì nó có hàm setState
  Widget datePick() {
    return TextButton(
      onPressed: () {
        setState(() {
          pickedDate();
        });
      },
    );
  }

  Future pickedDate() async {
    final initialDateRange = DateTimeRange(start: fromDate, end: toDate);
    DateTimeRange dateRange = await showDateRangePicker(
        context: context,
        firstDate: DateTime(2000),
        lastDate: DateTime.now(),
        initialDateRange: initialDateRange,
        saveText: "Xác nhận",
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
                colorScheme: ColorScheme.light(
              primary: welcome_color,
            )),
            child: child,
          );
        });
    if (dateRange != null) {
      setState(() {
        fromDate = dateRange.start;
        toDate = dateRange.end;
      });
    }
  }
}
