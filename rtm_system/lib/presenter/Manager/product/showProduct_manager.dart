import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:rtm_system/model/getAPI_product.dart';
import 'package:rtm_system/model/model_product.dart';
import 'package:rtm_system/ultils/commonWidget.dart';
import 'package:rtm_system/ultils/component.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';
import 'package:rtm_system/view/manager/formForDetail_page.dart';
import 'package:rtm_system/view/manager/product/detailProduct.dart';
import 'package:shared_preferences/shared_preferences.dart';

class showAllProduct extends StatefulWidget {
  const showAllProduct({Key key}) : super(key: key);

  @override
  _showAllProductState createState() => _showAllProductState();
}

class _showAllProductState extends State<showAllProduct> {
  // String token;
  List<DataProduct> dataListProduct = [];
  List<dynamic> dataList = [];
  final PagingController _pagingController = PagingController(firstPageKey: 50);

  Future<void> _fetchPage(pageKey) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      GetProduct getProduct = GetProduct();
      dataList =
          await getProduct.getProduct(prefs.getString("access_token"), 0);
      // print("${_pagingController}");
      final isLastPage = dataList.length < pageKey;
      if (isLastPage) {
        _pagingController.appendLastPage(dataList);
      } else {
        final nextPageKey = pageKey;
        _pagingController.appendPage(dataList, nextPageKey);
      }
    } catch (error) {
      print(error);
      _pagingController.error = error;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
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
    super.initState();
    // _getToken();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(top: 10, left: 20, right: 20),
      height: size.height,
      width: size.width,
      child: new CustomScrollView(
        slivers: <Widget>[
          PagedSliverList(
            pagingController: _pagingController,
            builderDelegate: PagedChildBuilderDelegate(
                firstPageErrorIndicatorBuilder: (context) {
                  return Column(
                    children: [
                      firstPageErrorIndicatorBuilder(context,
                          tittle: "Không có dữ liệu"),
                      GestureDetector(
                        onTap: () => _pagingController.refresh(),
                        child: Text(
                          "Nhấn để tải lại",
                          style: TextStyle(color: welcome_color, fontSize: 18),
                        ),
                      ),
                    ],
                  );
                },
                firstPageProgressIndicatorBuilder: (context) =>
                    firstPageProgressIndicatorBuilder(),
                noItemsFoundIndicatorBuilder: (context) =>
                    noItemsFoundIndicatorBuilder(),
                newPageProgressIndicatorBuilder: (context) =>
                    firstPageProgressIndicatorBuilder(),
                itemBuilder: (context, item, index) {
                  return card(
                      context,
                      item["name"],
                      "Loại",
                      "${item["type"]}",
                      "${item["update_price"]}",
                      item["updateDateTime"],
                      Colors.black54,
                      FormForDetailPage(
                          tittle: "Chi tiết sản phẩm",
                          bodyPage: DetailProduct(
                            itemDetailProduct: item,
                            // id: item["id"],
                            // name: item["name"],
                            // description: item["description"],
                            // type: "${item["type"]}",
                            // date_time: item["updateDateTime"],
                            // price: "${item["update_price"]}",
                          ))
                  );
                }),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  Widget noItemsFoundIndicatorBuilder() {
    return Column(
      children: [
        firstPageErrorIndicatorBuilder(context,
            tittle: "Không có dữ liệu khách hàng"),
        GestureDetector(
          onTap: () => _pagingController.refresh(),
          child: Text(
            "Nhấn để tải lại",
            style: TextStyle(color: welcome_color, fontSize: 18),
          ),
        ),
      ],
    );
  }
}
