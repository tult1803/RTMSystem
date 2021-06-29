import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:rtm_system/model/getAPI_invoice.dart';
import 'package:rtm_system/model/model_invoice.dart';
import 'package:rtm_system/ultils/commonWidget.dart';
import 'package:rtm_system/ultils/component.dart';
import 'package:rtm_system/ultils/helpers.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';
import 'package:rtm_system/ultils/src/messageList.dart';
import 'package:rtm_system/view/customer/getMoney_or_payDebt.dart';
import 'package:rtm_system/view/detailInvoice.dart';
import 'package:rtm_system/view/manager/formForDetail_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: camel_case_types

class showDepositToProcess extends StatefulWidget {
  String fromDate, toDate;
  showDepositToProcess({this.fromDate, this.toDate});

  @override
  showAllInvoicePageState createState() => showAllInvoicePageState();
}
class showAllInvoicePageState extends State<showDepositToProcess> {
  int _pageSize = 1;
  final PagingController _pagingController = PagingController(firstPageKey: 10);
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
        5,
        pageKey,
        _pageSize,
        "",
        "",
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
  void didUpdateWidget(covariant showDepositToProcess oldWidget) {
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
    idInvoice.clear();
    totalAmount  = 0;
    totalAmountDeposit =0;
  }
  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(
        // nếu để size.height khi nó show từ 6 invoice trở lên, sẽ không thể chọn hoá đơn thứ 5 or 6.
        // khi kéo xuống thả ra nó tự động trở lại hoá đơn đầu
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
                    height: size.height ,
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
                                double amount = 0;
                                amount = getPriceTotal(double.parse(item['price'].toString()), double.parse(item['degree'].toString()),
                                    double.parse(item['quantity'].toString()));
                                totalAmount = amount.round() + totalAmount;
                                print(totalAmount);
                                DateTime from = DateTime.parse(widget.fromDate);
                                DateTime to = DateTime.parse(widget.toDate);
                                DateTime compare = DateTime.parse("${item['create_time']}");
                                if(compare.isAfter(from) && compare.isBefore(to)){
                                  double amountDeposit = 0;
                                  amountDeposit = getPriceTotal(double.parse(item['price'].toString()), double.parse(item['degree'].toString()),
                                      double.parse(item['quantity'].toString()));
                                  totalAmountDeposit = amountDeposit.round() + totalAmountDeposit;
                                  idInvoice.add(item['id']);
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
                                }
                                return null;
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


}
