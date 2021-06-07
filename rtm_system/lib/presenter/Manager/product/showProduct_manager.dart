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
  // List<DataProduct> dataListProduct = [];
  List<dynamic> dataList = [];
  final PagingController _pagingController = PagingController(firstPageKey: 10);
  // Future _getToken() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     token = prefs.getString("access_token");
  //   });
  // }
  //
  // Future _getProduct() async {
  //   List<dynamic> dataList = [];
  //   GetProduct getProduct = GetProduct();
  //   //Nếu dùng hàm này thì FutureBuilder sẽ chạy vòng lập vô hạn
  //   //Phải gọi _getToken trước khi gọi hàm _getProduct
  //   // await _getToken();
  //   // gọi APIProduct và lấy dữ liệu
  //
  //   //Khi click nhiều lần vào button "Sản phẩm" thì sẽ có hiện tượng dữ liệu bị ghi đè
  //   //Clear là để xoá dữ liệu cũ, ghi lại dữ liệu mới
  //   dataListProduct.clear();
  //
  //   //Nếu ko có If khi FutureBuilder gọi hàm _getProduct lần đầu thì Token chưa trả về nên sẽ bằng null
  //   //FutureBuilder sẽ gọi đến khi nào có giá trị trả về
  //   //Ở lần gọi thứ 2 thì token mới có giá trị
  //   if (token.isNotEmpty) {
  //     print(token);
  //     dataList = await getProduct.getProduct(token, 0);
  //     //Parse dữ liệu
  //     dataList.forEach((element) {
  //       Map<dynamic, dynamic> data = element;
  //       dataListProduct.add(DataProduct.fromJson(data));
  //     });
  //
  //     return dataListProduct;
  //   }
  // }

  Future<void> _fetchPage(pageKey) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      GetProduct getProduct = GetProduct();
      dataList = await getProduct.getProduct(prefs.getString("access_token"), 0);

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
      // child: new FutureBuilder(
      //   future: _getProduct(),
      //   builder: (BuildContext context, AsyncSnapshot snapshot) {
      //     if (snapshot.hasData) {
      //       return ListView.builder(
      //         itemCount: snapshot.data.length,
      //         itemBuilder: (context, index) {
      //           return card(
      //               context,
      //               snapshot.data[index].name,
      //               "Loại",
      //               "${snapshot.data[index].type}",
      //               snapshot.data[index].price,
      //               snapshot.data[index].date_time,
      //               Colors.black54,
      //               FormForDetailPage(
      //                 tittle: "Chi tiết sản phẩm",
      //                   bodyPage: DetailProduct(
      //                 id: snapshot.data[index].id,
      //                 name: snapshot.data[index].name,
      //                 description: snapshot.data[index].description,
      //                 type: snapshot.data[index].type,
      //                 date_time: snapshot.data[index].date_time,
      //                 price: snapshot.data[index].price,
      //               )));
      //         },
      //       );
      //     }
      //     return Container(
      //         height: size.height * 0.7,
      //         child: Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(welcome_color),)));
      //   },
      // ),

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
                firstPageProgressIndicatorBuilder: (context) => firstPageProgressIndicatorBuilder(),
                noItemsFoundIndicatorBuilder: (context) => noItemsFoundIndicatorBuilder(),
                newPageProgressIndicatorBuilder: (context) => firstPageProgressIndicatorBuilder(),
                itemBuilder: (context, item, index) {

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

  Widget noItemsFoundIndicatorBuilder(){
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
