// // import 'package:flutter/material.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:flutter/services.dart';
// // import 'package:flutter_easyloading/flutter_easyloading.dart';
// // import 'package:rtm_system/helpers/dialog.dart';
// // import 'package:rtm_system/ultils/check_data.dart';
// // import 'package:rtm_system/ultils/src/message_list.dart';
// //
// //
// // class OTPSms extends StatefulWidget {
// //   @override
// //   _OTPSmsState createState() => _OTPSmsState();
// // }
// //
// // class _OTPSmsState extends State<OTPSms> with ChangeNotifier {
// //   String phone, verificationId, otp, phoneCheck;
// //
// //   FirebaseAuth _auth = FirebaseAuth.instance;
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         centerTitle: true,
// //         title: Text("OTP Security"),
// //       ),
// //       body: Column(
// //         children: [
// //           TextField(
// //             keyboardType: TextInputType.phone,
// //             onChanged: (value) {
// //               setState(() {
// //                 phone = value.trim();
// //               });
// //             },
// //             decoration: InputDecoration(
// //               hintText: "Phone Number",
// //             ),
// //           ),
// //           // ignore: deprecated_member_use
// //           FlatButton(
// //               onPressed: () async {
// //                 showEasyLoading(context, "$MSG052");
// //                 await _auth.verifyPhoneNumber(
// //                     phoneNumber: convertPhone(phone),
// //                     verificationCompleted: (phoneAuthCredential) async {
// //                       print('Verification Completed');
// //                       // signInWithPhoneAuthCredential(phoneAuthCredential);
// //                     },
// //                     verificationFailed: (error) async {
// //                       print('error: ${error.message}');
// //                     },
// //                     codeSent: (verificationId, forceResendingToken) async {
// //                       setState(() {
// //                         this.verificationId = verificationId;
// //                       });
// //                     },
// //                     codeAutoRetrievalTimeout: (verificationId) async {
// //                       print('codeAutoRetrievalTimeout: $verificationId');
// //                     });
// //                 EasyLoading.dismiss();
// //               },
// //               child: Text("Send")),
// //           Padding(
// //             padding: const EdgeInsets.all(20.0),
// //             child: TextField(
// //                keyboardType: TextInputType.number,
// //               maxLength: 1,
// //               maxLengthEnforcement: MaxLengthEnforcement.enforced,
// //               onChanged: (otp) {
// //                 setState(() {
// //                   this.otp = otp.trim();
// //                 });
// //               },
// //               decoration: InputDecoration(
// //                 hintText: "OTP Code",
// //                 counterText: "",
// //               ),
// //               inputFormatters: [
// //                 FilteringTextInputFormatter.allow(RegExp(r'[[0-9]')),
// //               ],
// //             ),
// //           ),
// //           // ignore: deprecated_member_use
// //           FlatButton(
// //               onPressed: () async {
// //                 PhoneAuthCredential phoneAuthCredential =
// //                 PhoneAuthProvider.credential(
// //                     verificationId: verificationId, smsCode: otp);
// //                 signInWithPhoneAuthCredential(phoneAuthCredential);
// //               },
// //               child: Text("Check OTP")),
// //           Text("${convertPhone(phone)}"),
// //         ],
// //       ),
// //     );
// //   }
// //
// //   void signInWithPhoneAuthCredential(PhoneAuthCredential phoneAuth) async {
// //     try {
// //       showEasyLoading(context, "$MSG052");
// //       final authCredential = await _auth.signInWithCredential(phoneAuth);
// //       if (authCredential.user != null) {
// //         showEasyLoadingSuccess(context, 'OTP Successed !!!');
// //       } else
// //         showEasyLoadingError(context,  'OTP Failed !!!');
// //     } on FirebaseAuthException catch (e) {
// //       showEasyLoadingError(context,  'OTP Failed !!!');
// //     }
// //   }
// //
// //   //Convert from String to country phone (+84)
// //   convertPhone(String phone) {
// //     String error = checkPhoneNumber(phone);
// //     try {
// //       if (error == null) {
// //         if (phone.substring(0, 3) == "+84") {
// //           return phone;
// //         } else {
// //           if (phone.substring(0, 1) == "0") {
// //             return "+84${phone.substring(1)}";
// //           }
// //         }
// //         return null;
// //       }
// //       return null;
// //     } catch (e) {
// //       return phone;
// //     }
// //   }
// // }
// import  'package:flutter/material.dart';
// import  'package:keyboard_actions/keyboard_actions.dart';
//
// import 'helpers/keyBoard_config.dart';
//
//
// class Content extends StatefulWidget {
//   const Content({
//     Key key,
//   }) : super(key: key);
//
//   @override
//   _ContentState createState() => _ContentState();
// }
//
// class _ContentState extends State<Content> {
//   final FocusNode _nodeText1 = FocusNode();
//   /// Creates the [KeyboardActionsConfig] to hook up the fields
//   /// and their focus nodes to our [FormKeyboardActions].
//
//
//   @override
//   Widget build(BuildContext context) {
//     return KeyboardActions(
//       config: keyBoardConfig(context, _nodeText1),
//       child: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(15.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: <Widget>[
//               TextField(
//                 keyboardType: TextInputType.number,
//                 onChanged: (value) {
//                   print('o');
//                 },
//                 onSubmitted: (value) {
//                   print('h');
//                 },
//                 focusNode: _nodeText1,
//                 decoration: InputDecoration(
//                   hintText: "Input Number",
//                 ),
//               ),
//
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }