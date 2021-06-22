import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:rtm_system/model/getAPI_allStore.dart';
import 'package:rtm_system/model/getAPI_product.dart';
import 'package:rtm_system/model/model_product.dart';
import 'package:rtm_system/model/model_store.dart';
import 'package:rtm_system/ultils/alertDialog.dart';
import 'package:rtm_system/ultils/component.dart';
import 'package:rtm_system/ultils/helpers.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';
import 'package:rtm_system/ultils/src/messageList.dart';
import 'package:rtm_system/view/create_invoice.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddProductPage extends StatefulWidget {
  final String tittle;
  final Widget widgetToNavigator;
  //true is Customer role
  final bool isCustomer;

  AddProductPage({this.tittle, this.isCustomer, this.widgetToNavigator});

  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  String price = '0';
  String token;
  String personSale = '', phoneSale = '';
  List listQuantity = [];
  List<DataProduct> dataListProduct = [];
  bool checkClick = false;
  var txtController = TextEditingController();

  //field to sales
  double quantity = 0, degree = 0;
  List listInfor;

  String _mySelection, _selectStore;
  bool checkProduct = true;

  DateTime dateNow = DateTime.now();
  DateTime dateSale = DateTime.now();

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
  int _pageSize = 1;
  final PagingController<int, StoreElement> _pagingController =
  PagingController(firstPageKey: 10);
  Store store;
  List<StoreElement> storeList;


  Future<void> _fetchPage(pageKey) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      GetAPIAllStore getAPIAllStore = GetAPIAllStore();
      store = await getAPIAllStore.getStores(
        prefs.get("access_token"),
        pageKey,
        _pageSize,
      );
      storeList =  store.stores;
      final isLastPage = storeList.length < pageKey;
      if (isLastPage) {
        _pagingController.appendLastPage(storeList);
      } else {
        setState(() {
          _pageSize += 1;
        });
        final nextPageKey = pageKey;
        _pagingController.appendPage(storeList, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getProduct();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    _pagingController.addStatusListener((status) {
      if (status == PagingStatus.subsequentPageError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
              'Something went wrong while fetching a new page.',
            ),
            action: SnackBarAction(
              label: 'Thử lại',
              onPressed: () => _pagingController.retryLastFailedRequest(),
            ),
          ),
        );
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
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
                    Container(
                      margin: EdgeInsets.fromLTRB(12, 0, 12, 12),
                      child: Column(children: [
                        Container(
                          height: size.height * 0.08,
                          child: CustomScrollView(
                            slivers: <Widget>[
                              PagedSliverList<int, StoreElement>(
                                pagingController: _pagingController,
                                builderDelegate: PagedChildBuilderDelegate<StoreElement>(
                                    firstPageErrorIndicatorBuilder: (context) {
                                      return Column(
                                        children: [
                                          firstPageErrorIndicatorBuilder(context,
                                              tittle: showMessage(null, MSG008)),
                                          GestureDetector(
                                            onTap: () => _pagingController.refresh(),
                                            child: Text(
                                              showMessage(null, MSG027),
                                              style: TextStyle(color: welcome_color, fontSize: 18),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                    firstPageProgressIndicatorBuilder: (context) =>
                                        firstPageProgressIndicatorBuilder(),
                                    newPageProgressIndicatorBuilder: (context) =>
                                        newPageProgressIndicatorBuilder(),
                                    itemBuilder: (context, item, index) {
                                      return _dropdownListStore();
                                    }
                                ),
                              ),
                            ],
                          ),
                        ),
                        // show product from API
                        _dropdownList(),
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
                          height: 10,
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
                btnSave(context, size.width * 0.7, size.height * 0.05, Color(0xFF0BB791), "Tạo", 1),
                SizedBox(
                  height: 10,
                ),
              ],
            )),
      ),
    );
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
            '${title}:',
            style: TextStyle(
              color: Color(0xFF0BB791),
              fontSize: 14,
            ),
          ),
          // sẽ show số tổng các ký đã nhập
          Text(
            '${value}',
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
                if (_selectStore == null) {
                  showCustomDialog(
                    context,
                    content: "Chưa chọn cửa hàng",
                    isSuccess: false,
                  );
                } else if (_mySelection == null) {
                  showCustomDialog(
                    context,
                    content: "Chưa chọn sản phẩm",
                    isSuccess: false,
                  );
                } else {

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CreateInvoicePage(
                            isNew: true,
                            listProduct: listInfor,
                            isCustomer: widget.isCustomer)),
                  );
                }
              } else{
                if (_selectStore == null) {
                  showCustomDialog(
                    context,
                    content: "Chưa chọn cửa hàng",
                    isSuccess: false,
                  );
                } else if (_mySelection == null) {
                  showCustomDialog(
                    context,
                    content: "Chưa chọn sản phẩm",
                    isSuccess: false,
                  );
                }else if (quantity == 0) {
                  showCustomDialog(
                    context,
                    content: "Số ký đang trống",
                    isSuccess: false,
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CreateInvoicePage(
                            isNew: true,
                            listProduct: listInfor,
                            isCustomer: widget.isCustomer)),
                  );
                }
              }

              // }
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
                      hint: Text('Chọn sản phẩm'),
                      onChanged: (String newValue) async {
                        setState(() {
                          _mySelection = newValue;
                          _getCurrentPrice(newValue);
                          this.listInfor = [
                            this._mySelection,
                            this.quantity,
                            this.degree,
                            getDateTime("$dateSale", dateFormat: "yyyy-MM-dd HH:mm:ss"),
                            this._selectStore,
                          ];
                        });
                        setState(() {
                          _mySelection == "SP-1000003" ? checkProduct = false : checkProduct = true;
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
        // _underRow()
      ],
    );
  }
  Widget _dropdownListStore() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
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
                      value: _selectStore,
                      iconSize: 30,
                      icon: (null),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      hint: Text('Chọn cửa hàng'),
                      onChanged: (String newValue) async {
                        setState(() {
                          _selectStore = newValue;
                          this.listInfor = [
                            this._mySelection,
                            this.quantity,
                            this.degree,
                            getDateTime("$dateSale", dateFormat: "yyyy-MM-dd HH:mm:ss"),
                            this._selectStore,
                          ];
                        });
                      },
                      items: storeList?.map((item) {
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
        // _underRow()
      ],
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
            this.listInfor = [
              this._mySelection,
              this.quantity,
              this.degree,
              getDateTime("$dateSale", dateFormat: "yyyy-MM-dd HH:mm:ss"),
              this._selectStore,
            ];
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
          this.listInfor = [
            this._mySelection,
            this.quantity,
            this.degree,
            getDateTime("$dateSale", dateFormat: "yyyy-MM-dd HH:mm:ss"),
            this._selectStore,
          ];
        });
      },
      child: Container(
          margin: EdgeInsets.only(top: 10),
          width: 60,
          height: 30,
          decoration: BoxDecoration(
            color: Colors.black26,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Center(
              child: Text(
            "$value",
            style: TextStyle(color: Colors.white),
          ))),
    );
  }

  //Lấy giá tiền
  Future _getCurrentPrice(String value)  {
    setState(() {
      dataListProduct.forEach((element) {
        if(element.id == value){
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
    var size = MediaQuery.of(context).size;
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
              DatePicker.showDatePicker(
                context,
                showTitleActions: true,
                onConfirm: (date) {
                  setState(() {
                    dateSale = date;
                    this.listInfor = [
                      this._mySelection,
                      this.quantity,
                      this.degree,
                      getDateTime("$dateSale", dateFormat: "yyyy-MM-dd HH:mm:ss"),
                      this._selectStore,
                    ];
                  });
                },
                currentTime: dateNow,
                maxTime: DateTime(DateTime.now().year + 100, 12, 31),
                minTime: DateTime(DateTime.now().year, DateTime.now().month,
                    DateTime.now().day),
                locale: LocaleType.vi,
              );
            },
            child: Row(
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
                  child: Text(
                    '${getDateTime("$dateSale", dateFormat: "dd/MM/yyyy")}',
                    style: TextStyle(fontSize: 16),
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
              "Giá hiên tại",
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
              width: 70,
              child: Text("VNĐ")),
        ],
      ),
    );
  }
}
