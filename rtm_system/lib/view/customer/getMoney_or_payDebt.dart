import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:rtm_system/model/getAPI_product.dart';
import 'package:rtm_system/model/model_product.dart';
import 'package:rtm_system/presenter/Customer/show_all_invoice.dart';
import 'package:rtm_system/ultils/alertDialog.dart';
import 'package:rtm_system/ultils/commonWidget.dart';
import 'package:rtm_system/ultils/component.dart';
import 'package:rtm_system/ultils/helpers.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';
import 'package:rtm_system/ultils/src/messageList.dart';
import 'package:rtm_system/view/customer/home_customer_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetMoneyOrPayDebt extends StatefulWidget {
  const GetMoneyOrPayDebt({Key key, this.isPay}) : super(key: key);
  // isPay = true là hoá đơn để trả nợ
  final bool isPay;

  @override
  _GetMoneyOrPayDebtState createState() => _GetMoneyOrPayDebtState();
}

DateTime fromDate;
DateTime toDate;

class _GetMoneyOrPayDebtState extends State<GetMoneyOrPayDebt> {
  List<DataProduct> dataListProduct = [];
  bool checkClick = false;
  String errNameProduct, token;
  bool checkProduct = true;
  int idProduct;
  String getFromDate, getToDate;
  String title;

  Future _getProduct() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString("access_token");
    });
    List<dynamic> dataList = [];
    GetProduct getProduct = GetProduct();
    dataListProduct.clear();
    if (token.isNotEmpty) {
      dataList = await getProduct.getProduct(token, null);
      dataList.forEach((element) {
        Map<dynamic, dynamic> data = element;
        dataListProduct.add(DataProduct.fromJson(data));
      });
      setState(() {
        dataListProduct;
      });
      return dataListProduct;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    toDate = DateTime.now();
    fromDate = DateTime.now().subtract(Duration(days: 30));
    getFromDate =
        "${getDateTime("$fromDate", dateFormat: "yyyy-MM-dd HH:mm:ss")}";
    getToDate = "${getDateTime("$toDate", dateFormat: "yyyy-MM-dd HH:mm:ss")}";
    _getProduct();
    widget.isPay? title ='Trả nợ': title = 'Nhận tiền';
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEEEEEE),
      appBar: AppBar(
        centerTitle: true,
        leading: leadingAppbar(context),
        backgroundColor: Color(0xFF0BB791),
        title: Text(
          title,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.fromLTRB(5, 26, 5, 12),
          child: Column(
            children: [
              Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Column(
                    children: [
                      if (widget.isPay)
                        _txtItemDetail(
                            context, 'Tổng tiền nợ:', '10,000,000 VND'),
                      if (widget.isPay)
                        SizedBox(
                          height: 10,
                        ),
                      _txtItemDetail(
                          context, 'Số tiền hiện có:', '12,000,000 VND'),
                    ],
                  )),
              SizedBox(
                height: 12,
              ),
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
                child: Center(
                  child: AutoSizeText(
                    'Các hóa đơn sẽ được thanh toán:',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              rowButtonDatetime(),
              SizedBox(
                height: 5,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
                padding: EdgeInsets.all(12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    AutoSizeText(
                      'Tống tiền các hóa đơn:',
                      style: TextStyle(
                        color: Color(0xFF0BB791),
                      ),
                    ),
                    AutoSizeText(
                      '10,000,000,000 VND',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              //show invoice ky gui here sau khi click xác nhận btn "có" sẽ update các đơn này
              new showAllInvoicePage(5,
                  fromDate: getFromDate, toDate: getToDate),
              SizedBox(
                height: 12,
              ),
              // _showBottomButton()
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _showConfirmDialog();
        },
        label: Text(
          'Xác nhận',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: welcome_color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
        elevation: 10,
      ),
    );
  }
  // chưa thấy cần dùng cho chỗ khác nên để đây.
  Future<void> _showConfirmDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Thông báo'),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Text(showMessage('', MSG028)),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Không',
                style: TextStyle(
                  color: Colors.redAccent,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                'Có',
                style: TextStyle(
                  color: welcome_color,
                ),
              ),
              onPressed: () {
                // call api and return toast message
                widget.isPay? showStatusAlertDialog(
                    context,
                    showMessage("", MSG012),
                HomeCustomerPage(
                index: 1,
                ),
                true): showStatusAlertDialog(
                    context,
                    showMessage("", MSG012),
                    HomeCustomerPage(
                      index: 0,
                    ),
                    true);;
              },
            ),

          ],
        );
      },
    );
  }

  // các btn date không thể tách ra class riêng vì setState, nên phải code trong class.
  Widget rowButtonDatetime() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        btnDateTimeForCustomer(
            context,
            "${getDateTime("$fromDate", dateFormat: "dd-MM-yyyy")}",
            Icon(Icons.date_range),
            datePick()),
        SizedBox(
          child: Center(
              child: Container(
                  alignment: Alignment.topCenter,
                  height: 20,
                  child: Text(
                    "-",
                    style: TextStyle(fontSize: 20),
                  ))),
        ),
        btnDateTimeForCustomer(
            context,
            "${getDateTime("$toDate", dateFormat: "dd-MM-yyyy")}",
            Icon(Icons.date_range),
            datePick()),
      ],
    );
  }

  Widget datePick() {
    return TextButton(
      onPressed: () {
        setState(() {
          pickedDate();
        });
      },
      child: null,
    );
  }

  Future pickedDate() async {
    final initialDateRange = DateTimeRange(start: fromDate, end: toDate);
    print(initialDateRange);
    final ThemeData theme = Theme.of(context);
    DateTimeRange dateRange = await showDateRangePicker(
        context: context,
        firstDate: DateTime(2000),
        lastDate: DateTime.now(),
        initialDateRange: initialDateRange,
        saveText: "Xác nhận",
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
                //Dùng cho nút "X" của lịch
                appBarTheme: AppBarTheme(
                  iconTheme:
                      theme.primaryIconTheme.copyWith(color: Colors.white),
                ),
                //Dùng cho nút chọn ngày và background
                colorScheme: ColorScheme.light(
                  primary: welcome_color,
                )),
            child: child,
          );
        });
    if (dateRange != null) {
      print(dateRange.end);
      setState(() {
        fromDate = dateRange.start;
        toDate = dateRange.end;
        getFromDate =
            "${getDateTime("$fromDate", dateFormat: "yyyy-MM-dd HH:mm:ss")}";
        // vì dateRange.end lấy ngày và giờ là 00:00:00 nên + thêm 1 ngày để lấy đúng 1 ngày
        getToDate =
            "${getDateTime("${toDate.add(Duration(days: 1))}", dateFormat: "yyyy-MM-dd HH:mm:ss")}";
      });
    }
  }

  //show bang call API khi nao co API thi chuyen no qua trang khac
  Widget _txtItemDetail(context, String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            AutoSizeText(
              title,
              style: TextStyle(
                color: Color(0xFF0BB791),
              ),
              overflow: TextOverflow.clip,
              textAlign: TextAlign.left,
            ),
          ],
        ),
        SizedBox(
          height: 5,
        ),
        AutoSizeText(
          content,
          style: TextStyle(
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.left,
          overflow: TextOverflow.ellipsis,
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
    );
  }
}
