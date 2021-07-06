import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:rtm_system/model/getAPI_product.dart';
import 'package:rtm_system/ultils/get_data.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class showTablePrice extends StatefulWidget {
  String idProduct;

  showTablePrice({this.idProduct});

  @override
  _showTablePriceState createState() => _showTablePriceState();
}

class _showTablePriceState extends State<showTablePrice> {
  final PagingController _pagingController = PagingController(firstPageKey: 10);
  List dataListProduct;

  Future<void> _fetchPage(pageKey) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      GetProduct getProduct = GetProduct();
      dataListProduct = await getProduct.getProduct(
        prefs.get("access_token"),
        widget.idProduct,
        type: 1,
        limit: 10,
      );
      final isLastPage = dataListProduct.length - 1 < pageKey;
      if (isLastPage) {
        _pagingController.appendLastPage(dataListProduct);
      } else {
        final nextPageKey = pageKey;
        _pagingController.appendPage(dataListProduct, nextPageKey);
      }
    } catch (error) {
      // print(error);
      _pagingController.error = error;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  @override
  void didUpdateWidget(covariant showTablePrice oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    if(oldWidget.idProduct != widget.idProduct){
      _pagingController.refresh();
      dataListProduct.clear();
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _pagingController.dispose();
    if(dataListProduct != null)dataListProduct.clear();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          tittleTable(),
          headerTable(),
          dataTable(),
        ],
      ),
    );
  }

  Widget headerTable() {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10, top: 10),
      width: MediaQuery.of(context).size.width,
      child: Table(
        // border: TableBorder.all(color: Colors.black54),
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        columnWidths: {
          0: FractionColumnWidth(0.25),
          1: FractionColumnWidth(0.15),
          2: FractionColumnWidth(0.2),
          3: FractionColumnWidth(0.2),
          3: FractionColumnWidth(0.2)
        },
        children: [
          TableRow(decoration: BoxDecoration(color: welcome_color), children: [
            tableRow("Ngày", colorText: Colors.white, isAlignmentRight: false),
            tableRow("Giờ", colorText: Colors.white),
            tableRow("Thay đổi", colorText: Colors.white),
            tableRow("%", colorText: Colors.white),
            tableRow("Giá", colorText: Colors.white),
          ])
        ],
      ),
    );
  }

  Widget dataTable() {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      width: MediaQuery.of(context).size.width,
      // height: 365,
      height: MediaQuery.of(context).size.height * 0.4,
      child: CustomScrollView(
        // physics: NeverScrollableScrollPhysics(),
        slivers: <Widget>[
          PagedSliverList(
              pagingController: _pagingController,
              builderDelegate: PagedChildBuilderDelegate(
                firstPageErrorIndicatorBuilder: (context) => Container(),
                noItemsFoundIndicatorBuilder: (context) {
                  return Container();
                },
                  itemBuilder: (context, item, index) {
                return tableCell(
                    day: "${item["updateDateTime"]}",
                    newPrice: item["update_price"],
                    oldPrice: _pagingController.value.itemList.elementAt(
                        dataListProduct.length - 1 == index
                            ? index
                            : index + 1)["update_price"]);
              })),
        ],
      ),
    );
  }

  Widget tittleTable() {
    return Container(
        margin: EdgeInsets.only(left: 20),
        child: Text("Bảng giá thay đổi 10 lần gần nhất:"));
  }
}

Widget tableCell({String day,int oldPrice, int newPrice}) {
  int changePrice = newPrice - oldPrice;
  var percentPrice =
      (double.tryParse("$changePrice") / double.tryParse("$oldPrice")) * 100;
  return Table(
    border: TableBorder(
      bottom: BorderSide(color: Colors.black45, width: 0.5),
    ),
    columnWidths: {
      0: FractionColumnWidth(0.25),
      1: FractionColumnWidth(0.15),
      2: FractionColumnWidth(0.2),
      3: FractionColumnWidth(0.2),
      4: FractionColumnWidth(0.2),
    },
    children: [
      TableRow(children: [
        tableRow("${getDateTime("$day", dateFormat: "dd-MM-yyyy")}"),
        tableRow("${getDateTime("$day", dateFormat: "HH:mm")}"),
        tableRow("${getFormatPrice("$changePrice")}",
            colorText: changePrice < 0
                ? Colors.redAccent
                : changePrice == 0
                    ? Colors.orangeAccent
                    : Colors.green),
        tableRow("${percentPrice.toStringAsFixed(1)}%",
            colorText: changePrice < 0
                ? Colors.redAccent
                : changePrice == 0
                    ? Colors.orangeAccent
                    : Colors.green),
        tableRow("${getFormatPrice("$newPrice")}",
            colorText: changePrice < 0
                ? Colors.redAccent
                : changePrice == 0
                    ? Colors.orangeAccent
                    : Colors.green),
      ]),
    ],
  );
}

Widget tableRow(String tittle, {Color colorText, bool isAlignmentRight}) {
  return Container(
    alignment:
        isAlignmentRight == null ? Alignment.centerRight : Alignment.center,
    margin: EdgeInsets.all(10),
    child: Text(
      tittle,
      style: TextStyle(color: colorText),
    ),
  );
}
