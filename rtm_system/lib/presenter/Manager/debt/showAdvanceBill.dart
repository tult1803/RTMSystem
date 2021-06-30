import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:rtm_system/model/getAPI_AdvanceRequest.dart';
import 'package:rtm_system/model/model_AdvanceRequest.dart';
import 'package:rtm_system/ultils/commonWidget.dart';
import 'package:rtm_system/ultils/component.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';
import 'package:rtm_system/view/detailAdvanceRequest.dart';
import 'package:rtm_system/view/manager/formForDetail_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: camel_case_types
class showAdvancceBillManager extends StatefulWidget {
  int statusId;
  String fromDate, toDate;
  final Widget widgetToNavigator;
  showAdvancceBillManager(this.statusId, {this.fromDate, this.toDate, this.widgetToNavigator});

  @override
  showAdvancceBillManagerState createState() => showAdvancceBillManagerState();
}

class showAdvancceBillManagerState extends State<showAdvancceBillManager> {
  int _pageSize = 1;
  final PagingController _pagingController = PagingController(firstPageKey: 10);
  String _searchTerm;
  AdvanceRequest advanceBill;
  List advanceList;

  Future<void> _fetchPage(pageKey) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      GetAdvanceRequest getAPIAllInvoice = GetAdvanceRequest();
      advanceBill = await getAPIAllInvoice.getAdvanceRequest(
        prefs.get("access_token"),
        "",
        widget.statusId,
        pageKey,
        _pageSize,
        this.widget.fromDate == null ? "" : "${this.widget.fromDate}",
        this.widget.toDate == null ? "" : "${this.widget.toDate}",
      );
      advanceList = advanceBill.advances;
      final isLastPage = advanceList.length < pageKey;
      if (isLastPage) {
        _pagingController.appendLastPage(advanceList);
      } else {
        setState(() {
          _pageSize += 1;
        });
        final nextPageKey = pageKey;
        _pagingController.appendPage(advanceList, nextPageKey);
      }
    } catch (error) {
      // print(error);
      _pagingController.error = error;
    }
  }

  //Hàm này nhận biết sự thay đổi của Widget để thực hiện hành động
  @override
  void didUpdateWidget(covariant showAdvancceBillManager oldWidget) {
    super.didUpdateWidget(oldWidget);
    if(oldWidget.toDate != this.widget.toDate){
      _pagingController.refresh();
    }
  }

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    width: size.width,
                    height: 20,
                    child: new CustomScrollView(
                      physics: NeverScrollableScrollPhysics(),
                      slivers: [
                        // CharacterSearchInputSliver(
                        //   onChanged: (searchTerm) {
                        //     _updateSearchTerm(searchTerm);
                        //     setState(() {
                        //       _pageSize = 1;
                        //     });
                        //   },
                        // ),
                      ],
                    )
                ),
                Expanded(
                    child: Container(
                      margin: EdgeInsets.only(top: 0, left: 5, right: 5),
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
                                          style: TextStyle(
                                              color: welcome_color, fontSize: 18),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                                newPageErrorIndicatorBuilder: (context) =>
                                    firstPageErrorIndicatorBuilder(context,
                                        tittle: "Không có dữ liệu"),
                                firstPageProgressIndicatorBuilder: (context) =>
                                    firstPageProgressIndicatorBuilder(),
                                newPageProgressIndicatorBuilder: (context) =>
                                    newPageProgressIndicatorBuilder(),
                                itemBuilder: (context, item, index) {
                                  return boxForAdvanceRequest(
                                      context: context,
                                      id: item['id'],
                                      status: item['status_id'],
                                      createDate: "${item['create_date']}",
                                      amount: "${item['amount']}",
                                      storeId: item['store_id'],
                                      name: item["customer_name"],
                                      receiveDate: item["receive_date"] ,
                                      imageUrl: item["image_url"],
                                      reason: item["reason"],
                                      widget: FormForDetailPage(
                                        tittle: "Chi tiết yêu cầu",
                                        bodyPage: DetailAdvancePage(
                                          isCustomer: false,
                                          id: item['id'],
                                          status: item['status_id'],
                                          isRequest: false,
                                        ),
                                      ),
                                      isCustomer: false);
                                }),
                          ),
                        ],
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  //Dùng để search
  void _updateSearchTerm(String searchTerm) {
    _searchTerm = searchTerm;
    _pagingController.refresh();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
