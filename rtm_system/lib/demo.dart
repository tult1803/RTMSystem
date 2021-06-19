// import 'dart:ui';
//
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:rtm_system/ultils/src/color_ultils.dart';
//
// class SimpleAnimatedList extends StatefulWidget {
//   const SimpleAnimatedList({Key key}) : super(key: key);
//
//   @override
//   _SimpleAnimatedListState createState() => _SimpleAnimatedListState();
// }
//
// class _SimpleAnimatedListState extends State<SimpleAnimatedList> {
//   bool isInvoice = true;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text(
//             "Đơn chờ xử lý",
//             style: GoogleFonts.roboto(color: Colors.black, fontSize: 20),
//           ),
//           centerTitle: true,
//           backgroundColor: Colors.white,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.only(
//               bottomLeft: Radius.elliptical(30, 20),
//               bottomRight: Radius.elliptical(30, 20),
//             ),
//           ),
//           bottom: PreferredSize(
//               child: Padding(
//                 padding: const EdgeInsets.only(bottom: 0),
//                 child: bottomProcess(context),
//               ),
//               preferredSize: Size.fromHeight(20.0)),
//         ),
//         body: new Container());
//   }
//
// Widget bottomProcess(BuildContext context) {
//   return Row(
//     mainAxisAlignment: MainAxisAlignment.center,
//     children: [
//       Flexible(
//           child: bottomProcessBar(title: "Hoá đơn", colorTitle: isInvoice ? welcome_color : Colors.black54)),
//       Padding(
//         padding: const EdgeInsets.only(bottom: 5.0),
//         child: Text("|", style: TextStyle(color: Colors.black54, fontSize: 20),),
//       ),
//       Flexible(
//           child: bottomProcessBar(title: "Ứng tiền", colorTitle: !isInvoice ? welcome_color : Colors.black54)),
//     ],
//   );
// }
//
// Widget bottomProcessBar({String title, Color colorTitle}){
//     return GestureDetector(
//         onTap: () {
//           setState(() {
//             title == "Hoá đơn" ? isInvoice = true: isInvoice = false;
//           });
//         },
//         child: Container(
//             margin: EdgeInsets.only(left: 10, right: 10),
//             height: 40,
//             child: Center(child: Text(title, style: GoogleFonts.roboto(color: colorTitle),))));
// }
// }
//
