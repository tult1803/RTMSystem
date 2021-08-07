import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:keyboard_actions/keyboard_actions_config.dart';
import 'package:rtm_system/model/get/getAPI_allStore.dart';
import 'package:rtm_system/model/get/getAPI_product.dart';
import 'package:rtm_system/model/model_product.dart';
import 'package:rtm_system/model/model_store.dart';
import 'package:rtm_system/model/model_profile_customer.dart';
import 'package:rtm_system/helpers/dialog.dart';
import 'package:rtm_system/helpers/component.dart';
import 'package:rtm_system/ultils/check_data.dart';
import 'package:rtm_system/ultils/get_api_data.dart';
import 'package:rtm_system/ultils/get_data.dart';
import 'package:rtm_system/ultils/src/message_list.dart';
import 'package:rtm_system/view/confirm_detail_invoice.dart';
import 'package:rtm_system/view/manager/home_manager_page.dart';
import 'package:rtm_system/view/table_price.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../view/manager/form_detail_page.dart';

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
  final int level, productType;

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
      this.isChangeData,
      this.level,
      this.productType});

  @override
  _AddProductPageState createState() => _AddProductPageState();
}

InfomationCustomer infomationCustomer = InfomationCustomer();
String phoneNewCustomer, nameNewCustomer, customerId;

class _AddProductPageState extends State<AddProductPage> {
  String errorPhone, errorQuantity, errorDegree;
  String price, productName, currentPrice = "0", priceSell = "0";
  String token, storeName;
  String personSale = '', phoneSale = '', oldCusName, oldCusId;
  List listQuantity = [];
  List<DataProduct> dataListProduct = [];
  Store store;
  List<StoreElement> dataListStore;
  bool checkClick = false;
  var txtController = TextEditingController();
  bool autoFocus = false;

  FocusNode nodePhone, nodeName, nodeDegree, nodeQuantity;

  //field to sales
  double quantity = 0, degree = 0;

  String _myProduct, _myStore;
  bool checkProduct = true;
  DateTime dateSale;
  int type;

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
      dataList = await getProduct.getProduct(context, token, "",
          limit: null, type: widget.level == 2 ? 1 : 2);
      dataList.forEach((element) async {
        Map<dynamic, dynamic> data = element;
        dataListProduct.add(DataProduct.fromJson(data));
        if (widget.dateToPay != null) {
          if (element["id"] == widget.productId) {
            currentPrice = "${element["update_price"]}";
            priceSell = "${comparePrice(price, currentPrice)}";
          }
        }
        if (widget.productId == element["id"]) {
          setState(() {
            type = element["type"];
          });
        }
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
      context,
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
    customerId = null;
    nodePhone.dispose();
    nodeName.dispose();
    nodeDegree.dispose();
    nodeQuantity.dispose();
  }

  @override
  void initState() {
    super.initState();
    nodePhone = FocusNode();
    nodeName = FocusNode();
    nodeDegree = FocusNode();
    nodeQuantity = FocusNode();
    _checkDataFromRequest();
    _getProduct();
    _getStore();
  }

  Future<void> _checkDataFromRequest() async {
    setState(() {
      this.widget.customerId == null
          ? customerId = ""
          : customerId = widget.customerId;
      this.widget.phone == null
          ? phoneNewCustomer = ""
          : phoneNewCustomer = widget.phone;
      this.widget.fullName == null
          ? nameNewCustomer = ""
          : nameNewCustomer = widget.fullName;
      this.widget.storeId == null ? _myStore = null : _myStore = widget.storeId;
      if (widget.productId == null) {
        _myProduct = null;
      } else {
        print('product_Type: ${widget.productType} //188 add_product_invoice');
        widget.productType != 0 ? checkProduct = true : checkProduct = false;
        _myProduct = widget.productId;
      }
      this.widget.savePrice == null ? price = "0" : price = widget.savePrice;
      this.widget.dateToPay == null
          ? dateSale = DateTime.now()

          /// Nếu muốn Tạo hóa đơn lấy theo ngày trên yêu cầu thì mở comment dòng này ///
          // : dateSale = DateTime.parse(widget.dateToPay);
          : dateSale = DateTime.now();
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

  KeyboardActionsConfig keyBoardConfig(BuildContext context, node,
      {String type}) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
      nextFocus: true,
      actions: [
        KeyboardActionsItem(
          focusNode: node,
          displayDoneButton: true,
          onTapAction: () async {
            checkKeyBoardConfig(node, type: type);
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEEEEEE),
      appBar: AppBar(
        backgroundColor: Color(0xFF0BB791),
        centerTitle: true,
        leading: leadingAppbar(context, widget: this.widget.widgetToNavigator),
        title: titleAppBar(widget.tittle),
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
                      maxLength: 11,
                      enabled: widget.isChangeData == null ? true : false,
                      controller: getDataTextField(phoneNewCustomer),
                      isCustomer: this.widget.isCustomer,
                      type: "phone",
                      tittle: "Điện thoại",
                      txtInputType: TextInputType.number,
                      error: errorPhone,
                      icon: Icons.clear,
                      node: nodePhone,
                    ),
                    txtAutoFillByPhone(
                      enabled: false,
                      isCustomer: this.widget.isCustomer,
                      controller: getDataTextField(nameNewCustomer),
                      type: "name",
                      tittle: "Tên khách hàng",
                      txtInputType: TextInputType.name,
                      icon: nameNewCustomer.isNotEmpty
                          ? Icons.check
                          : Icons.clear,
                      node: nodeName,
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
                          height: 5,
                        ),
                        if (widget.dateToPay != null)
                          btnCurrentPrice(context, "$currentPrice",
                              tittle: "Giá hiện tại"),
                        SizedBox(
                          height: 5,
                        ),
                        if (widget.dateToPay != null)
                          _showMoneyOrQuantity(
                              "Giá bán", "${getFormatPrice(priceSell)} VNĐ"),
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
                              "${getFormatPrice('${getPriceTotal(double.tryParse(widget.dateToPay != null ? priceSell : price), degree, quantity)}')}đ"),
                      ]),
                    ),
                  ],
                ),
                btnSave(context, 200, 40, Color(0xFF0BB791), "Tạo", 1),
                SizedBox(
                  height: 25,
                ),
                showPriceTable(),
              ],
            )),
      ),
    );
  }

  Widget showPriceTable() {
    if (widget.isCustomer) {
      if (_myProduct != null) {
        return showTablePrice(
          idProduct: _myProduct,
        );
      } else {
        return Container();
      }
    } else {
      return Container();
    }
  }

  Widget txtAutoFillByPhone(
      {TextEditingController controller,
      String error,
      String tittle,
      String type,
      TextInputType txtInputType,
      bool isCustomer,
      bool enabled,
      int maxLength,
      IconData icon,
      FocusNode node}) {
    return isCustomer
        ? Container()
        : Container(
            color: Colors.white,
            margin: EdgeInsets.only(top: 10, left: 10, right: 10),
            child: KeyboardActions(
              disableScroll: true,
              config: keyBoardConfig(context, node, type: type),
              child: TextField(
                focusNode: node,
                controller: controller,
                // initialValue: this.widget.txt,
                maxLength: maxLength,
                autocorrect: false,
                obscureText: false,
                enabled: enabled,
                onChanged: (value) {
                  setState(() {
                    if (tittle.contains("Điện thoại"))
                      phoneNewCustomer = value.trim();
                  });
                },
                onSubmitted: (value) async {
                  if (tittle.contains("Điện thoại")) {
                    errorPhone = await checkPhoneNumber(phoneNewCustomer);
                    if (errorPhone == null)
                      doOnSubmittedTextField(type, phoneNewCustomer);
                    if (errorPhone != null) {
                      phoneNewCustomer = "";
                      // ignore: unnecessary_statements
                      nameNewCustomer == oldCusName
                          ? nameNewCustomer = ""
                          // ignore: unnecessary_statements
                          : null;
                      // ignore: unnecessary_statements
                      customerId == oldCusId ? customerId = "" : null;
                    }
                  }
                },
                maxLines: 1,
                keyboardType: txtInputType,
                // TextInputType.numberWithOptions(signed: true, decimal: true),
                inputFormatters: [
                  txtInputType != TextInputType.number
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
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        if (tittle == "Điện thoại") {
                          phoneNewCustomer = "";
                        }
                      });
                      // ignore: unnecessary_statements
                      controller.clear;
                    },
                    icon: Icon(icon),
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
            ),
          );
  }

  Future<void> doOnSubmittedTextField(String type, String value) async {
    switch (type) {
      case "phone":
        phoneNewCustomer = value.trim();
        infomationCustomer = await getDataCustomerFromPhone(context, value);
        setState(() {
          if (infomationCustomer == null) {
            // ignore: unnecessary_statements
            nameNewCustomer == oldCusName ? nameNewCustomer = "" : null;
            // ignore: unnecessary_statements
            customerId == oldCusId ? customerId = "" : null;
          } else {
            oldCusName = infomationCustomer.fullname;
            nameNewCustomer = infomationCustomer.fullname;
            oldCusId = infomationCustomer.accountId;
            customerId = infomationCustomer.accountId;
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
            node: nodeDegree,
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
            node: nodeQuantity,
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
                if (_myStore == null) {
                  checkChooseStore(context, _myStore);
                } else {
                  if (_myProduct == null) {
                    checkChooseProduct(context, _myProduct);
                  } else {
                    widget.level == 1
                        ? _navigator("Xác nhận bán hàng")
                        : _navigator("Xác nhận giữ giá");
                  }
                }
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

  void _validate() async {
    errorPhone = await checkPhoneNumber(phoneNewCustomer);
    checkChooseProduct(context, _myProduct);
    errorQuantity = await checkQuantity(quantity);
    errorDegree = await checkDegree(checkProduct, degree);
    checkChooseStore(context, _myStore);
    if (errorPhone == null &&
        errorQuantity == null &&
        _myProduct != null &&
        _myStore != null) {
      if (checkProduct || (!checkProduct && errorDegree == null)) {
        if (nameNewCustomer.isNotEmpty) {
          _navigator("Xác nhận hóa đơn");
        } else {
          showEasyLoadingError(context, showMessage("", MSG009));
        }
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
                            if (item.type == 0) {
                              setState(() {
                                checkProduct = false;
                              });
                            } else {
                              setState(() {
                                degree = 0;
                                checkProduct = true;
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

  double checkItemProduct;

  Widget _txtItemProduct(
      {BuildContext context,
      String hintText,
      int maxLines,
      bool isQuantity,
      FocusNode node}) {
    return Container(
      color: Colors.white,
      child: KeyboardActions(
        disableScroll: true,
        config: keyBoardConfig(context, node),
        child: TextField(
          focusNode: node,
          controller: isQuantity ? txtController : null,
          maxLength: 6,
          onChanged: (value) {
            doTextFieldOnChanged(value, isQuantity);
          },
          onSubmitted: (value) async {
            doTextFieldSubmitted(value, isQuantity);
          },
          maxLines: maxLines,
          keyboardType: TextInputType.number,
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
      ),
    );
  }

  doTextFieldOnChanged(value, isQuantity) async {
    try {
      setState(() {
        if (value != null) {
          checkItemProduct = double.parse(value.trim());
        } else {
          if (isQuantity) {
            errorQuantity = checkQuantity(quantity);
          } else
            errorDegree = checkDegree(checkProduct, degree);
        }
      });
    } catch (_) {
      setState(() {
        checkItemProduct = null;
        isQuantity
            ? errorQuantity = showMessage("Số ký", MSG056)
            // ignore: unnecessary_statements
            : {errorDegree = showMessage("Số độ", MSG056), this.degree = 0};
      });
    }
  }

  doTextFieldSubmitted(value, isQuantity) async {
    try {
      checkItemProduct = double.parse(value.trim());
      if (isQuantity) {
        if (checkItemProduct > 0) {
          insertQuantity("$checkItemProduct");
          quantity = 0;
          listQuantity.forEach((element) {
            quantity += double.parse(element);
          });
          txtController.clear();
          errorQuantity = await checkQuantity(quantity);
          checkItemProduct = null;
        }
      } else {
        this.degree = double.parse(value.isEmpty ? "0" : value);
        errorDegree = await checkDegree(checkProduct, degree);
      }
    } catch (_) {
      print('Lỗi add_product_invoice => _txtItemProduct $checkItemProduct');
      setState(() {
        checkItemProduct = null;
        isQuantity
            ? value.isEmpty
                ? errorQuantity = checkQuantity(quantity)
                : errorQuantity = showMessage("Số ký", MSG056)
            // ignore: unnecessary_statements
            : {
                value.isEmpty
                    ? errorDegree = checkDegree(checkProduct, degree)
                    : errorDegree = showMessage("Số độ", MSG056),
                this.degree = 0
              };
      });
    }
  }

  //Hiển thị ra các container nhỏ khi nhập số cân
  Widget containerWeight({String value}) {
    return GestureDetector(
      onTap: () async {
        setState(() {
          removeAtQuantity(value);
          quantity = 0;
          listQuantity.forEach((element) {
            quantity += double.parse(element);
          });
        });
        errorQuantity = await checkQuantity(quantity);
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
          price = element.price.toString();
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
              ///Nếu muốn cho customer chọn ngày thì mở comment dòng này
              if (widget.dateToPay == null) {
                DatePicker.showDatePicker(
                  context,
                  showTitleActions: true,
                  onConfirm: (date) {
                    setState(() {
                      dateSale = date;
                    });
                  },
                  minTime: DateTime.now(),
                  maxTime: DateTime.now().subtract(Duration(days: -6)),
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

  Widget btnCurrentPrice(context, String price, {String tittle}) {
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
              "${tittle == null ? widget.dateToPay != null ? "Giá đã giữ" : "Giá hiện tại" : tittle}",
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

  Future<void> _navigator(String tittle) async {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => FormForDetailPage(
                  tittle: tittle,
                  bodyPage: confirmDetailInvoice(
                    level: widget.level,
                    storeId: "$_myStore",
                    productId: "$_myProduct",
                    customerId: "$customerId",
                    invoiceRequestId: widget.invoiceRequestId,
                    customerName: "$nameNewCustomer",
                    phoneNumber: "$phoneNewCustomer",
                    dateToPay: "$dateSale",
                    degree: "$degree",
                    quantity: "$quantity",
                    price: "${widget.dateToPay != null ? priceSell : price}",
                    productName: "$productName",
                    storeName: "$storeName",
                    widgetToNavigator: widget.widgetToNavigator == null
                        ? HomeAdminPage(
                            index: 1,
                            indexInsidePage: 1,
                          )
                        : widget.widgetToNavigator,
                    isCustomer: widget.isCustomer,
                  ),
                )));
  }

  checkKeyBoardConfig(node, {String type}) async {
    if (node == nodePhone) {
      errorPhone = await checkPhoneNumber(phoneNewCustomer);
      if (errorPhone == null) doOnSubmittedTextField(type, phoneNewCustomer);
      if (errorPhone != null) {
        phoneNewCustomer = "";
        // ignore: unnecessary_statements
        nameNewCustomer == oldCusName
            ? nameNewCustomer = ""
            // ignore: unnecessary_statements
            : null;
        // ignore: unnecessary_statements
        customerId == oldCusId ? customerId = "" : null;
      }
    }
    if (node == nodeQuantity) {
      if (checkItemProduct != null) {
        if (checkItemProduct > 0) {
          insertQuantity("$checkItemProduct");
          quantity = 0;
          listQuantity.forEach((element) {
            quantity += double.parse(element);
          });
          txtController.clear();
          checkItemProduct = null;
          errorQuantity = await checkQuantity(quantity);
        }
      } else
        errorQuantity = await checkQuantity(quantity);
    }
    if (node == nodeDegree) {
      if (checkItemProduct != null) {
        print(checkItemProduct);
        String value = "$checkItemProduct";
        this.degree = double.parse(value.isEmpty ? "0" : value);
        errorDegree = await checkDegree(checkProduct, degree);
        checkItemProduct = null;
      } else
        // setState(() {
        //     if(valueCheckDegree.isEmpty || valueCheckDegree == null)  degree = 0;
        //   });
        errorDegree = await checkDegree(checkProduct, degree);
    }
  }
}
