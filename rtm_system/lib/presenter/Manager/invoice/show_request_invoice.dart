import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:rtm_system/model/get/getAPI_allInvoiceRequest.dart';
import 'package:rtm_system/model/model_invoice_request.dart';
import 'package:rtm_system/presenter/Manager/invoice/show_all_invoice.dart';
import 'package:rtm_system/helpers/common_widget.dart';
import 'package:rtm_system/helpers/component.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';
import 'package:rtm_system/view/detail_invoice_request.dart';
import 'package:rtm_system/view/manager/form_detail_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: camel_case_types, must_be_immutable
class showInvoiceRequestManager extends StatefulWidget {
  String fromDate, toDate, searchItem;
  final Widget widgetToNavigator;

  showInvoiceRequestManager(
      {this.fromDate, this.toDate, this.widgetToNavigator, this.searchItem});

  @override
  showInvoiceRequestManagerState createState() =>
      showInvoiceRequestManagerState();
}

// ignore: camel_case_types
class showInvoiceRequestManagerState extends State<showInvoiceRequestManager> {
  int _pageSize = 1;
  final PagingController _pagingController = PagingController(firstPageKey: 10);
  String _searchTerm;
  InvoiceRequest invoice;

  Future<void> _fetchPage(pageKey) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      GetInvoiceRequest getAPIAllInvoice = GetInvoiceRequest();
      invoice = await getAPIAllInvoice.getInvoiceRequest(
        context,
        prefs.get("access_token"),
        "",
        //Customer Id: truyền 0 là get All cho manager
        "",
        //Product Id: truyền 0 là get All cho manager
        pageKey,
        _pageSize,
        this.widget.fromDate == null ? "" : "${this.widget.fromDate}",
        this.widget.toDate == null ? "" : "${this.widget.toDate}",
        searchTerm: itemToSearch,
      );
      final isLastPage = invoice.invoiceRequests.length < pageKey;
      if (isLastPage) {
        _pagingController.appendLastPage(invoice.invoiceRequests);
      } else {
        setState(() {
          _pageSize += 1;
        });
        final nextPageKey = pageKey;
        _pagingController.appendPage(invoice.invoiceRequests, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  //Hàm này nhận biết sự thay đổi của Widget để thực hiện hành động
  @override
  void didUpdateWidget(covariant showInvoiceRequestManager oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.toDate != this.widget.toDate) {
      _pagingController.refresh();
    }

    if (oldWidget.searchItem != widget.searchItem) {
      _updateSearchTerm(widget.searchItem);
      setState(() {
        _pageSize = 1;
      });
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
                          style: TextStyle(color: welcome_color, fontSize: 18),
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
                          isCustomer: false,
                          isRequest: true,
                          invoiceRequestElement: item,
                          widgetToNavigator: this.widget.widgetToNavigator,
                        ),
                      ),
                      isCustomer: false);
                }),
          ),
        ],
      ),
    ));
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
