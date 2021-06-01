import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:rtm_system/ultils/alertDialog.dart';
import 'package:rtm_system/ultils/component.dart';
import 'package:rtm_system/ultils/src/regExp.dart';
import 'package:rtm_system/view/customer/advance/detail_advance.dart';
import 'package:rtm_system/view/customer/home_customer_page.dart';

class CreateRequestAdvance extends StatefulWidget {
  const CreateRequestAdvance({Key key}) : super(key: key);

  @override
  _CreateRequestAdvanceState createState() => _CreateRequestAdvanceState();
}

final _formKey = GlobalKey<FormState>();

class _CreateRequestAdvanceState extends State<CreateRequestAdvance> {
  final f = new DateFormat('dd/MM/yyyy');
  String money;
  DateTime dateNow = DateTime.now();
  DateTime dateSale = DateTime.now();
  String status = 'Dang cho';
  @override
  void initState() {
    // TODO: implement initState
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEEEEEE),
      appBar: AppBar(
        leading: leadingAppbar(context),
        centerTitle: true,
        backgroundColor: Color(0xFF0BB791),
        title: Text(
          "Tạo yêu cầu ứng tiền",
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
                    _formMoney(false, "Nhập số tiền VND", "Số tiền",
                        TextInputType.number),
                    SizedBox(
                      height: 20,
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
                    btnCreateOrCancel(context, 120, 40, Colors.redAccent,
                          "Hủy", "yeu cau ung tien", false, 0),
                    SizedBox(width: 20),
                    btnCreateOrCancel(context, 140, 40, Color(0xFF0BB791),
                        "Tạo", "yeu cau ung tien", true, 0),
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
      int indexOfBottomBar,) {
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
                  // await postAPIAdvance(money, dateSale);
                  if (status == 200) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DetailAdvancePage(status: 'Dang cho')),
                    );
                  } else
                    showStatusAlertDialog(
                        context, "Tạo ${contentFeature} thất bại.\n Vui long thử lại!", null, false);
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
  Widget _formMoney(
      bool obscureText, String hintText, String tittle, TextInputType txtType) {
    return Form(
      key: _formKey,
      child: Container(
        color: Colors.white,
        margin: EdgeInsets.only(top: 10, left: 10, right: 10),
        child: TextFormField(
          // The validator receives the text that the user has entered.
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'So tien k de trong';
            } else if (!checkFormatMoney.hasMatch(value)) {
              return "Số tien chỉ nhập số";
            } else if (!checkLengthMoney.hasMatch(value)) {
              print(value);
              return "So tien lon hon 10,000 VND";
            }
            return null;
          },
          maxLines: 1,
          keyboardType: txtType,
          inputFormatters: [ThousandsSeparatorInputFormatter()],
          obscureText: obscureText,
          onChanged: (value) {
            this.money = value;
            // print(value);
            // print(errMoney);
          },
          style: TextStyle(fontSize: 16),
          cursorColor: Color(0xFF0BB791),
          decoration: InputDecoration(
            border: UnderlineInputBorder(),
            hintText: '$hintText',
            //Sau khi click vào "Nhập so tien" thì màu viền sẽ đổi
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xFF0BB791),
              ),
            ),

            //Hiển thị text góc phải
            prefixIcon: Container(
                margin: EdgeInsets.only(top: 15, left: 5),
                width: 100,
                child: AutoSizeText(
                  "${tittle}",
                  style: TextStyle(fontWeight: FontWeight.w500),
                )),
            //Hiển thị Icon góc phải
            suffixIcon: Icon(
              Icons.create,
              color: Colors.black54,
            ),
            contentPadding: EdgeInsets.all(15),
          ),
        ),
      ),
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
                    dateSale = date;
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
                  width: 100,
                  margin: EdgeInsets.only(left: 15),
                  child: Text(
                    "Ngày bán",
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
}
