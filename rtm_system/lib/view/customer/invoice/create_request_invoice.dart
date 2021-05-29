import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:rtm_system/model/getAPI_product.dart';
import 'package:rtm_system/model/model_product.dart';
import 'package:rtm_system/ultils/alertDialog.dart';
import 'package:rtm_system/ultils/component.dart';
import 'package:rtm_system/view/customer/home_customer_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateRequestInvoice extends StatefulWidget {
  const CreateRequestInvoice({Key key}) : super(key: key);

  @override
  _CreateRequestInvoiceState createState() => _CreateRequestInvoiceState();
}

final _formKey = GlobalKey<FormState>();

class _CreateRequestInvoiceState extends State<CreateRequestInvoice> {
  final f = new DateFormat('dd/MM/yyyy');
  String money;
  DateTime dateNow = DateTime.now();
  String status = 'Dang cho';
  String token;
  List<DataProduct> dataListProduct = [];

  Future _getProduct() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString("access_token");
    });
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
  bool checkProduct = false;

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
                      child: Column(
                        children: [
                          txtPersonInvoice(context, 'Người mua', 'Nguyen Van A',
                              '0123456789'),
                          SizedBox(
                            height: 10,
                          ),
                          txtPersonInvoice(context, 'Người bán', 'Nguyen Van A',
                              '087654322'),
                          SizedBox(
                            height: 10,
                          ),
                          // show product from API
                          _dropdownList(),
                          _txtItemProduct(context, 'So ky'),
                          SizedBox(
                            height: 10,
                          ),
                          // if (checkProduct)
                            _txtItemProduct(context, 'So do'),
                        ],
                      ),
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
                    btnCreateOrCancel(context, 120, 40, Colors.redAccent, "Hủy",
                        "yeu cau ban hang", false, 1),
                    SizedBox(width: 20),
                    btnCreateOrCancel(context, 140, 40, Color(0xFF0BB791),
                        "Tạo", "yeu cau ban hang", true, 1),
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

// use to create or cancel in create request advance/ invoice
  Widget btnCreateOrCancel(
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
              if (_formKey.currentState.validate()) {
                //call api post
                int status = 200;
                // await postAPINotice(mainTittle, content);
                if (status == 200) {
                  // show success with infor (in detail)
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (context) => DetailAdvancePage(status: 'Dang cho')),
                  // );
                } else
                  showStatusAlertDialog(
                      context,
                      "Tạo ${contentFeature} thất bại.\n Vui long thử lại!",
                      null,
                      false);
              }
            } else {
              showAlertDialog(
                  context,
                  "Bạn muốn hủy tạo ${contentFeature} ?",
                  HomeCustomerPage(
                    index: indexOfBottomBar,
                  ));
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
                  setState(() {});
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
                      if (_mySelection == 'Mủ nước')
                        setState(() {
                          checkProduct = true;
                        });
                    },
                    items: dataListProduct?.map((item) {
                          return new DropdownMenuItem(
                            child: new Text(item.name),
                            value: item.id.toString(),
                          );
                        })?.toList() ??
                        [],
                  ),
                ),
              ),
            ),
          ],
        )
        // _underRow()
      ],
    );
  }

  Widget _txtItemProduct(context, String title) {
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
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.left,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _underRow() {
    var size = MediaQuery.of(context).size;
    return SizedBox(
      height: 1,
      child: Container(
        // margin: EdgeInsets.only(left: 10, right: 10),
        width: size.width,
        color: Colors.black38,
      ),
    );
  }
}
