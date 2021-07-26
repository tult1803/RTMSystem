import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rtm_system/helpers/dialog.dart';


class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> with ChangeNotifier {
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
                await _auth.verifyPhoneNumber(
                    phoneNumber: checkPhone(phone),
                    verificationCompleted: (phoneAuthCredential) async {
                      print('Verification Completed');
                      // signInWithPhoneAuthCredential(phoneAuthCredential);
                    },
                    verificationFailed: (error) async {
                      print('error: ${error.message}');
                      SnackBar(content: Text(error.message));
                    },
                    codeSent: (verificationId, forceResendingToken) async {
                      setState(() {
                        this.verificationId = verificationId;
                      });
                    },
                    codeAutoRetrievalTimeout: (verificationId) async {
                      print('codeAutoRetrievalTimeout: $verificationId');
                    });
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
      final authCredential = await _auth.signInWithCredential(phoneAuth);
      if (authCredential.user != null) {
        showEasyLoadingSuccess(context, 'OTP Successed !!!');
      } else
        showEasyLoadingError(context,  'OTP Failed !!!');
    } on FirebaseAuthException catch (e) {
      SnackBar(content: Text(e.message));
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
