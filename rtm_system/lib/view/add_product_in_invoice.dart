import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:rtm_system/model/getAPI_allStore.dart';
import 'package:rtm_system/model/getAPI_product.dart';
import 'package:rtm_system/model/model_product.dart';
import 'package:rtm_system/model/model_store.dart';
import 'package:rtm_system/model/profile_customer/model_profile_customer.dart';
import 'package:rtm_system/helpers/dialog.dart';
import 'package:rtm_system/helpers/component.dart';
import 'package:rtm_system/ultils/get_api_data.dart';
import 'package:rtm_system/ultils/get_data.dart';
import 'package:rtm_system/ultils/src/regExp.dart';
import 'package:rtm_system/view/confirm_detail_invoice.dart';
import 'package:rtm_system/view/table_price.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'manager/form_detail_page.dart';

// ignore: must_be_immutable
class AddProductPage extends StatefulWidget {
  final String tittle;
  final Widget widgetToNavigator;
  bool isChangeData;
  final String phone,
      invoiceRequestId,
      customerId,
      fullName,
      storeId,
      productId,
      dateToPay,
      savePrice,
      productName,
      storeName;

  //true is Customer role
  final bool isCustomer;

  AddProductPage(
      {this.tittle,
      this.invoiceRequestId,
      this.customerId,
      this.phone,
      this.fullName,
      this.storeId,
      this.productId,
      this.dateToPay,
      this.savePrice,
      this.isCustomer,
      this.widgetToNavigator,
      this.productName,
      this.storeName,
      this.isChangeData});

  @override
  _AddProductPageState createState() => _AddProductPageState();
}

InfomationCustomer infomationCustomer = InfomationCustomer();
String phoneNewCustomer, nameNewCustomer;

class _AddProductPageState extends State<AddProductPage> {
  String errorPhone, errorFullName, errorQuantity, errorDegree;
  String price, productName;
  String token, storeName;
  String personSale = '', phoneSale = '', oldCusName;
  List listQuantity = [];
  List<DataProduct> dataListProduct = [];
  Store store;
  List<StoreElement> dataListStore;
  bool checkClick = false;
  var txtController = TextEditingController();
  bool autoFocus = false, enabledFillName = true;

  //field to sales
  double quantity = 0, degree = 0;

  String _myProduct, _myStore;
  bool checkProduct = true;
  DateTime dateSale;

  Future _getProduct() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString("access_token");
      personSale = prefs.getString("fullname");
      phoneSale = prefs.getString("phone");
    });
    List<dynamic> dataList = [];
    GetProduct getProduct = GetProduct();
    dataListProduct.clear();
    if (token.isNotEmpty) {
      dataList = await getProduct.getProduct(token, "");
      dataList.forEach((element) {
        Map<dynamic, dynamic> data = element;
        dataListProduct.add(DataProduct.fromJson(data));
      });
      setState(() {
        // ignore: unnecessary_statements
        dataListProduct;
      });
      return dataListProduct;
    }
  }

  Future _getStore() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    GetAPIAllStore getAPIAllStore = GetAPIAllStore();
    store = await getAPIAllStore.getStores(
      prefs.get("access_token"),
      1000,
      1,
    );
    dataListStore = store.stores;
    setState(() {
      if (dataListStore.length == 1) {
        _myStore = dataListStore[0].id;
        storeName = dataListStore[0].name;
      }
    });
    return dataListStore;
  }

  @override
  void dispose() {
    super.dispose();
    infomationCustomer = null;
    phoneNewCustomer = null;
    nameNewCustomer = null;
  }

  @override
  void initState() {
    super.initState();
    _checkDataFromRequest();
    _getProduct();
    _getStore();
  }

  Future<void> _checkDataFromRequest() {
    setState(() {
      this.widget.phone == null
          ? phoneNewCustomer = ""
          : phoneNewCustomer = widget.phone;
      this.widget.fullName == null
          ? nameNewCustomer = ""
          : nameNewCustomer = widget.fullName;
      this.widget.storeId == null ? _myStore = null : _myStore = widget.storeId;
      this.widget.productId == null
          ? _myProduct = null
          : widget.productId == "SP-1000003"
              // ignore: unnecessary_statements
              ? {_myProduct = widget.productId, checkProduct = false}
              : _myProduct = widget.productId;
      this.widget.savePrice == null ? price = "0" : price = widget.savePrice;
      this.widget.dateToPay == null
          ? dateSale = DateTime.now()
          : dateSale = DateTime.parse(widget.dateToPay);
      this.widget.productName == null
          ? productName = ""
          : productName = widget.productName;
      this.widget.storeName == null
          ? storeName = "${_myStore == null ? "" : storeName}"
          : storeName = widget.storeName;
    });
  }

  TextEditingController getDataTextField(String txt) {
    final TextEditingController _controller = TextEditingController();
    if (txt != null) {
      _controller.value = _controller.value.copyWith(
        text: txt,
        selection:
            TextSelection(baseOffset: txt.length, extentOffset: txt.length),
        composing: TextRange.empty,
      );
    }
    return _controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEEEEEE),
      appBar: AppBar(
        backgroundColor: Color(0xFF0BB791),
        centerTitle: true,
        leading: leadingAppbar(context, widget: this.widget.widgetToNavigator),
        title: Text(
          this.widget.tittle,
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w500, fontSize: 22),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
            // color: Colors.white,
            margin: EdgeInsets.only(
              top: 24,
            ),
            child: Column(
              children: [
                Column(
                  children: [
                    txtAutoFillByPhone(
                      enabled: widget.isChangeData == null ? true : false,
                      controller: getDataTextField(phoneNewCustomer),
                      isCustomer: this.widget.isCustomer,
                      type: "phone",
                      tittle: "Điện thoại",
                      txtInputType: TextInputType.numberWithOptions(
                          signed: true, decimal: true),
                      error: errorPhone,
                    ),
                    txtAutoFillByPhone(
                      enabled:
                          widget.isChangeData == null ? enabledFillName : false,
                      isCustomer: this.widget.isCustomer,
                      controller: getDataTextField(nameNewCustomer),
                      type: "name",
                      tittle: "Tên khách hàng",
                      txtInputType: TextInputType.name,
                      error: errorFullName,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(12, 0, 12, 12),
                      child: Column(children: [
                        _dropdownListStore(),
                        // show product from API
                        _dropdownListProduct(),
                        _checkShowQuantity(),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: Wrap(
                            spacing: 5,
                            children: listQuantity
                                .map((value) => containerWeight(value: value))
                                .toList()
                                .cast<Widget>(),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        _checkShowDegree(),
                        SizedBox(
                          height: 10,
                        ),
                        btnDateSale(context),
                        SizedBox(
                          height: 10,
                        ),
                        btnCurrentPrice(context, price),
                        SizedBox(
                          height: 10,
                        ),
                        if (!widget.isCustomer)
                          _showMoneyOrQuantity(
                              "Tống số ký", "${this.quantity} kg"),
                        SizedBox(
                          height: 10,
                        ),
                        //Khi manager tạo hoá đơn thì mới có giá lúc bán để show
                        if (!widget.isCustomer)
                          _showMoneyOrQuantity("Thành tiền",
                              "${getFormatPrice('${getPriceTotal(double.tryParse(price), degree, quantity)}')}đ"),
                      ]),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                btnSave(context, 200, 40, Color(0xFF0BB791), "Tạo", 1),
                SizedBox(
                  height: 10,
                ),
                showPriceTable(),
              ],
            )),
      ),
    );
  }
  Widget showPriceTable(){
    if(widget.isCustomer){
      if(_myProduct != null){
        return showTablePrice(idProduct: _myProduct,);
      }else{
        return Container();
      }
    }else{
       return Container();
    }
  }
  Widget txtAutoFillByPhone({
    TextEditingController controller,
    String error,
    String tittle,
    String type,
    TextInputType txtInputType,
    bool isCustomer,
    bool enabled,
  }) {
    return isCustomer
        ? Container()
        : Container(
            color: Colors.white,
            margin: EdgeInsets.only(top: 10, left: 10, right: 10),
            child: TextField(
              controller: controller,
              // initialValue: this.widget.txt,
              autocorrect: false,
              obscureText: false,
              enabled: enabled,
              onSubmitted: (value) {
                doOnSubmittedTextField(type, value);
              },
              maxLines: 1,
              keyboardType: txtInputType,
              // TextInputType.numberWithOptions(signed: true, decimal: true),
              inputFormatters: [
                txtInputType !=
                        TextInputType.numberWithOptions(
                            signed: true, decimal: true)
                    ? FilteringTextInputFormatter.allow(
                        RegExp(r'[ [a-zA-Z0-9]'))
                    : FilteringTextInputFormatter.allow(RegExp(r'[[0-9]')),
              ],
              style: TextStyle(fontSize: 15),
              cursorColor: Colors.red,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                ),
                labelText: tittle,
                labelStyle: TextStyle(color: Colors.black54),
                contentPadding: EdgeInsets.only(top: 14, left: 10),
                //Sau khi click vào "Nhập tiêu đề" thì màu viền sẽ đổi
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFF0BB791),
                  ),
                ),
                //Hiển thị Icon góc phải
                suffixIcon: Icon(
                  Icons.create,
                  color: Colors.black54,
                ),

                //Hiển thị lỗi
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.redAccent),
                ),
                //Nhận thông báo lỗi
                errorText: error,
              ),
            ),
          );
  }

  Future<void> doOnSubmittedTextField(String type, String value) async {
    switch (type) {
      case "phone":
        phoneNewCustomer = value.trim();
        infomationCustomer = await getDataCustomerFromPhone(value);
        setState(() {
          if (infomationCustomer == null) {
            enabledFillName = true;
            // ignore: unnecessary_statements
            nameNewCustomer == oldCusName ? nameNewCustomer = "" : null;
          } else {
            oldCusName = infomationCustomer.fullname;
            nameNewCustomer = infomationCustomer.fullname;
            enabledFillName = false;
          }
          autoFocus = false;
        });
        break;
      case "name":
        nameNewCustomer = value.trim();
        break;
    }
  }

  Widget _showMoneyOrQuantity(String title, value) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(left: 12, right: 12),
      height: 45,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$title:',
            style: TextStyle(
              color: Color(0xFF0BB791),
              fontSize: 14,
            ),
          ),
          // sẽ show số tổng các ký đã nhập
          Text(
            '$value',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _checkShowDegree() {
    return checkProduct || widget.isCustomer
        ? Container()
        : _txtItemProduct(
            context: context,
            isQuantity: false,
            hintText: 'Nhập số độ',
            maxLines: 1,
          );
  }

  Widget _checkShowQuantity() {
    return widget.isCustomer
        ? Container()
        : _txtItemProduct(
            context: context,
            hintText: 'Nhập số ký',
            maxLines: 1,
            isQuantity: true,
          );
  }

  Widget btnSave(
    BuildContext context,
    double width,
    double height,
    Color color,
    String tittleButtonAlertDialog,
    int indexOfBottomBar,
  ) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextButton(
          onPressed: () {
            setState(() {
              if (widget.isCustomer) {
                _myProduct == null
                    ? showCustomDialog(
                        context,
                        content: "Chưa chọn sản phẩm",
                        isSuccess: false,
                      )
                    : _navigator("Xác nhận giữ giá");
              } else {
                _validate();
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

  void _validate() {
    if (phoneNewCustomer == null || phoneNewCustomer == "") {
      errorPhone = "Số điện thoại trống";
    } else {
      if (!checkFormatPhone.hasMatch(phoneNewCustomer) ||
          phoneNewCustomer.length > 11) {
        errorPhone = "Số điện thoại sai (10-11 só)";
      } else {
        errorPhone = null;
      }
    }
    if (nameNewCustomer == null || nameNewCustomer == " ") {
      errorFullName = "Tên khách hàng trống";
    } else {
      errorFullName = null;
      if (_myProduct == null) {
        showCustomDialog(context,
            content: "Chưa chọn sản phẩm", isSuccess: false);
      }
    }
    if (quantity == 0) {
      errorQuantity = "Số ký đang trống";
    } else
      errorQuantity = null;
    if (!checkProduct) {
      if (degree == 0) {
        errorDegree = "Số độ trống";
      } else
        errorDegree = null;
    }
    if (errorPhone == null &&
        errorQuantity == null &&
        errorFullName == null &&
        _myProduct != null) {
      if (checkProduct) {
        _navigator("Xác nhận hóa đơn");
      } else if (!checkProduct && errorDegree == null) {
        _navigator("Xác nhận hóa đơn");
      }
    }
  }

  Widget _dropdownListProduct() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 40,
            margin: EdgeInsets.only(top: 5, bottom: 10),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                )),
            child: DropdownButtonHideUnderline(
              child: ButtonTheme(
                alignedDropdown: true,
                child: DropdownButton<String>(
                  value: _myProduct,
                  iconSize: 30,
                  icon: (null),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  hint: Text('Chọn sản phẩm'),
                  onChanged: (String newValue) async {
                    if (widget.productId == null) {
                      setState(() {
                        _myProduct = newValue;
                        _getCurrentPrice(newValue);
                        _myProduct == "SP-1000003"
                            ? checkProduct = false
                            : checkProduct = true;
                        checkClick = true;
                      });
                    }
                  },
                  items: dataListProduct?.map((item) {
                        return new DropdownMenuItem(
                          child: new Text(item.name),
                          //chuyen id de create
                          value: item.id.toString(),
                          onTap: () {
                            if (widget.productName == null) {
                              setState(() {
                                productName = item.name;
                              });
                            }
                          },
                        );
                      })?.toList() ??
                      [],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _dropdownListStore() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 40,
            margin: EdgeInsets.only(top: 5, bottom: 10),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                )),
            child: DropdownButtonHideUnderline(
              child: ButtonTheme(
                alignedDropdown: true,
                child: DropdownButton<String>(
                  autofocus: autoFocus,
                  value: _myStore,
                  iconSize: 30,
                  icon: (null),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  hint: Text('Chon cửa hàng'),
                  onChanged: (String newValue) async {
                    if (widget.storeId == null) {
                      setState(() {
                        _myStore = newValue;
                      });
                    }
                  },
                  items: dataListStore?.map((item) {
                        return new DropdownMenuItem(
                          child: new Text(item.name),
                          //chuyen id de create
                          value: item.id.toString(),
                          onTap: () {
                            if (widget.storeName == null) {
                              setState(() {
                                storeName = item.name;
                              });
                            }
                          },
                        );
                      })?.toList() ??
                      [],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _txtItemProduct(
      {BuildContext context, String hintText, int maxLines, bool isQuantity}) {
    return Container(
      color: Colors.white,
      child: TextField(
        controller: isQuantity ? txtController : null,
        onSubmitted: (value) {
          if (value.isNotEmpty) {
            if (isQuantity) {
              insertQuantity(value);
              quantity = 0;
              listQuantity.forEach((element) {
                quantity += double.parse(element);
              });
              txtController.clear();
            } else
              this.degree = double.parse(value);
            setState(() {
              checkClick = true;
            });
          }
        },
        maxLines: maxLines,
        keyboardType:
            TextInputType.numberWithOptions(signed: true, decimal: true),
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'[.[0-9]')),
        ],
        style: TextStyle(fontSize: 15),
        cursorColor: Colors.red,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
          ),
          labelText: hintText,
          labelStyle: TextStyle(color: Colors.black54),
          contentPadding: EdgeInsets.only(top: 14, left: 10),
          //Sau khi click vào "Nhập tiêu đề" thì màu viền sẽ đổi
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xFF0BB791),
            ),
          ),
          //Hiển thị Icon góc phải
          suffixIcon: Icon(
            Icons.create_outlined,
            color: Colors.black54,
          ),
          //Hiển thị lỗi
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.redAccent),
          ),
          //Nhận thông báo lỗi
          errorText: isQuantity ? errorQuantity : errorDegree,
        ),
      ),
    );
  }

  //Hiển thị ra các container nhỏ khi nhập số cân
  Widget containerWeight({String value}) {
    return GestureDetector(
      onTap: () {
        setState(() {
          removeAtQuantity(value);
          quantity = 0;
          listQuantity.forEach((element) {
            quantity += double.parse(element);
          });
        });
      },
      child: Container(
          margin: EdgeInsets.only(top: 10),
          width: 60,
          height: 30,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                color: Colors.black54,
                blurRadius: 1,
                offset: Offset(1, 1), // Shadow position
              ),
            ],
          ),
          child: Center(
              child: Text(
            "$value",
            style: TextStyle(color: Colors.black),
          ))),
    );
  }

  //Lấy giá tiền
  // ignore: missing_return
  Future _getCurrentPrice(String value) {
    setState(() {
      dataListProduct.forEach((element) {
        if (element.id == value) {
          price = element.price;
        }
      });
    });
  }

  //Xóa các phần tử trong list cân
  void removeAtQuantity(String value) {
    return listQuantity.removeAt(listQuantity.indexOf(value));
  }

  //Thêm các phần tử trong list cân
  void insertQuantity(String value) {
    return listQuantity.add(value);
  }

  //Show date để chọn ngày đến bán( customer đang dùng)
  Widget btnDateSale(context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          )),
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {
              if (widget.dateToPay == null) {
                DatePicker.showDatePicker(
                  context,
                  showTitleActions: true,
                  onConfirm: (date) {
                    setState(() {
                      dateSale = date;
                    });
                  },
                  maxTime: DateTime(DateTime.now().year + 100, 12, 31),
                  minTime: DateTime(DateTime.now().year, DateTime.now().month,
                      DateTime.now().day),
                  locale: LocaleType.vi,
                );
              }
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 130,
                  margin: EdgeInsets.only(left: 15),
                  child: Text(
                    "Ngày bán",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: Text(
                      '${getDateTime("$dateSale", dateFormat: "dd/MM/yyyy")}',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                Container(
                  width: 70,
                  child: Icon(
                    Icons.calendar_today,
                    color: Colors.black45,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  Widget btnCurrentPrice(context, String price) {
    return Container(
      height: 45,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          )),
      child: Row(
        children: [
          Container(
            width: 130,
            margin: EdgeInsets.only(left: 15),
            child: Text(
              "${widget.dateToPay != null ? "Giá đã giữ" : "Giá hiên tại"}",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              child: Text(
                '${"${getFormatPrice(price)}" == "0" ? "000.000" : getFormatPrice(price)}',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
          Container(
              alignment: Alignment.centerRight,
              margin: EdgeInsets.only(right: 20),
              width: 50,
              child: Text("VNĐ")),
        ],
      ),
    );
  }

  Future<void> _navigator(String tittle) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => FormForDetailPage(
                  tittle: tittle,
                  bodyPage: confirmDetailInvoice(
                    storeId: "$_myStore",
                    productId: "$_myProduct",
                    customerId: "${widget.customerId}",
                    invoiceRequestId: widget.invoiceRequestId,
                    customerName: "$nameNewCustomer",
                    phoneNumber: "$phoneNewCustomer",
                    dateToPay: "$dateSale",
                    degree: "$degree",
                    quantity: "$quantity",
                    price: "$price",
                    productName: "$productName",
                    storeName: "$storeName",
                    widgetToNavigator: widget.widgetToNavigator,
                    isCustomer: widget.isCustomer,
                  ),
                )));
  }
}
