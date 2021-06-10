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
import 'package:flutter/services.dart';

class SimpleAnimatedList extends StatefulWidget {
  const SimpleAnimatedList({Key key}) : super(key: key);

  @override
  _SimpleAnimatedListState createState() => _SimpleAnimatedListState();
}

List list = [];
class _SimpleAnimatedListState extends State<SimpleAnimatedList> {
  var txtController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            SizedBox(
              height: 50,
            ),
            Container(
              width: 200,
              height: 50,
              child: TextFormField(
                controller: txtController,
                onFieldSubmitted: (value) {
                  if (value != null && value != "") {
                    setState(() {
                      list.add(value);
                    });
                  }
                  txtController.clear();
                },
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.deny(RegExp(r'[-,/\\ ]'))
                ],
                decoration: InputDecoration(
                  hintText: "ok",
                ),
              ),
            ),
            Wrap(
              spacing: 5,
              children: list.map((value) => containerWeight(value: value)).toList().cast<Widget>(),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget containerWeight({String value}){
    return GestureDetector(
      onTap: () {
        setState(() {
          list.removeAt(list.indexOf(value));
        });
      },
      child: Container(
        margin: EdgeInsets.only(top: 10),
        width: 50,
        height: 30,
        decoration: BoxDecoration(
          color: Colors.black38,
          borderRadius: BorderRadius.circular(5),
        ),
            child: Center(child: Text("$value", style: TextStyle(color: Colors.white),))
      ),
    );
  }
}
