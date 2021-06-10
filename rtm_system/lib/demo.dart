// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
//
// class SimpleAnimatedList extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SliceAnimatedList(),
//     );
//   }
// }
//
// class SliceAnimatedList extends StatefulWidget {
//   @override
//   _SliceAnimatedListState createState() => _SliceAnimatedListState();
// }
//
// class _SliceAnimatedListState extends State<SliceAnimatedList> {
//   final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
//   List<double> _items = [];
//   int counter = 0;
//   var txtController = TextEditingController();
//
//   Widget slideIt(BuildContext context, int index) {
//     double item = _items[index];
//     return GestureDetector(
//       onTap: () {
//         try {
//           if (_items.length <= 0) return;
//           listKey.currentState.removeItem(
//               index, (_, animation) => slideIt(context, 0),
//               duration: const Duration(milliseconds: 000));
//           setState(() {
//             _items.removeAt(index);
//           });
//         } catch (_) {}
//       },
//       child: Container(
//         margin: EdgeInsets.only(top: 5, bottom: 5, left: 2),
//         width: 40,
//         decoration: BoxDecoration(
//           color: Colors.black38,
//           borderRadius: BorderRadius.circular(5),
//         ),
//         child: Center(
//           child:
//               Text('$item', style: TextStyle(fontSize: 14, color: Colors.white)),
//         ),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisSize: MainAxisSize.max,
//       children: <Widget>[
//         SizedBox(
//           height: 50,
//         ),
//         Container(
//           child: TextFormField(
//             controller: txtController,
//             onFieldSubmitted: (value) {
//               if (value != null && value != "") {
//                 setState(() {
//                   listKey.currentState.insertItem(0,
//                       duration: const Duration(milliseconds: 00));
//                   _items = []
//                     ..add(double.parse(value))
//                     ..addAll(_items);
//                 });
//               }
//               txtController.clear();
//             },
//             keyboardType: TextInputType.number,
//             inputFormatters: [
//               FilteringTextInputFormatter.deny(RegExp(r'[-,/\\ ]'))
//             ],
//             decoration: InputDecoration(
//               hintText: "ok",
//             ),
//           ),
//         ),
//         Container(
//           height: 30,
//           child: AnimatedList(
//             shrinkWrap: true,
//             scrollDirection: Axis.horizontal,
//             key: listKey,
//             initialItemCount: _items.length,
//             itemBuilder: (context, index, animation) {
//               return slideIt(context, index);
//             },
//           ),
//         ),
//         Container(
//           decoration: BoxDecoration(color: Colors.greenAccent),
//           child: Row(
//             mainAxisSize: MainAxisSize.max,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               FlatButton(
//                 onPressed: () {
//                   try {
//                     if (_items.length <= 0) return;
//                     listKey.currentState.removeItem(
//                         0, (_, animation) => slideIt(context, 0),
//                         duration: const Duration(milliseconds: 000));
//                     setState(() {
//                       _items.removeAt(0);
//                     });
//                   } catch (_) {}
//                 },
//                 child: Text(
//                   "Remove first item",
//                   style: TextStyle(color: Colors.black, fontSize: 20),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rtm_system/ultils/getStatus.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';

class SimpleAnimatedList extends StatefulWidget {
  const SimpleAnimatedList({Key key}) : super(key: key);

  @override
  _SimpleAnimatedListState createState() => _SimpleAnimatedListState();
}

List list = [];

class _SimpleAnimatedListState extends State<SimpleAnimatedList> {
  @override
  Widget build(BuildContext context) {
    return Material(
        child: Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            boxForInvoice(status: 3),
            boxForInvoice(status: 4),
            boxForInvoice(status: 5),
          ],
        ),
      ),
    ));
  }
}

Widget boxForInvoice(
    {int id,
    String name,
    String product,
    String total,
    DateTime dateTime,
    int status}){
  return Container(
    margin: EdgeInsets.only(top: 15, left: 10, right: 10),
    height: 100,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(5),
      boxShadow: [
        BoxShadow(
          color: Colors.black54,
          blurRadius: 4,
          offset: Offset(1, 2), // Shadow position
        ),
      ],
    ),
    child: Column(
      children: [
        Row(
          children: [
            Container(
              margin: EdgeInsets.all(5),
              height: 30,
              decoration: BoxDecoration(
                  color: colorHexa("#f9ee75"),
                  borderRadius: BorderRadius.circular(5)),
              child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10),
                    child: Text("Mã #1"),
                  )),
            ),
            Flexible(
              child: Container(
                alignment: Alignment.centerRight,
                color: Colors.white,
                height: 30,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10),
                  child: Text("19/06/2021 13:21", style: GoogleFonts.roboto(fontWeight: FontWeight.w600),),
                ),
              ),
            ),
          ],
        ),
        Container(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10),
            child: Text("Lê Thanh Tú", style: GoogleFonts.roboto(fontWeight: FontWeight.w700),),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 2),
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding:
                      const EdgeInsets.only(left: 10.0, right: 10),
                      child: Text("Sản phẩm: Mủ chén", style: GoogleFonts.roboto(fontWeight: FontWeight.w400),),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 2),
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding:
                      const EdgeInsets.only(left: 10.0, right: 10),
                      child: Text("Tổng cộng: 100.000.000đ", style:  GoogleFonts.roboto(fontWeight: FontWeight.w400),),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 10),
              height: 30,
              width: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: getColorStatus(status: status),
              ),
              child: Center(
                  child: Padding(
                    padding:
                    const EdgeInsets.only(left: 10.0, right: 10),
                    child: Text("${getStatus(status: status)}", style: TextStyle(color: Colors.white),),
                  ),
              ),
            )
          ],
        )
      ],
    ),
  );
}