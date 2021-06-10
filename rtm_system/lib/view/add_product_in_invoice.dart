import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rtm_system/model/getAPI_product.dart';
import 'package:rtm_system/model/model_product.dart';
import 'package:rtm_system/ultils/alertDialog.dart';
import 'package:rtm_system/ultils/component.dart';
import 'package:rtm_system/ultils/src/regExp.dart';
import 'package:rtm_system/view/create_invoice.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddProductPage extends StatefulWidget {
  final String tittle;

  //true is Customer role
  final bool isCustomer;

  AddProductPage({this.tittle, this.isCustomer});

  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  String token;
  List listQuantity = [];
  List<DataProduct> dataListProduct = [];
  bool checkClick = false;
  var txtController = TextEditingController();

  //field to sales
  double quantity = 0, degree;
  String status = 'Dang cho';
  String personSale = '', phoneSale = '';
  String errQuantity, errDegree;
  String errNameProduct;

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
        leading: leadingAppbar(context),
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
                    Container(
                      margin: EdgeInsets.fromLTRB(12, 0, 12, 12),
                      child: Column(children: [
                        // show product from API
                        _dropdownList(),
                        _mySelection == null
                            ? Container()
                            : _txtItemProduct(
                                context: context,
                                hintText: 'Nhập số ký',
                                maxLines: 1,
                                isQuantity: true,
                                error: errQuantity),
                        //sẽ làm add thêm dòng để nhập tiếp(giống form số ký) để
                        // khách có thể xem số lần mình nhập, hoặc chỉnh sửa.
                        // Chưa làm dk.
                        Wrap(
                          direction: Axis.horizontal,
                          spacing: 5,
                          children: listQuantity
                              .map((value) => containerWeight(value: value))
                              .toList()
                              .cast<Widget>(),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        _checkNameProduct(),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          color: Colors.white,
                          padding: EdgeInsets.only(left: 12, right: 12),
                          height: 45,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Tống số ký:',
                                style: TextStyle(
                                  color: Color(0xFF0BB791),
                                  fontSize: 14,
                                ),
                              ),
                              // sẽ show số tổng các ký đã nhập
                              Text(
                                '${quantity} kg',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          color: Colors.white,
                          padding: EdgeInsets.only(left: 12, right: 12),
                          height: 45,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Thành tiền:',
                                style: TextStyle(
                                  color: Color(0xFF0BB791),
                                  fontSize: 14,
                                ),
                              ),
                              // sẽ show số tổng các ký đã nhập
                              Text(
                                '1,000,000 VND',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        )
                      ]),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                btnSave(context, 140, 40, Color(0xFF0BB791), "Tạo",
                    "yeu cau ban hang", 1),
                SizedBox(
                  height: 10,
                ),
              ],
            )),
      ),
    );
  }

  TextEditingController getDataTextField(txt) {
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
    if (this.quantity == null || this.quantity == "") {
      setState(() {
        this.errQuantity = null;
      });
    } else {
      if (!checkFormatNumber.hasMatch("${this.quantity}")) {
        setState(() {
          this.errQuantity = "Chỉ nhập số(ví dụ: 12,3 hoặc 12.3)";
        });
      } else {
        setState(() {
          this.errQuantity = null;
        });
      }
    }
    if (this.degree == null || this.degree == "") {
      setState(() {
        this.errDegree = null;
      });
    } else {
      if (!checkFormatNumber.hasMatch("${this.degree}")) {
        setState(() {
          this.errDegree = "Chỉ nhập số(ví dụ: 12,3 hoặc 12.3)";
        });
      } else {
        setState(() {
          this.errDegree = null;
        });
      }
    }
    // co check date thi dung cai nay
    // if (this.dateSale.isBefore(dateNow)) {
    //   setState(() {
    //     this.errDateSale = 'Thời gian trong quá khứ không hợp lệ.';
    //   });
    // } else {
    //   setState(() {
    //     this.errDateSale = null;
    //   });
    // }
    if (this._mySelection == null || this._mySelection == '') {
      setState(() {
        this.errNameProduct = 'Sản phẩm không được để trống.';
      });
    } else {
      setState(() {
        this.errNameProduct = null;
      });
    }
    if (this.errQuantity == null &&
        this.errDegree == null &&
        this.errNameProduct == null) {
      check = true;
    }

    return check;
  }

  Widget _checkNameProduct() {
    return checkProduct
        ? Container()
        : _txtItemProduct(
            context: context,
            isQuantity: false,
            hintText: 'Nhập số độ',
            maxLines: 1,
            error: errDegree);
  }

  //
  // Widget btnCancel(
  //   BuildContext context,
  //   double width,
  //   double height,
  //   Color color,
  //   String tittleButtonAlertDialog,
  //   String contentFeature,
  //   bool action,
  //   int indexOfBottomBar,
  // ) {
  //   return Container(
  //     height: height,
  //     width: width,
  //     decoration: BoxDecoration(
  //       color: color,
  //       borderRadius: BorderRadius.circular(5),
  //     ),
  //     child: FlatButton(
  //         onPressed: () async {
  //           if (action) {
  //             showAlertDialog(
  //               context,
  //               "Bạn muốn hủy tạo ${contentFeature} ?",
  //               HomeCustomerPage(
  //                 index: indexOfBottomBar,
  //               ),
  //             );
  //           }
  //         },
  //         child: Center(
  //             child: Text(
  //           tittleButtonAlertDialog,
  //           style: TextStyle(
  //               color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
  //         ))),
  //   );
  // }

  Widget btnSave(
    BuildContext context,
    double width,
    double height,
    Color color,
    String tittleButtonAlertDialog,
    String contentFeature,
    int indexOfBottomBar,
  ) {
    var size = MediaQuery.of(context).size;

    return Container(
      height: height,
      width: size.width * 0.7,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextButton(
          onPressed: () {
            setState(() {
              if (checkClick) {
                bool check = _validateData();
                if (check) {
                  //chuyen page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CreateInvoicePage(
                              isNew: true,
                              idProduct: _mySelection,
                            )),
                  );
                }
              } else {
                showStatusAlertDialog(
                    context, "Thông tin chưa thay đổi !!!", null, false);
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

  Widget _dropdownList() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
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
          ],
        ),
        Row(
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
            ),
          ],
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

  Widget _txtItemProduct(
      {BuildContext context,
      String hintText,
      int maxLines,
      String error,
      bool isQuantity}) {
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
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.deny(RegExp(r'[-,/\\ ]'))
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
          errorText: errQuantity,
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
          width: 50,
          height: 30,
          decoration: BoxDecoration(
            color: Colors.black38,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Center(
              child: Text(
            "$value",
            style: TextStyle(color: Colors.white),
          ))),
    );
  }

  //Xóa các phần tử trong list cân
  void removeAtQuantity(String value) {
    return listQuantity.removeAt(listQuantity.indexOf(value));
  }

  //Thêm các phần tử trong list cân
  void insertQuantity(String value) {
    return listQuantity.add(value);
  }
}
