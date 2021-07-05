import 'package:flutter/material.dart';
import 'package:rtm_system/ultils/helpers.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';

class showTablePrice extends StatefulWidget {
  String idProduct;

  showTablePrice({this.idProduct});

  @override
  _showTablePriceState createState() => _showTablePriceState();
}

class _showTablePriceState extends State<showTablePrice> {
  @override
  void didUpdateWidget(covariant showTablePrice oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    print('Id: ${widget.idProduct}');
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(top: 20),
      child: Column(
        children: [
          Table(
            // border: TableBorder.all(color: Colors.black54),
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            columnWidths: {
              0: FractionColumnWidth(0.25),
              1: FractionColumnWidth(0.2),
              2: FractionColumnWidth(0.2),
              3: FractionColumnWidth(0.2)
            },
            children: [
              TableRow(
                  decoration: BoxDecoration(color: welcome_color),
                  children: [
                    tableRow("Ngày", colorText: Colors.white, isAlignmentRight: false),
                    tableRow("Thay đổi", colorText: Colors.white),
                    tableRow("%", colorText: Colors.white),
                    tableRow("Giá", colorText: Colors.white),
                  ])
            ],
          ),
          tableCell(day: "04-07-2021", newPrice: 9000, oldPrice: 18000),
          tableCell(day: "03-07-2021", newPrice: 16000, oldPrice: 8000),
          tableCell(day: "03-07-2021", newPrice: 8000, oldPrice: 6000),
          tableCell(day: "03-07-2021", newPrice: 6000, oldPrice: 8000),
          tableCell(day: "03-07-2021", newPrice: 8000, oldPrice: 20000),
        ],
      ),
    );
  }
}

Widget tableCell({String day, int oldPrice, int newPrice}) {
  int changePrice = newPrice - oldPrice;
  var percentPrice =
      (double.tryParse("$changePrice") / double.tryParse("$oldPrice")) * 100;
  return Table(
    border: TableBorder(
      bottom: BorderSide(color: Colors.black45, width: 0.5),
    ),
    columnWidths: {
      0: FractionColumnWidth(0.25),
      1: FractionColumnWidth(0.2),
      2: FractionColumnWidth(0.2),
      3: FractionColumnWidth(0.2)
    },
    children: [
      TableRow(children: [
        tableRow("$day"),
        tableRow(
            "${getFormatPrice("$changePrice")}",
            colorText: changePrice < 0 ? Colors.redAccent : Colors.green),
        tableRow("${percentPrice.toStringAsFixed(1)}%",
            colorText: changePrice < 0 ? Colors.redAccent : Colors.green),
        tableRow("${getFormatPrice("$newPrice")}",
            colorText: changePrice < 0 ? Colors.redAccent : Colors.green),
      ]),
    ],
  );
}

Widget tableRow(String tittle, {Color colorText, bool isAlignmentRight}) {
  return Container(
    alignment:isAlignmentRight == null ? Alignment.centerRight : Alignment.center,
    margin: EdgeInsets.all(10),
    child: Text(
      tittle,
      style: TextStyle(color: colorText),
    ),
  );
}
