import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:rtm_system/model/getAPI_invoice.dart';
import 'package:rtm_system/model/model_invoice.dart';
import 'package:rtm_system/ultils/commonWidget.dart';
import 'package:rtm_system/ultils/component.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';
import 'package:rtm_system/ultils/src/messageList.dart';
import 'package:rtm_system/view/detailInvoice.dart';
import 'package:rtm_system/view/manager/formForDetail_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: camel_case_types

// khi thêm data nó k load lại dk mà cần qua trang khác rồi ấn lại thì mới load lên
class showAllInvoicePage extends StatefulWidget {
  int statusId;
  String fromDate, toDate;

  showAllInvoicePage(this.statusId, {this.fromDate, this.toDate});

  @override
  showAllInvoicePageState createState() => showAllInvoicePageState();
}

class showAllInvoicePageState extends State<showAllInvoicePage> {
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
        prefs.get("accountId"),
        "",
        this.widget.statusId,
        //Status Id: truyền 4 là get all process invoice
        pageKey,
        _pageSize,
        this.widget.fromDate == null ? "" : "${this.widget.fromDate}",
        this.widget.toDate == null ? "" : "${this.widget.toDate}",
        searchTerm: _searchTerm,
      );
      invoiceList = invoice.invoices;
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
  void didUpdateWidget(covariant showAllInvoicePage oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    if(oldWidget.toDate != this.widget.toDate){
      _pagingController.refresh();
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
    return SingleChildScrollView(
      child: Container(
        height: size.height,
        width: size.width,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(5, 12, 5, 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //show button for hoá đơn ký gửi
                // if(widget.statusId == 5)
                //   _showProcessButton(),
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
                                            color: primaryLight3Color, fontSize: 18),
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
                                    date: "${item['create_time']}",
                                    total: "${item['price']}",
                                    id: item['id'],
                                    name: item["customer_name"],
                                    product: item["product_name"],
                                    widget: FormForDetailPage(
                                      tittle: "Chi tiết hóa đơn",
                                      bodyPage: DetailInvoice(
                                        isCustomer: true,
                                        map: item,
                                      ),
                                    ),
                                    isRequest: false,
                                    isCustomer: true);
                              }),
                        ),
                      ],
                    ),
                  ),)
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
//Khi có hàm này sẽ có lỗi
  // @override
  // void dispose() {
  //   _pagingController.dispose();
  //   super.dispose();
  // }
  Widget _showProcessButton() {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                width: 150,
                child: RaisedButton(
                  color: Color(0xFF0BB791),
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => GetMoneyOrPayDebt(
                    //             isPay: false,
                    //           )),
                    // );
                  },
                  child: Text(
                    'Lấy tiền',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 10,
                ),
              ),
            ],
          ),
        ],
      );
    }
}
