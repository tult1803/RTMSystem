// import 'package:dio/dio.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
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
//   @override
//   void deactivate() {
//     EasyLoading.dismiss();
//     super.deactivate();
//   }
//
//   void loadData() async {
//     try {
//       EasyLoading.show();
//       Response response = await Dio().get('https://github.com');
//       EasyLoading.dismiss();
//     } catch (e) {
//       EasyLoading.showError(e.toString());
//       print(e);
//     }
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Flutter EasyLoading'),
//       ),
//       body: Center(
//         child: FlatButton(
//           textColor: Colors.blue,
//           child: Text('loadData'),
//           onPressed: () async{
//             // loadData();
//             // await Future.delayed(Duration(seconds: 2));
//             EasyLoading.show(status: 'Đang xử lý...', maskType: EasyLoadingMaskType.black,);
//             await Future.delayed(Duration(seconds: 5));
//             EasyLoading.dismiss();
//           },
//         ),
//       ),
//     );
//   }
// }