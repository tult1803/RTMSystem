// // import 'package:flutter/cupertino.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter/services.dart';
// //
// // class SimpleAnimatedList extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: SliceAnimatedList(),
// //     );
// //   }
// // }
// //
// // class SliceAnimatedList extends StatefulWidget {
// //   @override
// //   _SliceAnimatedListState createState() => _SliceAnimatedListState();
// // }
// //
// // class _SliceAnimatedListState extends State<SliceAnimatedList> {
// //   final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
// //   List<double> _items = [];
// //   int counter = 0;
// //   var txtController = TextEditingController();
// //
// //   Widget slideIt(BuildContext context, int index) {
// //     double item = _items[index];
// //     return GestureDetector(
// //       onTap: () {
// //         try {
// //           if (_items.length <= 0) return;
// //           listKey.currentState.removeItem(
// //               index, (_, animation) => slideIt(context, 0),
// //               duration: const Duration(milliseconds: 000));
// //           setState(() {
// //             _items.removeAt(index);
// //           });
// //         } catch (_) {}
// //       },
// //       child: Container(
// //         margin: EdgeInsets.only(top: 5, bottom: 5, left: 2),
// //         width: 40,
// //         decoration: BoxDecoration(
// //           color: Colors.black38,
// //           borderRadius: BorderRadius.circular(5),
// //         ),
// //         child: Center(
// //           child:
// //               Text('$item', style: TextStyle(fontSize: 14, color: Colors.white)),
// //         ),
// //       ),
// //     );
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Column(
// //       mainAxisSize: MainAxisSize.max,
// //       children: <Widget>[
// //         SizedBox(
// //           height: 50,
// //         ),
// //         Container(
// //           child: TextFormField(
// //             controller: txtController,
// //             onFieldSubmitted: (value) {
// //               if (value != null && value != "") {
// //                 setState(() {
// //                   listKey.currentState.insertItem(0,
// //                       duration: const Duration(milliseconds: 00));
// //                   _items = []
// //                     ..add(double.parse(value))
// //                     ..addAll(_items);
// //                 });
// //               }
// //               txtController.clear();
// //             },
// //             keyboardType: TextInputType.number,
// //             inputFormatters: [
// //               FilteringTextInputFormatter.deny(RegExp(r'[-,/\\ ]'))
// //             ],
// //             decoration: InputDecoration(
// //               hintText: "ok",
// //             ),
// //           ),
// //         ),
// //         Container(
// //           height: 30,
// //           child: AnimatedList(
// //             shrinkWrap: true,
// //             scrollDirection: Axis.horizontal,
// //             key: listKey,
// //             initialItemCount: _items.length,
// //             itemBuilder: (context, index, animation) {
// //               return slideIt(context, index);
// //             },
// //           ),
// //         ),
// //         Container(
// //           decoration: BoxDecoration(color: Colors.greenAccent),
// //           child: Row(
// //             mainAxisSize: MainAxisSize.max,
// //             crossAxisAlignment: CrossAxisAlignment.center,
// //             mainAxisAlignment: MainAxisAlignment.center,
// //             children: <Widget>[
// //               FlatButton(
// //                 onPressed: () {
// //                   try {
// //                     if (_items.length <= 0) return;
// //                     listKey.currentState.removeItem(
// //                         0, (_, animation) => slideIt(context, 0),
// //                         duration: const Duration(milliseconds: 000));
// //                     setState(() {
// //                       _items.removeAt(0);
// //                     });
// //                   } catch (_) {}
// //                 },
// //                 child: Text(
// //                   "Remove first item",
// //                   style: TextStyle(color: Colors.black, fontSize: 20),
// //                 ),
// //               )
// //             ],
// //           ),
// //         ),
// //       ],
// //     );
// //   }
// // }
//
// import 'dart:ui';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:rtm_system/ultils/component.dart';
// import 'package:rtm_system/ultils/helpers.dart';
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
//   @override
//   Widget build(BuildContext context) {
//     return Material(
//         child: Container(
//       width: MediaQuery.of(context).size.width,
//       height: MediaQuery.of(context).size.height,
//       child: Center(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             boxForCustomer(
//                 status: 1, advance: 1, name: "aaaa", phone: "0946", vip: true),
//           ],
//         ),
//       ),
//     ));
//   }
// }
//
// Widget boxForCustomer(
//     {String name, int advance, String phone, bool vip, int status}) {
//   return Container(
//     margin: EdgeInsets.only(top: 15, left: 10, right: 10),
//     decoration: BoxDecoration(
//       color: Colors.white,
//       borderRadius: BorderRadius.circular(5),
//       boxShadow: [
//         BoxShadow(
//           color: Colors.black54,
//           blurRadius: 4,
//           offset: Offset(1, 2), // Shadow position
//         ),
//       ],
//     ),
//     child: Column(
//       children: [
//         Row(
//           children: [
//             Row(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: CircleAvatar(
//                     backgroundColor: colorHexa("AEDFD4"),
//                     child: Icon(
//                       Icons.person_outline_sharp,
//                       color: Colors.black54,
//                     ),
//                   ),
//                 ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Container(
//                       child: Text(
//                         name,
//                         style: GoogleFonts.roboto(fontWeight: FontWeight.w700),
//                       ),
//                     ),
//                     Container(
//                       child: Text(
//                         phone,
//                         style: GoogleFonts.roboto(
//                             fontWeight: FontWeight.w400, color: Colors.black54),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             Expanded(child: SizedBox()),
//             miniContainer(
//               borderRadius: 5,
//               height: 30,
//               width: 100,
//               colorContainer: Colors.white,
//               colorText: Colors.black,
//               fontWeightText: FontWeight.w500,
//               marginRight: 10,
//               tittle: "${getVip(vip)}",
//             ),
//           ],
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             miniContainer(
//               borderRadius: 5,
//               height: 30,
//               width: 130,
//               colorContainer: getColorStatus(status: status),
//               colorText: Colors.white,
//               fontWeightText: FontWeight.w500,
//               marginLeft: 10,
//               tittle: "${getStatus(status: status)}",
//             ),
//             Expanded(child: SizedBox()),
//             miniContainer(
//               borderRadius: 5,
//               height: 30,
//               width: 100,
//               colorContainer: colorHexa("#FF8F84"),
//               colorText: Colors.white,
//               fontWeightText: FontWeight.w500,
//               marginRight: 10,
//               tittle: "Nợ: $advance",
//             ),
//           ],
//         ),
//         SizedBox(
//           height: 10,
//         ),
//       ],
//     ),
//   );
// }
