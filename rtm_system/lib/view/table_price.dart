import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:rtm_system/helpers/component.dart';
import 'package:rtm_system/model/get/getAPI_product.dart';
import 'package:rtm_system/ultils/get_data.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable, camel_case_types
class showTablePrice extends StatefulWidget {
  String idProduct;

  showTablePrice({this.idProduct});

  @override
  _showTablePriceState createState() => _showTablePriceState();
}

// ignore: camel_case_types
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
        type: 3,
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
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });

    _pagingController.addStatusListener((status) {
      if (status == PagingStatus.subsequentPageError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
              'Có lỗi xảy ra',
            ),
            action: SnackBarAction(
              label: 'Thử lại',
              onPressed: () => _pagingController.retryLastFailedRequest(),
            ),
          ),
        );
      }
    });
  }

  @override
  void didUpdateWidget(covariant showTablePrice oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.idProduct != widget.idProduct) {
      _pagingController.refresh();
     if(dataListProduct != null) dataListProduct.clear();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _pagingController.dispose();
    if (dataListProduct != null) dataListProduct.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        colorScheme: ColorScheme(
          primary: welcome_color,
          onPrimary: Colors.white10,
          primaryVariant: Colors.white10,
          background: Colors.white10,
          onBackground: Colors.white10,
          secondary: Colors.white10,
          onSecondary: Colors.white10,
          secondaryVariant: Colors.white10,
          error: Colors.black,
          onError: Colors.white10,
          surface: Colors.white,
          onSurface: Colors.white10,
          brightness: Brightness.light,
        ),
      ),
      child: new Container(
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
          )),
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
          0: FractionColumnWidth(0.36),
          1: FractionColumnWidth(0.22),
          2: FractionColumnWidth(0.20),
          3: FractionColumnWidth(0.22)
        },
        children: [
          TableRow(decoration: BoxDecoration(color: welcome_color), children: [
            tableRow("Ngày", colorText: Colors.white, isAlignmentRight: false),
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
                      noItemsFoundIndicatorBuilder: (context) {
                    return Container(
                      child: Center(
                          child: Text(
                        "Chưa chọn sản phẩm",
                        style: TextStyle(color: Colors.black54),
                      )),
                    );
                  }, firstPageErrorIndicatorBuilder: (context) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        firstPageErrorIndicatorBuilder(context,
                            tittle: "Lỗi tải dữ liệu"),
                        GestureDetector(
                          onTap: () => _pagingController.refresh(),
                          child: Icon(
                            Icons.refresh,
                            color: welcome_color,
                            size: 35,
                          ),
                        ),
                      ],
                    );
                  }, itemBuilder: (context, item, index) {
                    return tableCell(
                        day: "${item["updateDateTime"]}",
                        newPrice: item["update_price"],
                        oldPrice: _pagingController.value.itemList.elementAt(
                            dataListProduct.length - 1 == index
                                ? index
                                : index + 1)["update_price"]);
                  })),
            ]));
  }

  Widget tittleTable() {
    return Container(
        margin: EdgeInsets.only(left: 20),
        child: Text("Bảng giá thay đổi 10 lần gần nhất:"));
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
      0: FractionColumnWidth(0.36),
      1: FractionColumnWidth(0.22),
      2: FractionColumnWidth(0.20),
      3: FractionColumnWidth(0.22)
    },
    children: [
      TableRow(children: [
        tableRow(
            "${getDateTime("$day", dateFormat: "dd-MM-yyyy")} (${getDateTime("$day", dateFormat: "HH")}h)"),
        // tableRow("${getDateTime("$day", dateFormat: "HH:mm")}"),
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
    height: 30,
    alignment:
        isAlignmentRight == null ? Alignment.centerRight : Alignment.center,
    margin: EdgeInsets.all(10),
    child: AutoSizeText(tittle, style: TextStyle(color: colorText)),
  );
}
