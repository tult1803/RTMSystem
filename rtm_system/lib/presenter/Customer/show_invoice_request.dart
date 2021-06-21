import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:rtm_system/model/getAPI_allInvoiceRequest.dart';
import 'package:rtm_system/model/model_invoiceRequest.dart';
import 'package:rtm_system/ultils/commonWidget.dart';
import 'package:rtm_system/ultils/component.dart';
import 'package:rtm_system/ultils/detailInvoiceRequest.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';
<<<<<<< HEAD:rtm_system/lib/presenter/Customer/show_process_invoice.dart
=======
import 'package:rtm_system/ultils/src/messageList.dart';
import 'package:rtm_system/view/detailInvoice.dart';
>>>>>>> TrangBTT_Rev01:rtm_system/lib/presenter/Customer/show_invoice_request.dart
import 'package:rtm_system/view/manager/formForDetail_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: camel_case_types
// khi thêm data nó k load lại dk mà cần qua trang khác rồi ấn lại thì mới load lên
class showAllInvoiceRequestPage extends StatefulWidget {
  String fromDate, toDate;

  showAllInvoiceRequestPage({this.fromDate, this.toDate});

  @override
  showAllInvoiceRequestPageState createState() => showAllInvoiceRequestPageState();
}

class showAllInvoiceRequestPageState extends State<showAllInvoiceRequestPage> {
  int _pageSize = 1;
  final PagingController _pagingController = PagingController(firstPageKey: 10);
  String _searchTerm;
  InvoiceRequest invoiceRequest;
  List invoiceList;

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
        searchTerm: _searchTerm,
      );
      invoiceList = invoiceRequest.invoiceRequests;
      final isLastPage = invoiceList.length < pageKey;
      if (isLastPage) {
        _pagingController.appendLastPage(invoiceList);
      } else {
        setState(() {
          _pageSize += 1;
        });
        final nextPageKey = pageKey;
        _pagingController.appendPage(invoiceList, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  //Hàm này nhận biết sự thay đổi của Widget để thực hiện hành động
  @override
  void didUpdateWidget(covariant showAllInvoiceRequestPage oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    if(oldWidget.toDate != this.widget.toDate){
      _pagingController.refresh();
    }
    print(widget.toDate);
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
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
<<<<<<< HEAD:rtm_system/lib/presenter/Customer/show_process_invoice.dart

    return Container(
      margin: EdgeInsets.only(top: 0, left: 5, right: 5),
      height: widget.isAll? size.height : size.height * 0.5,
      width: size.width,
      child: new CustomScrollView(
        slivers: <Widget>[
          PagedSliverList(
            pagingController: _pagingController,
            builderDelegate: PagedChildBuilderDelegate(
                firstPageErrorIndicatorBuilder: (context) =>
                    firstPageErrorIndicatorBuilder(context,
                        tittle: "Không có dữ liệu"),
                firstPageProgressIndicatorBuilder: (context) =>
                    firstPageProgressIndicatorBuilder(),
                newPageProgressIndicatorBuilder: (context) =>
                    newPageProgressIndicatorBuilder(),
                itemBuilder: (context, item, index) {
                  return boxForInvoice(
                      context: context,
                      date: "${item['create_time']}",
                      total: "${item['price']}",
                      id: item['id'],
                      name: item["customer_name"],
                      product: item["product_name"],
                      widget: FormForDetailPage(
                        tittle: "Chi tiết hóa đơn",
                        // bodyPage: DetailInvoiceRequest(
                        //   map: item,
                        //   isCustomer: true,
                        // ),
                      ),
                      isCustomer: true,
                    isRequest: true,
                  );
                }),
=======
    return SingleChildScrollView(
      child: Container(
        height: size.height,
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
                                        tittle: showMessage("",MSG008)),
                                    GestureDetector(
                                      onTap: () => _pagingController.refresh(),
                                      child: Text(
                                        showMessage('', MSG027),
                                        style: TextStyle(
                                            color: welcome_color, fontSize: 18),
                                      ),
                                    ),
                                  ],
                                );
                              },
                              newPageErrorIndicatorBuilder: (context) =>
                                  firstPageErrorIndicatorBuilder(context,
                                      tittle: showMessage("",MSG008)),
                              firstPageProgressIndicatorBuilder: (context) =>
                                  firstPageProgressIndicatorBuilder(),
                              newPageProgressIndicatorBuilder: (context) =>
                                  newPageProgressIndicatorBuilder(),
                              itemBuilder: (context, item, index) {
                                return boxForInvoice(
                                    context: context,
                                    status: item['status_id'],
                                    date: "${item['create_date']}",
                                    total: "${item['price']}",
                                    id: item['id'].toString(),
                                    name: item["customer_name"],
                                    product: item["product_name"],
                                    widget: FormForDetailPage(
                                      tittle: "Chi tiết yêu cầu",
                                      bodyPage: DetailInvoiceRequest(
                                        isCustomer: true,
                                        map: item,
                                      ),
                                    ),
                                    isRequest: true,
                                    isCustomer: true);
                              }),
                        ),
                      ],
                    ),
                  ),)
              ],
            ),
>>>>>>> TrangBTT_Rev01:rtm_system/lib/presenter/Customer/show_invoice_request.dart
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

}