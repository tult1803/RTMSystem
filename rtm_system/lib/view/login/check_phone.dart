import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:keyboard_actions/keyboard_actions_config.dart';
import 'package:rtm_system/helpers/component.dart';
import 'package:rtm_system/ultils/check_data.dart';
import 'package:rtm_system/ultils/get_api_data.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';
import 'otp/otp_screen.dart';

class CheckPhone extends StatefulWidget {
  final bool isLogin;

  const CheckPhone({this.isLogin});

  @override
  _CheckPhoneState createState() => _CheckPhoneState();
}

String pin1, pin2, pin3, pin4, pin5, pin6;

class _CheckPhoneState extends State<CheckPhone> {
  String phone, errorPhone;
  final FocusNode _nodePhone = FocusNode();

  @override
  void initState() {
    super.initState();
    pin1 = null;
    pin2 = null;
    pin3 = null;
    pin4 = null;
    pin5 = null;
    pin6 = null;
  }

  @override
  void dispose() {
    super.dispose();
    _nodePhone.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        leading: leadingAppbar(context, colorIcon: Colors.white),
        centerTitle: true,
        title: titleAppBar(widget.isLogin ? "Đăng nhập" : "Quên mật khẩu"),
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.only(left: 20, right: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black54,
                blurRadius: 3,
                offset: Offset(1, 1), // Shadow position
              ),
            ],
          ),
          width: size.width,
          height: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _txtfield("Nhập số điện thoại", errorPhone),
              SizedBox(height: 20),
              Container(
                  width: 280,
                  height: 40,
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
                      onPressed: () async {
                        setState(() {
                          errorPhone = checkPhoneNumber(phone);
                        });
                        if (errorPhone == null) {
                          bool check = await doCheckAccount(context, phone);
                          if (check)
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => OtpScreen(
                                      phoneNumber: phone,
                                      isLogin: widget.isLogin,
                                    )));
                        }
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
      ),
    );
  }

  KeyboardActionsConfig keyBoardConfig(BuildContext context) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
      // keyboardBarColor: Colors.grey[200],
      nextFocus: true,
      actions: [
        KeyboardActionsItem(
          focusNode: _nodePhone,
          displayDoneButton: true,
          onTapAction: () {
            errorPhone = checkPhoneNumber(phone);
          },
        ),
      ],
    );
  }

  Widget _txtfield(String hintText, String error) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      width: 280,
      child: KeyboardActions(
        config: keyBoardConfig(context),
        disableScroll: true,
        child: TextField(
          focusNode: _nodePhone,
          autofocus: true,
          textAlign: TextAlign.left,
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
      ),
    );
  }
}
