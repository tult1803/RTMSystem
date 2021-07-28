import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rtm_system/helpers/dialog.dart';
import 'package:rtm_system/ultils/check_data.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';
import 'package:rtm_system/ultils/src/message_list.dart';
import 'package:rtm_system/view/forgot_password/input_password.dart';

import '../../check_phone.dart';
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
        timeout: Duration(seconds: 120),
        verificationCompleted: (phoneAuthCredential) async {},
        verificationFailed: (error) async {
          print('error: ${error.message}');
          showEasyLoadingError(context, "$MSG030");
        },
        codeSent: (verificationId, forceResendingToken) async {
          print('verificationId: $verificationId');
          setState(() {
            this.verificationId = verificationId;
          });
        },
        codeAutoRetrievalTimeout: (verificationId) async {});
    EasyLoading.dismiss();
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.phoneNumber != null)doSendSMS();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 50),
              Text(
                  "Mã sẽ được gửi đến ${this.widget.phoneNumber == null ? "***" : this.widget.phoneNumber}"),
              SizedBox(height: 10),
              buildTimer(),
              SizedBox(height: 40),
              OtpForm(),
              SizedBox(height: 30),
              btnConfirm(),
              SizedBox(height: 10),
              btnReSendOTP(),
            ],
          ),
        ),
      ),
    );
  }

  Widget btnConfirm() {
    return Container(
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
            onPressed: () {
              getOTP();
              PhoneAuthCredential phoneAuthCredential =
                  PhoneAuthProvider.credential(
                      verificationId: verificationId, smsCode: otp);
              signInWithPhoneAuthCredential(phoneAuthCredential);
            },
            child: Text(
              "Xác nhận",
              style: GoogleFonts.roboto(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 17),
            )));
  }

  Widget btnReSendOTP() {
    return GestureDetector(
      onTap: () {
        if (widget.phoneNumber != null && timeSMS == 0) {
          doSendSMS();
        } else
          showEasyLoadingError(context, "Xin đợi");
      },
      child: Text(
        "Gửi lại mã OTP",
        style: TextStyle(decoration: TextDecoration.underline),
      ),
    );
  }

  getOTP() {
    setState(() {
      otp = "$pin1$pin2$pin3$pin4$pin5$pin6";
    });
  }

  Row buildTimer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Mã sẽ được gửi trong ",
          style: GoogleFonts.roboto(color: Colors.black87),
        ),
        TweenAnimationBuilder(
          tween: Tween(begin: 120, end: 0.0),
          duration: Duration(seconds: 120),
          builder: (context, value, child) {
            timeSMS = value.toInt();
            return Text(
              "${value.toInt()}s",
              style: GoogleFonts.roboto(color: Colors.blueAccent),
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
        EasyLoading.dismiss();
        authCredential.user.getIdToken().then((value) {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => InputNewPassword(firebaseToken: value,)));
        });
      }
    } on FirebaseAuthException catch (e) {
      showEasyLoadingError(context, '$MSG056');
    }
  }
}
