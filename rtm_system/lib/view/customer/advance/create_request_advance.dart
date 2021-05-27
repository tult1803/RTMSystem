
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

class CreateRequestAdvance extends StatefulWidget {
  const CreateRequestAdvance({Key key}) : super(key: key);

  @override
  _CreateRequestAdvanceState createState() => _CreateRequestAdvanceState();
}

class _CreateRequestAdvanceState extends State<CreateRequestAdvance> {
  final f = new DateFormat('dd/MM/yyyy');
  DateTime dateNow = DateTime.now();
  String errMoney;
  @override
  void initState() {
    // TODO: implement initState
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffEEEEEE),
        appBar: AppBar(
          backgroundColor: Color(0xFF0BB791),
          centerTitle: true,
          title: Text(
            "Tạo yêu cầu ứng tiền",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w500, fontSize: 22),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            // color: Colors.white,
              margin: EdgeInsets.only(top: 50),
              child: Column(
              children: [
                Column(
                  children: [
                    _txtfield(getDataTextField(''), false,
                        "Nhập số tiền", "Số tiền", errMoney, 1, TextInputType.text),
                    SizedBox(height: 20,),
                    btnBirthday(context),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // btnSubmitOrCancel(context, 120, 40, Colors.redAccent, "Hủy", "",
                    //     "", null, false, 4),
                    SizedBox(width: 20),
                    // btnSubmitValidate(
                    //     context, 120, 40, welcome_color, "Kiểm tra", this.widget.list, this.widget.check),
                  ],
                ),
              ],
            )
          ),
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
  Widget _txtfield(
      TextEditingController _controller,
      bool obscureText,
      String hintText,
      String tittle,
      String error,
      int maxLines,
      TextInputType txtType) {
    return Container(
      margin: EdgeInsets.only(top: 10, left: 10, right: 10),
      child: TextField(
        controller: _controller,
        obscureText: obscureText,
        onChanged: (value) {
          // if (tittle == "Họ và tên") {
          //   this.widget.fullname = value.trim();
          // } else if (tittle == "Số điện thoại") {
          //   this.widget.phone = value.trim();
          // } else if (tittle == "CMND/CCCD") {
          //   this.widget.cmnd = value.trim();
          // } else if (tittle == "Địa chỉ") {
          //   this.widget.address = value.trim();
          // } else if (tittle == "Mật khẩu") {
          //   this.widget.password = value.trim();
          // }
          setState(() {
          });
        },
        maxLines: maxLines,
        keyboardType: txtType,
        style: TextStyle(fontSize: 15),
        cursorColor: Color(0xFF0BB791),
        decoration: InputDecoration(
          border: UnderlineInputBorder(),
          hintText: '$hintText',

          //Sau khi click vào "Nhập tiêu đề" thì màu viền sẽ đổi
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF0BB791),),
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

          //Hiển thị lỗi
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.redAccent),
          ),
          //Nhận thông báo lỗi
          errorText: error,

          contentPadding: EdgeInsets.all(15),
        ),
      ),
    );
  }
  Widget btnBirthday(context) {
    var size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              DatePicker.showDatePicker(
                context,
                showTitleActions: true,
                onConfirm: (date) {
                  setState(() {
                  });
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
                    "Ngày sinh",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                  ),
                ),
                Expanded(
                  child: Text(
                    '${f.format(dateNow)}',
                    style: TextStyle(color: Colors.black54, fontSize: 16),
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
