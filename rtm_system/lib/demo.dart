// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:rtm_system/ultils/alertDialog.dart';
// import 'package:rtm_system/ultils/component.dart';
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
//     return Container(
//       color: Colors.yellowAccent,
//       child: Center(
//         child: TextButton(
//             onPressed: () {
//               showCustomDialog(context, isSuccess: true, content: "Cập nhật thông tin thành công");
//               // showCustomDialog(context, isSuccess: false, content: "Cập nhật thông tin thất bại");
//               // showAlertDialog(context, "tittle", null);
//             },
//             child: Text("Dialog")),
//       ),
//     );
//   }
// }
//
// Future<Dialog> showCustomDialog(BuildContext context, {bool isSuccess, String content}) {
//   return showDialog(
//       context: context,
//       builder: (context) {
//         var size = MediaQuery
//             .of(context)
//             .size;
//         return Dialog(
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(5),
//             ),
//             elevation: 0,
//             backgroundColor: Colors.white,
//             child: Container(
//               height: 280,
//               width: size.width * 0.8,
//               decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(10)
//               ),
//               child: Column(
//                 children: [
//                   Container(
//                       margin: EdgeInsets.only(top: 10, bottom: 10),
//                       child: Image.asset(isSuccess
//                           ? "images/iconSmile.png"
//                           : "images/iconSad.png", height: 100, width: 100,)),
//                   Expanded(child: Container(
//                     width: size.width,
//                     color: isSuccess ? welcome_color : Colors.redAccent,
//                     child: Column(
//                       children: [
//                         SizedBox(height: 10,),
//                         Text(isSuccess ? "Thành công" : "Thất bại",
//                           style: GoogleFonts.roboto(fontSize: 25, color: Colors
//                               .white, fontWeight: FontWeight.w600),),
//                         SizedBox(height: 10,),
//                         Text(content,
//                           style: GoogleFonts.roboto(fontSize: 20, color: Colors
//                               .white, fontWeight: FontWeight.w400),),
//                         miniContainer(
//                           context: context,
//                           marginTop: 20,
//                           height: 40,
//                           width: 150,
//                           tittle: "Xác nhận",
//                           colorContainer: Colors.white,
//                           borderRadius: 10,
//                           fontSize: 18,
//                           doNavigate: false
//                         ),
//                       ],
//                     ),
//                   )),
//                 ],
//               ),
//             )
//         );
//       });
// }
