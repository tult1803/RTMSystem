import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rtm_system/helpers/component.dart';
import 'package:rtm_system/ultils/check_data.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';
import 'package:rtm_system/view/otp/otp_screen.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

String pin1, pin2, pin3, pin4, pin5, pin6;

class _ForgotPasswordState extends State<ForgotPassword> {
  String phone, errorPhone;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pin1 = null;
    pin2 = null;
    pin3 = null;
    pin4 = null;
    pin5 = null;
    pin6 = null;
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: leadingAppbar(context, colorIcon: Colors.white),
        centerTitle: true,
        title: titleAppBar("Quên mật khẩu"),
      ),
      body: Container(
        width: size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _txtfield("Nhập số điện thoại", errorPhone),
            SizedBox(height: 20),
            Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: welcome_color,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black54,
                      blurRadius: 3,
                      offset: Offset(1, 1), // Shadow position
                    ),
                  ],
                ),
                // ignore: deprecated_member_use
                child: FlatButton(
                    onPressed: () {
                        setState(() {
                          errorPhone = checkPhoneNumber(phone);
                          if (errorPhone == null)
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => OtpScreen(
                                      phoneNumber: phone,
                                    )));});
                    },
                    child: Text(
                      "Xác nhận",
                      style: GoogleFonts.roboto(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 17),
                    )))
          ],
        ),
      ),
    );
  }

  Widget _txtfield(String hintText, String error) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      width: 280,
      child: TextField(
        autofocus: true,
        textAlign: TextAlign.center,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'[[0-9]')),
        ],
        onChanged: (value) {
          phone = value.trim();
        },
        onSubmitted: (value) {
          setState(() {
            errorPhone = checkPhoneNumber(value.trim());
          });
        },
        maxLines: 1,
        keyboardType: TextInputType.number,
        style: TextStyle(fontSize: 20),
        cursorColor: welcome_color,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: welcome_color),
          ),
          hintText: '$hintText',
          //Sau khi click vào "Nhập tiêu đề" thì màu viền sẽ đổi
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: welcome_color),
          ),
          //Hiển thị Icon góc phải
          suffixIcon: Icon(
            Icons.phone_iphone,
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

}
