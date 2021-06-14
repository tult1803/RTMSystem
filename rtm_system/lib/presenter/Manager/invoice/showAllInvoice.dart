import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:rtm_system/model/getAPI_invoice.dart';
import 'package:rtm_system/model/model_invoice.dart';
import 'package:rtm_system/presenter/infinite_scroll_pagination/common/character_search_input_sliver.dart';
import 'package:rtm_system/ultils/commonWidget.dart';
import 'package:rtm_system/ultils/component.dart';
import 'package:rtm_system/ultils/helpers.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';
import 'package:rtm_system/view/add_product_in_invoice.dart';
import 'package:rtm_system/view/detailInvoice.dart';
import 'package:rtm_system/view/manager/formForDetail_page.dart';
import 'package:rtm_system/view/manager/invoice/processInvoice.dart';
import 'package:shared_preferences/shared_preferences.dart';

class showAllInvoice extends StatefulWidget {
  const showAllInvoice({Key key}) : super(key: key);

  @override
  _showAllInvoiceState createState() => _showAllInvoiceState();
}

DateTime fromDate;
DateTime toDate;

class _showAllInvoiceState extends State<showAllInvoice> {
  int _pageSize = 1;
  final PagingController _pagingController = PagingController(firstPageKey: 10);

  String _searchTerm;
  Invoice invoice;
  List invoiceList;

  Future<void> _fetchPage(pageKey) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      GetInvoice getAPIAllInvoice = GetInvoice();
      invoice = await getAPIAllInvoice.getInvoice(
        prefs.get("access_token"),
        0, //Customer Id: truyền 0 là get All cho manager
        0, //Product Id: truyền 0 là get All cho manager
        -1, //Status Id: truyền -1 là get all invoice trừ invoice đang ở trạng thái process
        pageKey,
        _pageSize,
        getDateTime("$fromDate", dateFormat: 'yyyy-MM-dd hh:mm:ss'),
        getDateTime("$toDate", dateFormat: 'yyyy-MM-dd hh:mm:ss'),
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
      height: size.height,
      width: size.width,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  btnMain(context, 110, "Chờ xử lý", Icon(Icons.update),
                      processInvoice()),
                  SizedBox(
                    width: 20,
                  ),
                  btnMain(
                      context,
                      120,
                      "Tạo hóa đơn",
                      Icon(Icons.post_add),
                      //Đây là trang create invoice
                      AddProductPage(
                        tittle: "Tạo hóa đơn",
                        isCustomer: false,
                      )),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  btnDateTime(context, "${getDateTime("$fromDate", dateFormat: "dd/MM/yyyy")}",
                      Icon(Icons.date_range), datePick()),
                  SizedBox(
                    width: 20,
                    child: Center(
                        child: Container(
                            alignment: Alignment.topCenter,
                            height: 45,
                            child: Text(
                              "-",
                              style: TextStyle(fontSize: 20),
                            ))),
                  ),
                  btnDateTime(context, "${getDateTime("$toDate", dateFormat: "dd/MM/yyyy")}",
                      Icon(Icons.date_range), datePick()),
                ],
              ),
              SizedBox(
                height: 0.5,
                child: Container(
                  color: Colors.black38,
                ),
              ),
              Expanded(
                  child: Container(
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
                                status: item['status_id'],
                                date: "${item['create_time']}",
                                total: "${item['price']}",
                                id: item['id'],
                                name: item["customer_name"],
                                product: item["product_name"],
                                widget: FormForDetailPage(
                                  tittle: "Chi tiết hóa đơn",
                                  bodyPage: DetailInvoice(
                                    map: item,
                                  ),
                                ),
                                isCustomer: false,
                            isRequest: false);
                          }),
                    ),
                  ],
                ),
              ))
            ],
          ),
        ),
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

//Copy nó để tái sử dụng cho các trang khác nếu cần
// Không thể tách vì nó có hàm setState
  Widget datePick() {
    return TextButton(
      onPressed: () {
        setState(() {
          pickedDate();
          _pageSize = 1;
        });
      }, child: null,
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
      setState(() {
        fromDate = dateRange.start;
        toDate = dateRange.end;
        _pagingController.refresh();
      });
    }
  }
}
