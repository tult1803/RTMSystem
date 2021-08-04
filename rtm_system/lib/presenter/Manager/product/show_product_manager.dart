import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:rtm_system/model/get/getAPI_product.dart';
import 'package:rtm_system/helpers/common_widget.dart';
import 'package:rtm_system/helpers/component.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';
import 'package:rtm_system/view/manager/form_detail_page.dart';
import 'package:rtm_system/view/manager/home_manager_page.dart';
import 'package:rtm_system/view/manager/product/detail_product.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: camel_case_types
class showAllProduct extends StatefulWidget {
  const showAllProduct({Key key}) : super(key: key);

  @override
  _showAllProductState createState() => _showAllProductState();
}

List<String> itemNameUpdatePrice = [];
List<String> itemPriceUpdatePrice = [];
List<String> itemIdUpdatePrice = [];
List<String> itemDateUpdatePrice = [];

// ignore: camel_case_types
class _showAllProductState extends State<showAllProduct> {
  // String token;
  List<dynamic> dataList = [];
  final PagingController _pagingController = PagingController(firstPageKey: 50);

  Future<void> _fetchPage(pageKey) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      GetProduct getProduct = GetProduct();
      dataList = await getProduct
          .getProduct(context,prefs.getString("access_token"), "", type: 0, limit: 0);
      if(itemNameUpdatePrice.length < dataList.length) dataList.forEach((element) {
        itemNameUpdatePrice.add("${element["name"]}");
        itemPriceUpdatePrice.add("${element["update_price"]}");
        itemDateUpdatePrice.add("${element["updateDateTime"]}");
        itemIdUpdatePrice.add(element["id"]);
      });
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
    itemIdUpdatePrice.clear();
    itemPriceUpdatePrice.clear();
    itemNameUpdatePrice.clear();
    itemDateUpdatePrice.clear();
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
                firstPageErrorIndicatorBuilder: (context) =>
                    noItemsFoundIndicatorBuilder("Không có dữ liệu"),
                firstPageProgressIndicatorBuilder: (context) =>
                    firstPageProgressIndicatorBuilder(),
                noItemsFoundIndicatorBuilder: (context) =>
                    noItemsFoundIndicatorBuilder("Không có dữ liệu"),
                newPageProgressIndicatorBuilder: (context) =>
                    firstPageProgressIndicatorBuilder(),
                itemBuilder: (context, item, index) {
                  return boxForProduct(
                      context: context,
                      id: item["id"],
                      productName: item["name"],
                      date: item["updateDateTime"],
                      typeOfProduct: "${item["type"]}",
                      price: "${item["update_price"]}",
                      widget: FormForDetailPage(
                          navigatorWidget: HomeAdminPage(index: 0,),
                          tittle: "Chi tiết sản phẩm",
                          bodyPage: DetailProduct(
                            itemDetailProduct: item,
                          )));
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

  Widget noItemsFoundIndicatorBuilder(String tittle) {
    return Column(
      children: [
        firstPageErrorIndicatorBuilder(context, tittle: tittle),
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
