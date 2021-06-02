import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rtm_system/model/getAPI_product.dart';
import 'package:rtm_system/model/model_product.dart';
import 'package:rtm_system/model/profile_customer/getAPI_customer_phone.dart';
import 'package:rtm_system/model/profile_customer/model_profile_customer.dart';
import 'package:rtm_system/presenter/Customer/show_all_invoice_by_product.dart';
import 'package:rtm_system/ultils/component.dart';
import 'package:rtm_system/view/customer/advance/detail_advance.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetMoneyOrPayDebt extends StatefulWidget {
  const GetMoneyOrPayDebt({Key key, this.isPay}) : super(key: key);
  final bool isPay;
  @override
  _GetMoneyOrPayDebtState createState() => _GetMoneyOrPayDebtState();
}

class _GetMoneyOrPayDebtState extends State<GetMoneyOrPayDebt> {
  DateTime fromDate;
  DateTime toDate;
  var formatter = new DateFormat('dd-MM-yyyy');
  List<DataProduct> dataListProduct = [];
  bool checkClick = false;
  String errNameProduct, token;
  String _mySelection;
  bool checkProduct = true;
  int idProduct;
  bool isVip = false;

  Future _getProduct() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString("access_token");
    });
    List<dynamic> dataList = [];
    GetProduct getProduct = GetProduct();
    dataListProduct.clear();
    if (token.isNotEmpty) {
      dataList = await getProduct.getProduct(token, 0);
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

  GetAPIProfileCustomer getAPIProfileCustomer = GetAPIProfileCustomer();
  InfomationCustomer infomationCustomer = InfomationCustomer();

  Future getAPIProfile() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString('access_token');
    String phone = sharedPreferences.getString('phone');
    // Đỗ dữ liệu lấy từ api
    infomationCustomer =
        await getAPIProfileCustomer.getProfileCustomer(token, phone);
    this.isVip = infomationCustomer.vip;
    return infomationCustomer;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    toDate = DateTime.now();
    fromDate = DateTime.now().subtract(Duration(days: 60));
    _getProduct();
    this.getAPIProfile();
  }

  String msg = '';

  @override
  Widget build(BuildContext context) {
    print(isVip);
    if (isVip) {
      msg = 'Vui long chon san pham khac';
    } else {
      msg = 'Vui long chon khoang thoi gian khac';
    }
    return Scaffold(
      backgroundColor: Color(0xffEEEEEE),
      appBar: AppBar(
        centerTitle: true,
        leading: leadingAppbar(context),
        backgroundColor: Color(0xFF0BB791),
        title: Text(
          "Hóa đơn",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(12),
          child: Column(
            children: [
              Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Column(
                    children: [
                      _txtItemDetail(
                          context, 'Tổng tiền nợ:', '10,000,000 VND'),
                      SizedBox(
                        height: 12,
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
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
                  ),
                ),
                child: Center(
                  child: Text('Các hóa đơn sẽ được thanh toán:'),
                ),
              ),
              SizedBox(
                height: 1,
                child: Container(
                  color: Color(0xFFBDBDBD),
                ),
              ),
              _showProduct(),
              SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  btnDateTime(context, "${formatter.format(fromDate)}",
                      Icon(Icons.date_range), datePick()),
                  SizedBox(
                    child: Center(
                        child: Container(
                            alignment: Alignment.topCenter,
                            height: 20,
                            child: Text(
                              "đến",
                              style: TextStyle(fontSize: 20),
                            ))),
                  ),
                  btnDateTime(context, "${formatter.format(toDate)}",
                      Icon(Icons.date_range), datePick()),
                ],
              ),
              _showList(),
              SizedBox(
                height: 12,
              ),
              Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'Tống tiền các hóa đơn:',
                        style: TextStyle(
                          color: Color(0xFF0BB791),
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        '10,000,000,000 VND',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),),
              _showBottomButton()
            ],
          ),
        ),
      ),
    );
  }

  Widget _showProduct() {
   return isVip
        ? Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10.0),
                bottomRight: Radius.circular(10.0),
              ),
            ),
            padding: EdgeInsets.all(12),
            child: _dropdownList(),
          )
        : Container();
  }

  Widget _showList() {
    return _mySelection != null?
    new showInvoiceByProduct(
      isDeposit: true,
      idProduct: _mySelection,
      msg404: msg,
    ): new showInvoiceByProduct(
      isDeposit: true,
      idProduct: '3',
      msg404: msg,
    );
  }

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
                  primary: Color(0xFF0BB791),
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

  Widget btnDateTime(
      BuildContext context, String tittle, Icon icon, Widget widget) {
    var size = MediaQuery.of(context).size;
    return Stack(
      children: <Widget>[
        SizedBox(
          width: 140,
          child: RaisedButton(
            color: Colors.white70,
            onPressed: () {},
            child: Text('$tittle'),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 10,
          ),
        ),
        Container(
            decoration: BoxDecoration(
              color: Colors.white10,
              borderRadius: BorderRadius.circular(5),
              // border: Border.all(color: Colors.black, width: 0.5),
            ),
            height: 35.0,
            width: 120,
            child: widget),
      ],
    );
  }

  //Show san pham
  Widget _dropdownList() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Text(
              'Sản phẩm',
              style: TextStyle(
                color: Color(0xFF0BB791),
                fontSize: 12,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: DropdownButtonHideUnderline(
                child: ButtonTheme(
                  alignedDropdown: true,
                  child: DropdownButton<String>(
                    value: _mySelection,
                    iconSize: 30,
                    icon: (null),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    hint: Text('Chon san pham'),
                    onChanged: (String newValue) {
                      setState(() {
                        _mySelection = newValue;
                      });
                      if (_mySelection == '3') {
                        setState(() {
                          checkProduct = false;
                        });
                      } else if (_mySelection != '3') {
                        setState(() {
                          checkProduct = true;
                        });
                      }
                      setState(() {
                        checkClick = true;
                      });
                    },
                    items: dataListProduct?.map((item) {
                          return new DropdownMenuItem(
                            child: new Text(item.name),
                            //chuyen id de create
                            value: item.id.toString(),
                          );
                        })?.toList() ??
                        [],
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 1,
          child: Container(
            color: Color(0xFFBDBDBD),
          ),
        ),
        errNameProduct != null && errNameProduct != ''
            ? Container(
                margin: EdgeInsets.only(left: 12, bottom: 5),
                child: Row(
                  children: <Widget>[
                    Text(
                      errNameProduct,
                      style: TextStyle(
                        color: Colors.redAccent,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              )
            : Container(),
        // _underRow()
      ],
    );
  }

  bool _validateData() {
    bool check = false;
    if (this._mySelection == null || this._mySelection == '') {
      setState(() {
        this.errNameProduct = 'Sản phẩm không được để trống.';
      });
    } else {
      setState(() {
        this.errNameProduct = null;
      });
    }
    if (this.errNameProduct == null) {
      check = true;
    }

    return check;
  }
  Widget _showBottomButton() {
    var size = MediaQuery.of(context).size;
    return widget.isPay?
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 12),
          width: size.width *0.5,
          child: RaisedButton(
              color: Color(0xFF0BB791),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetailAdvancePage(status: 'active',)),
                );
              },
              child: Text(
                'Trả tiền đã ứng',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 10),
        ),
      ],
    ): Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          margin: EdgeInsets.only(top: 12),
          width: size.width *0.5,
          child: RaisedButton(
              color: Color(0xFF0BB791),
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //       builder: (context) => CreateRequestInvoice()),
                // );
              },
              child: Text(
                'Lấy tiền',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 10),
        ),
      ],
    );
  }

  //show bang call API khi nao co API thi chuyen no qua trang khac
  Widget _txtItemDetail(context, String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              child: AutoSizeText(
                title,
                style: TextStyle(
                  color: Color(0xFF0BB791),
                  fontSize: 12,
                ),
                overflow: TextOverflow.clip,
                textAlign: TextAlign.left,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 5,
        ),
        AutoSizeText(
          content,
          style: TextStyle(
            fontSize: 16,
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
