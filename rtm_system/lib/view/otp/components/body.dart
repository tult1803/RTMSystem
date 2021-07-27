import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rtm_system/helpers/dialog.dart';
import 'package:rtm_system/ultils/check_data.dart';
import 'package:rtm_system/ultils/src/message_list.dart';


import '../../forgot_password.dart';
import 'otp_form.dart';

class Body extends StatefulWidget {
  final String phoneNumber;

  Body({this.phoneNumber});
  @override
  _BodyState createState() => _BodyState();
}


class _BodyState extends State<Body> {
  int timeSMS = 0;
  String verificationId, otp;
  FirebaseAuth _auth = FirebaseAuth.instance;

  doSendSMS() async {
    showEasyLoading(context, "$MSG052");
    await _auth.verifyPhoneNumber(
        phoneNumber: convertPhone(widget.phoneNumber),
        verificationCompleted: (phoneAuthCredential) async {
          print('Done');
        },
        verificationFailed: (error) async {
          print('error: ${error.message}');
          showEasyLoadingError(context, "Có lỗi xảy ra");
        },
        codeSent: (verificationId, forceResendingToken) async {
          setState(() {
            this.verificationId = verificationId;
          });
        },
        codeAutoRetrievalTimeout: (verificationId) async {
          print('codeAutoRetrievalTimeout: $verificationId');
        });
    EasyLoading.dismiss();
  }

  //Convert from String to country phone (+84)
  convertPhone(String phone) {
    String error = checkPhoneNumber(phone);
    try {
      if (error == null) {
        if (phone.substring(0, 3) == "+84") {
          return phone;
        } else {
          if (phone.substring(0, 1) == "0") {
            return "+84${phone.substring(1)}";
          }
        }
        return null;
      }
      return null;
    } catch (e) {
      return phone;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // if(widget.phoneNumber != null)doSendSMS();
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding:
        EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 50),
              Text("Mã sẽ được gửi đến ${this.widget.phoneNumber == null ? "***" : this.widget.phoneNumber}"),
              SizedBox(height: 5),
              buildTimer(),
              SizedBox(height: 50),
              OtpForm(),
              SizedBox(height: 15),
              // ignore: deprecated_member_use
              FlatButton(
                child: Text("Xác nhận"),
                onPressed: () {
                  getOTP();
                  PhoneAuthCredential phoneAuthCredential =
                  PhoneAuthProvider.credential(
                      verificationId: verificationId, smsCode: otp);
                  signInWithPhoneAuthCredential(phoneAuthCredential);
                },
              ),
              SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  if(widget.phoneNumber != null && timeSMS == 0){
                    doSendSMS();
                  }else showEasyLoadingError(context, "Xin đợi");
                },
                child: Text(
                  "Gửi lại mã OTP",
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  getOTP(){
    setState(() {
      otp = "$pin1$pin2$pin3$pin4$pin5$pin6";
    });
  }
  Row buildTimer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Mã sẽ được gửi trong ", style: GoogleFonts.roboto(color: Colors.black87),),
        TweenAnimationBuilder(
          tween: Tween(begin: 120, end: 0.0),
          duration: Duration(seconds: 120),
          builder: (context, value, child) {
              timeSMS = value.toInt();
                return Text(
              "${value.toInt()}s",
              style: GoogleFonts.roboto(color: Colors.orangeAccent),
            );
          },
        ),
      ],
    );
  }

  void signInWithPhoneAuthCredential(PhoneAuthCredential phoneAuth) async {
    try {
      showEasyLoading(context, "$MSG052");
      final authCredential = await _auth.signInWithCredential(phoneAuth);
      if (authCredential.user != null) {
        showEasyLoadingSuccess(context, 'OTP Successed !!!');
      }
    } on FirebaseAuthException catch (e) {
      showEasyLoadingError(context,  'Mã OTP hợp lệ');
    }
  }
}
