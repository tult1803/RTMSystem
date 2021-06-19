import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:rtm_system/model/getAPI_invoice.dart';
import 'package:rtm_system/model/model_invoice.dart';
import 'package:rtm_system/ultils/commonWidget.dart';
import 'package:rtm_system/ultils/component.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';
import 'package:rtm_system/view/detailInvoice.dart';
import 'package:rtm_system/view/manager/formForDetail_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: camel_case_types
class showInvoiceManager extends StatefulWidget {
  int statusId;
  String fromDate, toDate;

  showInvoiceManager(this.statusId, {this.fromDate, this.toDate});

  @override
  showInvoiceManagerState createState() => showInvoiceManagerState();
}

class showInvoiceManagerState extends State<showInvoiceManager> {
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
        0,
        //Customer Id: truyền 0 là get All cho manager
        0,
        //Product Id: truyền 0 là get All cho manager
        this.widget.statusId,
        //Status Id: truyền 4 là get all process invoice
        pageKey,
        _pageSize,
        this.widget.fromDate == null ? "" : "${this.widget.fromDate}",
        this.widget.toDate == null ? "" : "${this.widget.toDate}",
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
      // print(error);
      _pagingController.error = error;
    }
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
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
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
                                      isCustomer: false,
                                      map: item,
                                    ),
                                  ),
                                  isRequest: false,
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
