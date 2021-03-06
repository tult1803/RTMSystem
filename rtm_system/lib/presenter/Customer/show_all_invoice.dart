import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:rtm_system/model/get/getAPI_invoice.dart';
import 'package:rtm_system/model/model_invoice.dart';
import 'package:rtm_system/helpers/common_widget.dart';
import 'package:rtm_system/helpers/component.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';
import 'package:rtm_system/ultils/src/message_list.dart';
import 'package:rtm_system/view/detail_invoice.dart';
import 'package:rtm_system/view/manager/form_detail_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable, camel_case_types
class showAllInvoicePage extends StatefulWidget {
  int statusId;
  String fromDate, toDate;

  showAllInvoicePage(this.statusId, {this.fromDate, this.toDate});

  @override
  showAllInvoicePageState createState() => showAllInvoicePageState();
}

// ignore: camel_case_types
class showAllInvoicePageState extends State<showAllInvoicePage> {
  int _pageSize = 1;
  final PagingController _pagingController = PagingController(firstPageKey: 10);
  String _searchTerm;
  Invoice invoice;

  Future<void> _fetchPage(pageKey) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      GetInvoice getAPIAllInvoice = GetInvoice();
      invoice = await getAPIAllInvoice.getInvoice(
        context,
        prefs.get("access_token"),
        prefs.get("accountId"),
        "",
        this.widget.statusId,
        pageKey,
        _pageSize,
        this.widget.fromDate == null ? "" : "${this.widget.fromDate}",
        this.widget.toDate == null ? "" : "${this.widget.toDate}",
        searchTerm: _searchTerm,
      );
      final isLastPage = invoice.invoices.length < pageKey;
      if (isLastPage) {
        _pagingController.appendLastPage(invoice.invoices);
      } else {
        setState(() {
          _pageSize += 1;
        });
        final nextPageKey = pageKey;
        _pagingController.appendPage(invoice.invoices, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  //H??m n??y nh???n bi???t s??? thay ?????i c???a Widget ????? th???c hi???n h??nh ?????ng
  @override
  void didUpdateWidget(covariant showAllInvoicePage oldWidget) {
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
        // n???u ????? size.height khi n?? show t??? 6 invoice tr??? l??n, s??? kh??ng th??? ch???n ho?? ????n th??? 5 or 6.
        // khi k??o xu???ng th??? ra n?? t??? ?????ng tr??? l???i ho?? ????n ?????u
        height: size.height * 0.65,
        width: size.width,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(5, 12, 5, 8),
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
                                return boxForInvoice(
                                    context: context,
                                    status: item.statusId,
                                    createDate: "${item.createTime}",
                                    price: item.price,
                                    degree: item.degree,
                                    quantity: item.quantity,
                                    id: item.id,
                                    name: item.customerName,
                                    product: item.productName,
                                    widget: FormForDetailPage(
                                      tittle: "Chi ti???t h??a ????n",
                                      bodyPage: new DetailInvoice(
                                        isCustomer: true,
                                        invoiceElement: item,
                                      ),
                                    ),
                                    isRequest: false,
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

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
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
