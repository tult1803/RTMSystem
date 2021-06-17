// import 'dart:ui';
//
// import 'package:flutter/material.dart';
// import 'package:rtm_system/presenter/Manager/invoice/showProcessInvoice.dart';
// import 'package:rtm_system/ultils/src/color_ultils.dart';
// import 'package:rtm_system/view/manager/debt/allDebt_manager.dart';
//
//
// class SimpleAnimatedList extends StatefulWidget {
//   const SimpleAnimatedList({Key key}) : super(key: key);
//
//   @override
//   _SimpleAnimatedListState createState() => _SimpleAnimatedListState();
// }
//
// class _SimpleAnimatedListState extends State<SimpleAnimatedList> {
//   int i;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.only(top: 50),
//       color: Colors.white,
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           children: [
//             Container(
//               height: 30,
//               child: SingleChildScrollView(
//                 scrollDirection: Axis.horizontal,
//                 child: Row(children: [
//                   txt("Đang xử lý", isChoose: i == 0? true : null),
//                   spaceTxt(),
//                   txt("Ký gửi", isChoose: i == 1? true : null),
//                   spaceTxt(),
//                   txt("Hoàn thành", isChoose: i == 2? true : null),
//                   spaceTxt(),
//                   txt("Từ chối", isChoose: i == 3? true : null),
//                 ]),
//               ),
//             ),
//
//             Expanded(
//               child: Container(
//                   child: PageView(
//                     scrollDirection: Axis.horizontal,
//                     onPageChanged: (value) {
//                       setState(() {
//                         i = value;
//                       });
//                     },
//                     children: [
//                       Scaffold(
//                         body: showProcessInvoiceManager(4),
//                       ),
//                       Scaffold(
//                         body: showProcessInvoiceManager(5),
//                       ),
//                       Scaffold(
//                         body: showProcessInvoiceManager(3),
//                       ),
//                       Scaffold(
//                         body: showProcessInvoiceManager(2),
//                       ),
//                       Scaffold(
//                         body: showProcessInvoiceManager(1),
//                       ),
//                     ],
//                   )),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
//
