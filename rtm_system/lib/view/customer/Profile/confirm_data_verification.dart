// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:intl/intl.dart';
// import 'package:rtm_system/helpers/component.dart';
// import 'package:rtm_system/model/model_validate_account.dart';
// import 'package:rtm_system/ultils/get_api_data.dart';
// import 'package:rtm_system/ultils/get_data.dart';
// import 'package:rtm_system/ultils/src/color_ultils.dart';
//
// // ignore: must_be_immutable
// class ConfirmDataVerification extends StatefulWidget {
//   final DataValidateAccount account;
//   final String accountId;
//   bool check;
//
//   ConfirmDataVerification(
//       {this.account, this.accountId, this.check});
//
//   @override
//   _ConfirmDataVerificationState createState() =>
//       _ConfirmDataVerificationState();
// }
//
// class _ConfirmDataVerificationState extends State<ConfirmDataVerification> {
//   DataValidateAccount _account;
//
//   @override
//   void initState() {
//     super.initState();
//     _account = widget.account;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           leading: leadingAppbar(context),
//           elevation: 0,
//           centerTitle: true,
//           title: Text(
//             "Phiếu xác nhận",
//             style: TextStyle(fontSize: 20, color: Colors.white),
//           ),
//           backgroundColor: welcome_color,
//         ),
//         backgroundColor: welcome_color,
//         body: Card(
//           margin: EdgeInsets.only(top: 20, left: 10, right: 10),
//           child: SingleChildScrollView(
//             child: Container(
//               child: Column(
//                 children: [
//                   txtConfirm(context, "Họ và tên", _account.userData.name),
//                   txtConfirm(context, "Giới tính", "${_account.userData.sex}"),
//                   txtConfirm(context, "Ngày sinh", "${_account.userData.dob}"),
//                   _checkCMND(),
//                   _checkAddress(),
//                   btnConfirm(),
//                 ],
//               ),
//             ),
//           ),
//         ));
//   }
//
//   Widget btnConfirm() {
//     return Container(
//       margin: EdgeInsets.all(10),
//       width: 100,
//       height: 40,
//       decoration: BoxDecoration(
//         color: welcome_color,
//         borderRadius: BorderRadius.circular(5),
//       ),
//       child: TextButton(
//           onPressed: () {
//             DateTime tempDate =
//                 new DateFormat("dd/MM/yyyy").parse(_account.userData.dob);
//             doConfirmIdentifyCustomer(
//               context,
//               fullName: _account.userData.name,
//               cmnd: _account.userData.id,
//               address: _account.userData.address,
//               birthday: getDateTime("$tempDate", dateFormat: "yyyy-MM-dd"),
//               gender: _account.userData.sex == "NAM" ? 1 : 0,
//             );
//           },
//           child: Text(
//             "Xác nhận",
//             style: GoogleFonts.roboto(
//                 color: Colors.white, fontWeight: FontWeight.w400, fontSize: 17),
//           )),
//     );
//   }
//
//   Widget _checkCMND() {
//     if (this.widget.check) {
//       return txtConfirm(context, "CMND/CCCD", "${_account.userData.id}");
//     } else
//       return Container();
//   }
//
//   Widget _checkAddress() {
//     if (this.widget.check) {
//       return txtConfirm(context, "Địa chỉ", "${_account.userData.address}");
//     } else
//       return Container();
//   }
// }
