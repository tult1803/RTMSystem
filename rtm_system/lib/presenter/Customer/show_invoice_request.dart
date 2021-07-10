import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:rtm_system/model/get/getAPI_allInvoiceRequest.dart';
import 'package:rtm_system/model/model_invoice_request.dart';
import 'package:rtm_system/helpers/common_widget.dart';
import 'package:rtm_system/helpers/component.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';
import 'package:rtm_system/ultils/src/message_list.dart';
import 'package:rtm_system/view/detail_invoice_request.dart';
import 'package:rtm_system/view/manager/form_detail_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: camel_case_types
// khi thêm data nó k load lại dk mà cần qua trang khác rồi ấn lại thì mới load lên
// ignore: must_be_immutable, camel_case_types
class showAllInvoiceRequestPage extends StatefulWidget {
  String fromDate, toDate;

  showAllInvoiceRequestPage({this.fromDate, this.toDate});

  @override
  showAllInvoiceRequestPageState createState() =>
      showAllInvoiceRequestPageState();
}

// ignore: camel_case_types
class showAllInvoiceRequestPageState extends State<showAllInvoiceRequestPage> {
  int _pageSize = 1;
  final PagingController _pagingController = PagingController(firstPageKey: 10);
  InvoiceRequest invoiceRequest;

  Future<void> _fetchPage(pageKey) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      GetInvoiceRequest getInvoiceRequest = GetInvoiceRequest();
      invoiceRequest = await getInvoiceRequest.getInvoiceRequest(
        prefs.get("access_token"),
        prefs.get("accountId"),
        "",
        pageKey,
        _pageSize,
        this.widget.fromDate == null ? "" : "${this.widget.fromDate}",
        this.widget.toDate == null ? "" : "${this.widget.toDate}",
        searchTerm: "",
      );
      final isLastPage = invoiceRequest.invoiceRequests.length < pageKey;
      if (isLastPage) {
        _pagingController.appendLastPage(invoiceRequest.invoiceRequests);
      } else {
        setState(() {
          _pageSize += 1;
        });
        final nextPageKey = pageKey;
        _pagingController.appendPage(invoiceRequest.invoiceRequests, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  //Hàm này nhận biết sự thay đổi của Widget để thực hiện hành động
  @override
  void didUpdateWidget(covariant showAllInvoiceRequestPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.toDate != this.widget.toDate) {
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
    return SingleChildScrollView(
      child: Container(
        height: size.height * 0.65,
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
                                        tittle: showMessage("", MSG008)),
                                    GestureDetector(
                                      onTap: () => _pagingController.refresh(),
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
                              firstPageProgressIndicatorBuilder: (context) =>
                                  firstPageProgressIndicatorBuilder(),
                              noItemsFoundIndicatorBuilder: (context) =>
                                  noItemsFoundIndicatorBuilder(),
                              newPageProgressIndicatorBuilder: (context) =>
                                  newPageProgressIndicatorBuilder(),
                              itemBuilder: (context, item, index) {
                                return boxForInvoiceRequest(
                                    context: context,
                                    status: item.statusId,
                                    createDate: "${item.createDate}",
                                    price: "${item.price}",
                                    id: item.id.toString(),
                                    name: item.customerName,
                                    product: item.productName,
                                    sellDate: item.sellDate,
                                    widget: FormForDetailPage(
                                      tittle: "Chi tiết yêu cầu",
                                      bodyPage: DetailInvoiceRequest(
                                        isCustomer: true,
                                        invoiceRequestElement: item,
                                      ),
                                    ),
                                    isCustomer: true);
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
