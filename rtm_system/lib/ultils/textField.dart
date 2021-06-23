import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rtm_system/ultils/getData.dart';
import 'package:rtm_system/view/add_product_in_invoice.dart';

class textField extends StatefulWidget {
  String txt, tittle, error, type;
  TextInputType txtInputType;
  TextEditingController controller;
  textField({this.type, this.txt, this.txtInputType, this.tittle, this.error, this.controller});

  @override
  _textFieldState createState() => _textFieldState();
}


class _textFieldState extends State<textField> {

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(top: 10, left: 10, right: 10),
      child: TextField(
        controller: this.widget.controller,
        // initialValue: this.widget.txt,
        obscureText: false,
        onSubmitted: (value) async {
          switch (this.widget.type) {
            case "phone":
              phoneNewCustomer = value.trim();
              infomationCustomer = await getDataCustomerFromPhone(value);
              break;
            case "name":
              nameNewCustomer = value.trim();
              break;
          }
        },
        maxLines: 1,
        keyboardType: this.widget.txtInputType,
        // TextInputType.numberWithOptions(signed: true, decimal: true),
        inputFormatters: [
          this.widget.txtInputType !=
                  TextInputType.numberWithOptions(signed: true, decimal: true)
              ? FilteringTextInputFormatter.allow(RegExp(r'[ [a-zA-Z0-9]'))
              : FilteringTextInputFormatter.allow(RegExp(r'[[0-9]')),
        ],
        style: TextStyle(fontSize: 15),
        cursorColor: Colors.red,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
          ),
          labelText: this.widget.tittle,
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
          errorText: this.widget.error,
        ),
      ),
    );
  }
}
