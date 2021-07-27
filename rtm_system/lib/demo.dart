import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:rtm_system/helpers/dialog.dart';
import 'package:rtm_system/ultils/src/message_list.dart';


class OTPLogin extends StatefulWidget {
  @override
  _OTPLoginState createState() => _OTPLoginState();
}

class _OTPLoginState extends State<OTPLogin> with ChangeNotifier {
  String phone, verificationId, otp, phoneCheck;

  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("OTP Security"),
      ),
      body: Column(
        children: [
          TextField(
            keyboardType: TextInputType.phone,
            onChanged: (value) {
              setState(() {
                phone = value.trim();
              });
            },
            decoration: InputDecoration(
              hintText: "Phone Number",
            ),
          ),
          // ignore: deprecated_member_use
          FlatButton(
              onPressed: () async {
                showEasyLoading(context, "$MSG052");
                await _auth.verifyPhoneNumber(
                    phoneNumber: checkPhone(phone),
                    verificationCompleted: (phoneAuthCredential) async {
                      print('Verification Completed');
                      // signInWithPhoneAuthCredential(phoneAuthCredential);
                    },
                    verificationFailed: (error) async {
                      print('error: ${error.message}');
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
              },
              child: Text("Send")),
          TextField(
            keyboardType: TextInputType.number,
            onChanged: (otp) {
              setState(() {
                this.otp = otp.trim();
              });
            },
            decoration: InputDecoration(
              hintText: "OTP Code",
            ),
          ),
          // ignore: deprecated_member_use
          FlatButton(
              onPressed: () async {
                PhoneAuthCredential phoneAuthCredential =
                PhoneAuthProvider.credential(
                    verificationId: verificationId, smsCode: otp);
                signInWithPhoneAuthCredential(phoneAuthCredential);
              },
              child: Text("Check OTP")),
          Text("${checkPhone(phone)}"),
        ],
      ),
    );
  }

  void signInWithPhoneAuthCredential(PhoneAuthCredential phoneAuth) async {
    try {
      showEasyLoading(context, "$MSG052");
      final authCredential = await _auth.signInWithCredential(phoneAuth);
      if (authCredential.user != null) {
        showEasyLoadingSuccess(context, 'OTP Successed !!!');
      } else
        showEasyLoadingError(context,  'OTP Failed !!!');
    } on FirebaseAuthException catch (e) {
      showEasyLoadingError(context,  'OTP Failed !!!');
    }
  }

  checkPhone(String phone) {
    try {
      if (phone.substring(0, 3) == "+84") {
        return phone;
      } else {
        if (phone.substring(0, 1) == "0") {
          return "+84${phone.substring(1)}";
        }
      }
      return phone;
    } catch (e) {
      return phone;
    }
  }
}
