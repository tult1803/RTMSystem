import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:rtm_system/model/get/getAPI_customer.dart';
import 'package:rtm_system/model/model_all_customer.dart';
import 'package:rtm_system/presenter/infinite_scroll_pagination/common/character_search_input_sliver.dart';
import 'package:rtm_system/helpers/common_widget.dart';
import 'package:rtm_system/helpers/component.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';
import 'package:rtm_system/view/manager/form_detail_page.dart';
import 'package:rtm_system/view/manager/profile/detail_customer.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: camel_case_types
class showAllCustomer extends StatefulWidget {
  const showAllCustomer({Key key}) : super(key: key);

  @override
  _showAllCustomerState createState() => _showAllCustomerState();
}

// ignore: camel_case_types
class _showAllCustomerState extends State<showAllCustomer> {
  int _pageSize = 1;
  final PagingController _pagingController = PagingController(firstPageKey: 10);
  String token;
  String _searchTerm;
  Customer customer;

  Future<void> _fetchPage(pageKey) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      token = prefs.get("access_token");
      GetCustomer getAPIAllCustomer = GetCustomer();
      customer = await getAPIAllCustomer.createCustomer(
        context,
        prefs.get("access_token"),
        0,
        // account_id sẽ truyền không để lấy hết customer vì customer đc quản lý chung
        prefs.get("accountId"),
        pageKey,
        _pageSize,
        searchTerm: _searchTerm,
      );
      final isLastPage = customer.customerList.length < pageKey;
      if (isLastPage) {
        _pagingController.appendLastPage(customer.customerList);
      } else {
        setState(() {
          _pageSize += 1;
        });
        final nextPageKey = pageKey;
        _pagingController.appendPage(customer.customerList, nextPageKey);
      }
    } catch (error) {
      print(error);
      _pagingController.error = error;
    }
  }

  @override
  void initState() {
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
      margin: EdgeInsets.only(top: 0, left: 5, right: 5, bottom: 25),
      height: size.height,
      width: size.width,
      child: new CustomScrollView(
        slivers: <Widget>[
          CharacterSearchInputSliver(
            hintText: "Tìm kiếm theo tên",
            onChanged: (searchTerm) {
              _updateSearchTerm(searchTerm);
              setState(() {
                _pageSize = 1;
              });
            },
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
                firstPageProgressIndicatorBuilder: (context) =>
                    firstPageProgressIndicatorBuilder(),
                noItemsFoundIndicatorBuilder: (context) =>
                    noItemsFoundIndicatorBuilder(),
                newPageProgressIndicatorBuilder: (context) =>
                    firstPageProgressIndicatorBuilder(),
                itemBuilder: (context, item, index) {
                  return boxForCustomer(
                      context: context,
                      status: item.statusId,
                      level: item.level,
                      phone: item.phone,
                      name: item.fullName,
                      advance: item.advance,
                      widget: FormForDetailPage(
                          tittle: "Chi tiết khách hàng",
                          bodyPage: DetailCustomer(
                            customerList: item,
                            token: token,
                          )));
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
