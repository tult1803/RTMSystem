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

  Future _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString("access_token");
    });
  }

  Future _getProduct() async {
    List<dynamic> dataList = [];
    GetProduct getProduct = GetProduct();
    //Nếu dùng hàm này thì FutureBuilder sẽ chạy vòng lập vô hạn
    //Phải gọi _getToken trước khi gọi hàm _getProduct
    // await _getToken();
    // gọi APIProduct và lấy dữ liệu

    //Khi click nhiều lần vào button "Sản phẩm" thì sẽ có hiện tượng dữ liệu bị ghi đè
    //Clear là để xoá dữ liệu cũ, ghi lại dữ liệu mới
    dataListProduct.clear();

    //Nếu ko có If khi FutureBuilder gọi hàm _getProduct lần đầu thì Token chưa trả về nên sẽ bằng null
    //FutureBuilder sẽ gọi đến khi nào có giá trị trả về
    //Ở lần gọi thứ 2 thì token mới có giá trị
    if (token.isNotEmpty) {
      dataList = await getProduct.createLogin(token, 0);
      //Parse dữ liệu
      dataList.forEach((element) {
        Map<dynamic, dynamic> data = element;
        dataListProduct.add(DataProduct.fromJson(data));
      });

      return dataListProduct;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getToken();
  }

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
                          _dropdownList(),
                          SizedBox(
                            height: 10,
                          ),
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
                  showStatusAlertDialog(
                      context,
                      "Đã tạo ${contentFeature} thành công.",
                      HomeCustomerPage(
                        index: indexOfBottomBar,
                      ),
                      true);
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
            child: Row(
              children: [
                Container(
                  width: 100,
                  margin: EdgeInsets.only(left: 15),
                  child: Text(
                    "Ngày ban",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                  ),
                ),
                Expanded(
                  child: Text(
                    '${f.format(dateNow)}',
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
  //can get API all product

  Widget _dropdownList() {
    String chosenValue;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('San pham',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
            )),
        DropdownButton<String>(
          focusColor: Colors.white,
          value: chosenValue,
          //elevation: 5,
          style: TextStyle(color: Colors.white),
          iconEnabledColor: Colors.black,
          items: <String>[
            'Mu nuoc',
            'Mu chen',
            'Mu dong',
            'Mu day',
            'Mu dat',
          ].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: TextStyle(color: Colors.black),
              ),
            );
          }).toList(),
          hint: Text("",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
              )),
          onChanged: (String value) {
            print(value);
            setState(() {
              chosenValue = value;
            });
          },

        )
      ],
    );
  }
}
