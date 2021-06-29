import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:rtm_system/model/getAPI_product.dart';
import 'package:rtm_system/model/model_invoice.dart';
import 'package:rtm_system/model/model_product.dart';
import 'package:rtm_system/model/profile_customer/getAPI_customer_phone.dart';
import 'package:rtm_system/model/profile_customer/model_profile_customer.dart';
import 'package:rtm_system/presenter/Customer/show_deposit_to_process.dart';
import 'package:rtm_system/ultils/commonWidget.dart';
import 'package:rtm_system/ultils/component.dart';
import 'package:rtm_system/ultils/getData.dart';
import 'package:rtm_system/ultils/helpers.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';
import 'package:rtm_system/ultils/src/messageList.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetMoneyOrPayDebt extends StatefulWidget {
  const GetMoneyOrPayDebt({Key key, this.isPay}) : super(key: key);

  // isPay = true là hoá đơn để trả nợ
  final bool isPay;

  @override
  _GetMoneyOrPayDebtState createState() => _GetMoneyOrPayDebtState();
}
//
DateTime fromDate;
DateTime toDate;
// bên show nhận data nhưng bên này widget show ra k đúng.
int totalAmount = 0 ;
int totalAmountDeposit = 0 ;

List<String> idInvoice = [];

class _GetMoneyOrPayDebtState extends State<GetMoneyOrPayDebt> {
  List<DataProduct> dataListProduct = [];
  bool checkClick = false;
  String errNameProduct, token;
  bool checkProduct = true;
  int idProduct;
  String getFromDate, getToDate;
  String title;
  int totalAdvance;

  GetAPIProfileCustomer getAPIProfileCustomer = GetAPIProfileCustomer();
  InfomationCustomer infomationCustomer = InfomationCustomer();
  Invoice invoice;
  List invoiceList;

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

  //get total advance
  Future getAPIProfile() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString('access_token');
    String phone = sharedPreferences.getString('phone');
    // Đỗ dữ liệu lấy từ api
    infomationCustomer =
        await getAPIProfileCustomer.getProfileCustomer(token, phone);
    totalAdvance = infomationCustomer.advance;
    return infomationCustomer;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
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
    widget.isPay ? title = 'Trả nợ' : title = 'Nhận tiền';
    getAPIProfile();
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
                          context,
                          'Tổng tiền nợ: ',
                          totalAdvance != null
                              ? '${getFormatPrice(totalAdvance.toString())} đ'
                              : " "),
                    if (widget.isPay)
                      SizedBox(
                        height: 10,
                      ),
                    _txtItemDetail(
                        context,
                        'Số tiền hiện có:',
                        totalAmount != 0
                            ? '${getFormatPrice(totalAmount.toString())} đ'
                            : " "),
                  ],
                ),
              ),
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
              //dữ liệu có dài hơn vẫn scroll ngang được, nếu k bị lỗi
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
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
                        totalAmountDeposit != 0
                            ? "${getFormatPrice(totalAmountDeposit.toString())} đ"
                            : " ",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              //show invoice ky gui here sau khi click xác nhận btn "có" sẽ update các đơn này
              new showDepositToProcess(
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
                widget.isPay? Text(showMessage('', MSG028))
                :Text(showMessage('', MSG029)),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Không',
                style: TextStyle(
                  color: Colors.redAccent,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                widget.isPay? putReturnAdvance(context, idInvoice): "";
              },
              child: Text(
                'Có',
                style: TextStyle(
                  color: welcome_color,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

//show btn select date, it have setState should dont reuse
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
        getToDate =
            "${getDateTime("${toDate}", dateFormat: "yyyy-MM-dd 23:59:59")}";
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
