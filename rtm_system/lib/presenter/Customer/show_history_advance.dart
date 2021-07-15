import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:rtm_system/model/get/getAPI_AdvanceHistory.dart';
import 'package:rtm_system/model/get/getAPI_customer_phone.dart';
import 'package:rtm_system/model/model_advance_history.dart';
import 'package:rtm_system/helpers/common_widget.dart';
import 'package:rtm_system/helpers/component.dart';
import 'package:rtm_system/model/model_profile_customer.dart';
import 'package:rtm_system/ultils/get_data.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';
import 'package:rtm_system/ultils/src/message_list.dart';
import 'package:rtm_system/view/customer/advance/detail_advance_return.dart';
import 'package:rtm_system/view/detail_advance_request.dart';
import 'package:rtm_system/view/manager/form_detail_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class showHistoryAdvancePage extends StatefulWidget {
  @override
  _showHistoryAdvancePageState createState() => _showHistoryAdvancePageState();
}

class _showHistoryAdvancePageState extends State<showHistoryAdvancePage> {
  int _pageSize = 1;
  final PagingController<int, AdvanceHistory> _pagingController =
      PagingController(firstPageKey: 10);
  List<AdvanceHistory> advanceHistory = [];
  int totalAdvance = 0;
  GetAPIProfileCustomer getAPIProfileCustomer = GetAPIProfileCustomer();
  InfomationCustomer infomationCustomer = InfomationCustomer();

  Future<void> _fetchPage(pageKey) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      GetAdvanceHistory getAdvanceHistory = GetAdvanceHistory();
      List<dynamic> listAdvance = [];
      listAdvance = await getAdvanceHistory.getAdvanceHistory(
        prefs.get("access_token"),
        prefs.get("accountId"),
        pageKey,
        _pageSize,
      );
      advanceHistory.clear();
      listAdvance.forEach((element) {
        Map<dynamic, dynamic> data = element;
        advanceHistory.add(AdvanceHistory.fromJson(data));
      });
      final isLastPage = advanceHistory.length < pageKey;
      if (isLastPage) {
        _pagingController.appendLastPage(advanceHistory);
      } else {
        setState(() {
          _pageSize += 1;
        });
        final nextPageKey = pageKey;
        _pagingController.appendPage(advanceHistory, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

//get total advance
  Future getAPIProfile() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString('access_token');
    String phone = sharedPreferences.getString('phone');
    // Đỗ dữ liệu lấy từ api
    infomationCustomer =
        await getAPIProfileCustomer.getProfileCustomer(token, phone);
    if (infomationCustomer != null) {
      setState(() {
        totalAdvance = infomationCustomer.advance;
      });
    }
    return infomationCustomer;
  }

  //Hàm này nhận biết sự thay đổi của Widget để thực hiện hành động
  @override
  void didUpdateWidget(covariant showHistoryAdvancePage oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    getAPIProfile();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(
        height: size.height * 0.71,
        width: size.width,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(5, 0, 5, 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 0.5,
                  child: Container(),
                ),
                txtItem(
                    context,
                    'Tổng tiền nợ: ',
                    totalAdvance != 0
                        ? '${getFormatPrice(totalAdvance.toString())} đ'
                        : "0 đ"),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(top: 0, left: 5, right: 5),
                    height: size.height,
                    width: size.width,
                    child: new CustomScrollView(
                      slivers: <Widget>[
                        PagedSliverList<int, AdvanceHistory>(
                          pagingController: _pagingController,
                          builderDelegate:
                              PagedChildBuilderDelegate<AdvanceHistory>(
                                  firstPageErrorIndicatorBuilder: (context) {
                                    return Column(
                                      children: [
                                        firstPageErrorIndicatorBuilder(context,
                                            tittle: showMessage("", MSG008)),
                                        GestureDetector(
                                          onTap: () =>
                                              _pagingController.refresh(),
                                          child: Text(
                                            showMessage('', MSG027),
                                            style: TextStyle(
                                                color: primaryLight3Color,
                                                fontSize: 18),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                  newPageErrorIndicatorBuilder: (context) =>
                                      firstPageErrorIndicatorBuilder(context,
                                          tittle: showMessage("", MSG008)),
                                  firstPageProgressIndicatorBuilder:
                                      (context) =>
                                          firstPageProgressIndicatorBuilder(),
                                  noItemsFoundIndicatorBuilder: (context) =>
                                      noItemsFoundIndicatorBuilder(),
                                  newPageProgressIndicatorBuilder: (context) =>
                                      newPageProgressIndicatorBuilder(),
                                  itemBuilder: (context, item, index) {
                                    var idSplit = item.id.split("-");
                                    String prefixId = idSplit[0].trim();
                                    if (prefixId == "TN") {
                                      return boxForAdvanceHistory(
                                        context: context,
                                        id: item.id,
                                        amount: item.amount,
                                        customerId: item.customerId,
                                        returnCash: item.returnCash,
                                        isAdvance: item.advance,
                                        dateTime: item.datetime,
                                        receiveDate: item.receiveDate,
                                        isPaid: item.paid,
                                        widget: FormForDetailPage(
                                          tittle: "Chi tiết đơn trả nợ",
                                          bodyPage: DetailAdvanceReturn(
                                            id: item.id,
                                            isDone: item.receiveDate != null? true : false,
                                          ),
                                        ),
                                      );
                                    } else {
                                      return boxForAdvanceHistory(
                                        context: context,
                                        id: item.id,
                                        amount: item.amount,
                                        customerId: item.customerId,
                                        returnCash: item.returnCash,
                                        isAdvance: item.advance,
                                        dateTime: item.datetime,
                                        receiveDate: item.receiveDate,
                                        isPaid: item.paid,
                                        widget: FormForDetailPage(
                                          tittle: "Chi tiết ứng tiền",
                                          bodyPage: DetailAdvancePage(
                                            isCustomer: true,
                                            id: item.id,
                                            status: 0,
                                            isRequest: false,
                                          ),
                                        ),
                                      );
                                    }
                                  }),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget noItemsFoundIndicatorBuilder() {
    return Column(
      children: [
        firstPageErrorIndicatorBuilder(context,
            tittle: showMessage("", MSG008)),
        GestureDetector(
          onTap: () => _pagingController.refresh(),
          child: Text(
            showMessage('', MSG027),
            style: TextStyle(color: welcome_color, fontSize: 18),
          ),
        ),
      ],
    );
  }

}
