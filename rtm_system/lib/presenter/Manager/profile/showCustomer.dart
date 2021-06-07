import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:rtm_system/model/getAPI_customer.dart';
import 'package:rtm_system/model/model_AllCustomer.dart';
import 'package:rtm_system/presenter/infinite_scroll_pagination/common/character_search_input_sliver.dart';
import 'package:rtm_system/ultils/commonWidget.dart';
import 'package:rtm_system/ultils/component.dart';
import 'package:rtm_system/ultils/getStatus.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';
import 'package:rtm_system/view/manager/formForDetail_page.dart';
import 'package:rtm_system/view/manager/profile/detail_customer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class showAllCustomer extends StatefulWidget {
  const showAllCustomer({Key key}) : super(key: key);

  @override
  _showAllCustomerState createState() => _showAllCustomerState();
}

class _showAllCustomerState extends State<showAllCustomer> {
  int _pageSize = 1;
  final PagingController _pagingController = PagingController(firstPageKey: 10);

  String _searchTerm;
  Customer customer;
  List customerList;

  Future<void> _fetchPage(pageKey) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      GetCustomer getAPIAllCustomer = GetCustomer();
      customer = await getAPIAllCustomer.createCustomer(
        prefs.get("access_token"),
        0, // account_id sẽ truyền không để lấy hết customer vì customer đc quản lý chung
        pageKey,
        _pageSize,
        searchTerm: _searchTerm,
      );
      customerList = customer.customerList;
      // print("${_pagingController}");
      final isLastPage = customerList.length < pageKey;
      if (isLastPage) {
        _pagingController.appendLastPage(customerList);
      } else {
        setState(() {
          _pageSize += 1;
        });
        final nextPageKey = pageKey;
        _pagingController.appendPage(customerList, nextPageKey);
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
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(top: 0, left: 5, right: 5),
      height: size.height,
      width: size.width,
      child: new CustomScrollView(
        slivers: <Widget>[
          CharacterSearchInputSliver(
            onChanged: (searchTerm) => _updateSearchTerm(searchTerm),
          ),
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
                  String vip;
                  if(item['vip']){
                    vip = "Vip";
                  }else{
                    vip = "Thường";
                  }
                  return card(
                      context,
                      item["fullname"],
                      "Trạng thái",
                      '${getStatus(status: item['status_id'])}',
                      "${vip}",
                      'Nợ: ${item['advance']}',
                      getColorStatus(status: item['status_id']),
                      FormForDetailPage(
                          tittle: "Chi tiết khách hàng",
                          bodyPage: DetailCustomer(map: item,)));
                }),
          ),
        ],
      ),
    );
  }

  void _updateSearchTerm(String searchTerm) {
    _searchTerm = searchTerm;
    _pagingController.refresh();
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
