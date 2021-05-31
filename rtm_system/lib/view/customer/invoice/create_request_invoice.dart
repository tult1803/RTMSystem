import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:rtm_system/model/getAPI_product.dart';
import 'package:rtm_system/model/model_product.dart';
import 'package:rtm_system/ultils/alertDialog.dart';
import 'package:rtm_system/ultils/component.dart';
import 'package:rtm_system/ultils/src/regExp.dart';
import 'package:rtm_system/view/customer/home_customer_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateRequestInvoice extends StatefulWidget {
  const CreateRequestInvoice({Key key}) : super(key: key);

  @override
  _CreateRequestInvoiceState createState() => _CreateRequestInvoiceState();
}

class _CreateRequestInvoiceState extends State<CreateRequestInvoice> {
  final f = new DateFormat('dd/MM/yyyy');

  DateTime dateNow = DateTime.now();
  String token;
  List<DataProduct> dataListProduct = [];
  bool checkClick = false;

  //field to sales
  String quantity, degree;
  DateTime dateSale;
  String status = 'Dang cho';
  String personSale = '', phoneSale = '';

  String errQuantity, errDegree;
  String errDateSale, errNameProduct;

  Future _getProduct() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString("access_token");
      personSale = prefs.getString("fullname");
      phoneSale = prefs.getString("phone");
    });
    print(prefs.getString("fullname"));
    List<dynamic> dataList = [];
    GetProduct getProduct = GetProduct();
    dataListProduct.clear();
    if (token.isNotEmpty) {
      dataList = await getProduct.createLogin(token, 0);
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
    _getProduct();
  }

  String _mySelection;
  bool checkProduct = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEEEEEE),
      appBar: AppBar(
        backgroundColor: Color(0xFF0BB791),
        centerTitle: true,
        title: Text(
          "Tạo yêu cầu ban hang",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w500, fontSize: 22),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
            color: Colors.white,
            margin: EdgeInsets.only(
              top: 50,
            ),
            child: Column(
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(12, 0, 12, 12),
                      child: Column(children: [
                        txtPersonInvoice(
                            context, 'Người mua', 'Nguyen Van A', '0123456789'),
                        SizedBox(
                          height: 10,
                        ),
                        txtPersonInvoice(
                            context, 'Người bán', personSale, phoneSale),
                        SizedBox(
                          height: 10,
                        ),
                        // show product from API
                        _dropdownList(),
                        _txtItemProduct(
                            context,
                            getDataTextField(this.quantity),
                            false,
                            'Nhap so ky',
                            'So ky',
                            1,
                            TextInputType.text,
                            errQuantity),
                        SizedBox(
                          height: 10,
                        ),
                        _checkNameProduct()
                      ]),
                    ),
                    btnDateSale(context),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    btnCancel(context, 120, 40, Colors.redAccent, "Hủy",
                        "yeu cau ban hang", true, 1),
                    SizedBox(width: 20),
                    btnSubmitValidate(context, 140, 40, Color(0xFF0BB791),
                        "Tạo", "yeu cau ban hang", 1),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            )),
      ),
    );
  }

  TextEditingController getDataTextField(String txt) {
    if (txt == null) {
      txt = "";
    }
    final TextEditingController _controller = TextEditingController();
    _controller.value = _controller.value.copyWith(
      text: txt,
      selection: TextSelection.collapsed(offset: txt.length),
    );
    return _controller;
  }

  bool _validateData() {
    bool check = false;
    if (!checkFormatNumber.hasMatch(this.quantity)) {
      this.errQuantity = "Chỉ nhập số(ví dụ: 12,3 hoặc 12.3)";
    } else {
      this.errQuantity = null;
    }
    if (!checkFormatNumber.hasMatch(this.degree)) {
      this.errDegree = "Chỉ nhập số(ví dụ: 12,3 hoặc 12.3)";
    } else {
      this.errDegree = null;
    }
    if (this.dateSale.isBefore(dateNow)) {
      this.errDateSale = 'Thời gian trong quá khứ không hợp lệ.';
    } else {
      this.errDateSale = null;
    }
    if (this._mySelection == null || this._mySelection == '') {
      this.errNameProduct = 'Sản phẩm không được để trống.';
    } else {
      this.errNameProduct = null;
    }
    if (this.errQuantity == null &&
        this.errDegree == null &&
        this.errDateSale == null) {
      check = true;
    }

    return check;
  }

  Widget _checkNameProduct() {
    return checkProduct
        ? Container()
        : _txtItemProduct(context, getDataTextField(this.quantity), false,
            'Nhap so do', 'So do', 1, TextInputType.text, errDegree);
  }

  Widget btnCancel(
    BuildContext context,
    double width,
    double height,
    Color color,
    String tittleButtonAlertDialog,
    String contentFeature,
    bool action,
    int indexOfBottomBar,
  ) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(5),
      ),
      child: FlatButton(
          onPressed: () async {
            if (action) {
              showAlertDialog(
                  context,
                  "Bạn muốn hủy tạo ${contentFeature} ?",
                  HomeCustomerPage(
                    index: indexOfBottomBar,
                  ),);
            }
          },
          child: Center(
              child: Text(
            tittleButtonAlertDialog,
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
          ))),
    );
  }

  Widget btnSubmitValidate(
    BuildContext context,
    double width,
    double height,
    Color color,
    String tittleButtonAlertDialog,
    String contentFeature,
    int indexOfBottomBar,
  ) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(5),
      ),
      child: TextButton(
          onPressed: () {
            setState(() {
              bool check = _validateData();
              if (checkClick) {
                if (check) {
                  //call api show notice
                  int status = 200;
                  // await postAPINotice(mainTittle, content);
                  if (status == 200) {
                    showStatusAlertDialog(
                        context,
                        "Tạo ${contentFeature} thành công.",
                        HomeCustomerPage(
                          index: indexOfBottomBar,
                        ),
                        true);
                  } else {
                    showStatusAlertDialog(
                        context,
                        "Tạo ${contentFeature} thất bại.\n Vui long thử lại!",
                        null,
                        false);
                  }
                }
              }
            });
          },
          child: Center(
            child: Text(
              tittleButtonAlertDialog,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
          )),
    );
  }

  Widget btnDateSale(context) {
    var size = MediaQuery.of(context).size;
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              DatePicker.showDatePicker(
                context,
                showTitleActions: true,
                onConfirm: (date) {
                  setState(() {
                    this.dateSale = date;
                  });
                },
                currentTime: dateNow,
                maxTime: DateTime(DateTime.now().year, 12, 31),
                minTime: DateTime(DateTime.now().year - 111),
                locale: LocaleType.vi,
              );
            },
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 100,
                      margin: EdgeInsets.only(left: 12),
                      child: Text(
                        "Ngày ban",
                        style: TextStyle(
                          color: Colors.black45,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                        child: Container(
                            padding: EdgeInsets.only(left: 12, right: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${f.format(dateNow)}',
                                  style: TextStyle(fontSize: 16),
                                ),
                                Icon(
                                  Icons.calendar_today,
                                  color: Colors.black45,
                                ),
                              ],
                            ))),
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          SizedBox(
            height: 1,
            child: Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              width: size.width,
              color: Colors.black45,
            ),
          ),
        ],
      ),
    );
  }

  Widget _dropdownList() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Text(
              'San pham',
              style: TextStyle(
                color: Colors.black45,
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
                      print(_mySelection);
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
        errNameProduct != null && errNameProduct != ''
            ? Row(
                children: <Widget>[
                  Text(
                    errNameProduct,
                    style: TextStyle(
                      color: Colors.black45,
                      fontSize: 12,
                    ),
                  ),
                ],
              )
            : Container(),
        // _underRow()
      ],
    );
  }

  Widget _txtItemProduct(
      context,
      TextEditingController _controller,
      bool obscureText,
      String hintText,
      String title,
      int maxLines,
      TextInputType txtType,
      String error) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              title,
              style: TextStyle(
                color: Colors.black45,
                fontSize: 12,
              ),
              overflow: TextOverflow.clip,
              textAlign: TextAlign.left,
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                obscureText: obscureText,
                onChanged: (value) {
                  if (title == "So ky") {
                    this.quantity = value.trim();
                  } else if (title == "So do") {
                    this.degree = value.trim();
                  }
                  setState(() {
                    checkClick = true;
                  });
                },
                maxLines: maxLines,
                keyboardType: txtType,
                style: TextStyle(fontSize: 15),
                cursorColor: Colors.red,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  hintText: '$hintText',
                  //Sau khi click vào "Nhập tiêu đề" thì màu viền sẽ đổi
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFF0BB791),
                    ),
                  ),
                  //Hiển thị lỗi
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.redAccent),
                  ),
                  //Nhận thông báo lỗi
                  errorText: error,
                  //Hiển thị Icon góc phải
                  suffixIcon: Icon(
                    Icons.create,
                    color: Colors.black54,
                  ),
                  contentPadding: EdgeInsets.all(15),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
