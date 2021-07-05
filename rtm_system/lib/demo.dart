// import 'package:flutter/cupertino.dart';
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
//   List<DataRow> _rowList = [];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "Demo Table",
//           style: GoogleFonts.roboto(color: Colors.black, fontSize: 20),
//         ),
//         centerTitle: true,
//       ),
//       body: new Container(
//           width: MediaQuery.of(context).size.width,
//           margin: EdgeInsets.all(30),
//           child: SingleChildScrollView(
//                 child: DataTable(
//                     decoration: BoxDecoration(
//                         border: Border.all(color: Colors.black54, width: 0.5)),
//                     showCheckboxColumn: false,
//                     columnSpacing:25,
//                     dataRowHeight: 40,
//                     headingRowHeight: 40,
//                     headingTextStyle: TextStyle(color: Colors.white),
//                     headingRowColor: MaterialStateColor.resolveWith(
//                         (states) => welcome_color),
//                     columns: [
//                       DataColumn(label: Text('Ngày')),
//                       DataColumn(label: Text('Thay đổi (đ)')),
//                       DataColumn(label: Text('%')),
//                       DataColumn(label: Text('Giá (đ)')),
//                     ],
//                     rows: _rowList),
//               )),
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: _addRow,
//         label: Text('Add Row'),
//         backgroundColor: Colors.green,
//       ),
//     );
//   }
//
//   void _addRow({String day, String oldPrice, String newPrice}) {
//     // Built in Flutter Method.
//     setState(() {
//       // This call to setState tells the Flutter framework that something has
//       // changed in this State, which causes it to rerun the build method below.
//       _rowList.add(DataRow(cells: <DataCell>[
//         DataCell(textDataCell("04-07-2021")),
//         DataCell(textDataCell("100.000", color: Colors.green)),
//         DataCell(textDataCell("15%", color: Colors.green)),
//         DataCell(textDataCell("260.000", color: Colors.green)),
//       ]));
//     });
//   }
//
//   Widget textDataCell(String tittle, {Color color}) {
//     return Text(
//       tittle,
//       style: GoogleFonts.roboto(color: color),
//     );
//   }
// }
