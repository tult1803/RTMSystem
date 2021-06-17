import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'package:rtm_system/model/getAPI_allInvoiceRequest.dart';
import 'package:rtm_system/model/model_invoice.dart';
import 'package:rtm_system/ultils/commonWidget.dart';
import 'package:rtm_system/ultils/component.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';
import 'package:rtm_system/view/customer/process/detail_invoice_request.dart';
import 'package:rtm_system/view/manager/formForDetail_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class showProcessInvoicePage extends StatefulWidget {
  const showProcessInvoicePage({Key key, this.idProduct, this.isAll}) : super(key: key);
  final int idProduct;
  final bool isAll;
  @override
  _showProcessInvoicePageState createState() => _showProcessInvoicePageState();
}

DateTime fromDate;
DateTime toDate;
var fDate = new DateFormat('dd-MM-yyyy');

class _showProcessInvoicePageState extends State<showProcessInvoicePage> {
  int _pageSize = 1;
  final PagingController _pagingController = PagingController(firstPageKey: 10);

  String _searchTerm;
  Invoice invoice;
  List invoiceList;

  Future<void> _fetchPage(pageKey) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      GetInvoiceRequest getInvoiceRequest = GetInvoiceRequest();
      invoice = await getInvoiceRequest.getInvoiceRequest(
        prefs.get("access_token"),
        prefs.get("accountId"),
        widget.idProduct,
        pageKey,
        _pageSize,
        fromDate,
        toDate,
        searchTerm: _searchTerm,
      );
      invoiceList = invoice.invoices;
      // print("${_pagingController}");
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
      print(error);
      _pagingController.error = error;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    toDate = DateTime.now();
    fromDate = DateTime.now().subtract(Duration(days: 30));
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
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

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
                        bodyPage: DetailInvoiceRequest(
                          map: item,
                          isCustomer: true,
                        ),
                      ),
                      isCustomer: true,
                    isRequest: true,
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

//Copy nó để tái sử dụng cho các trang khác nếu cần
// Không thể tách vì nó có hàm setState
  Widget datePick() {
    return TextButton(
      onPressed: () {
        setState(() {
          pickedDate();
        });
      },
    );
  }

  Future pickedDate() async {
    final initialDateRange = DateTimeRange(start: fromDate, end: toDate);
    final ThemeData theme = Theme.of(context);
    DateTimeRange dateRange = await showDateRangePicker(
        context: context,
        firstDate: DateTime(2000),
        lastDate: DateTime.now(),
        initialDateRange: initialDateRange,
        saveText: "Xác nhận",
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              //Dùng cho nút "X" của lịch
                appBarTheme: AppBarTheme(
                  iconTheme:
                  theme.primaryIconTheme.copyWith(color: Colors.white),
                ),
                //Dùng cho nút chọn ngày và background
                colorScheme: ColorScheme.light(
                  primary: welcome_color,
                )),
            child: child,
          );
        });
    if (dateRange != null) {
      print('Date '+ fromDate.toString());
      setState(() {
        fromDate = dateRange.start;
        toDate = dateRange.end;
        _pagingController.refresh();
      });
    }
  }
}
