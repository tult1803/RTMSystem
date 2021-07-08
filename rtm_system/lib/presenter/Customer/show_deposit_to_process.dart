import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rtm_system/blocs/list_id_invoice.dart';
import 'package:rtm_system/blocs/select_dates_bloc.dart';
import 'package:rtm_system/blocs/total_amount_bloc.dart';
import 'package:rtm_system/blocs/total_deposit_bloc.dart';
import 'package:rtm_system/model/get/getAPI_invoice.dart';
import 'package:rtm_system/model/model_invoice.dart';
import 'package:rtm_system/helpers/common_widget.dart';
import 'package:rtm_system/ultils/get_data.dart';
import 'package:rtm_system/ultils/src/message_list.dart';
import 'package:rtm_system/view/detail_invoice.dart';
import 'package:rtm_system/view/manager/form_detail_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: camel_case_types

class showDepositToProcess extends StatefulWidget {
  showDepositToProcess();

  @override
  showAllInvoicePageState createState() => showAllInvoicePageState();
}

class showAllInvoicePageState extends State<showDepositToProcess> {
  Invoice invoice;
  List invoiceList;

  Future<bool> loadInvoiceDeposit() async {
    bool result = false;
    try {
      int _totalAmount = 0;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      GetInvoice getAPIAllInvoice = GetInvoice();
      invoice = await getAPIAllInvoice.getInvoice(
        prefs.get("access_token"),
        prefs.get("accountId"),
        "",
        5,
        1000,
        1,
        "",
        "",
      );
      invoiceList = invoice.invoices;
      invoiceList.forEach((element) {
        double amount = getPriceTotal(
                double.parse(element['price'].toString()),
                double.parse(element['degree'].toString()),
                double.parse(element['quantity'].toString())) ??
            0;
        _totalAmount += amount.round();
      });
      BlocProvider.of<TotalAmountBloc>(context).emit(_totalAmount);
      result = true;
    } catch (e) {}
    return result;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: loadInvoiceDeposit(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<String> invoiceIdList = [];
            return BlocBuilder<SelectDatesBloc, DateTimeRange>(
              builder: (context, state) {
              invoiceIdList.clear();
                List<Widget> children = [];
                DateTime from = state.start;
                DateTime to = state.end;
                int _totalDeposit = 0;
                invoiceList.forEach((element) {
                  DateTime compare =
                      DateTime.parse("${element['create_time']}");
                  if (compare.isAfter(from) && compare.isBefore(to)) {
                    double amountDeposit = 0;
                    amountDeposit = getPriceTotal(
                        double.parse(element['price'].toString()),
                        double.parse(element['degree'].toString()),
                        double.parse(element['quantity'].toString()));
                    _totalDeposit += amountDeposit.round();
                    BlocProvider.of<TotalDepositBloc>(context)
                        .emit(_totalDeposit);
                    invoiceIdList.add(element['id']);
                    children.add(
                      boxForInvoice(
                          context: context,
                          status: element['status_id'],
                          createDate: "${element['create_time']}",
                          price: element['price'],
                          quantity: element['quantity'],
                          degree: element['degree'],
                          id: element['id'],
                          activeDate: element["active_date"],
                          name: element["customer_name"],
                          product: element["product_name"],
                          widget: FormForDetailPage(
                            tittle: "Chi tiết hóa đơn",
                            bodyPage: DetailInvoice(
                              isCustomer: true,
                              map: element,
                            ),
                          ),
                          isRequest: false,
                          isCustomer: true),
                    );
                  }
                   BlocProvider.of<ListInvoiceIdBloc>(context)
                        .emit(invoiceIdList);
                });
                return Column(
                  children: children,
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: AutoSizeText(showMessage(MSG030, MSG027)),
            );
          } else {
            return CircularProgressIndicator();
          }
        });
  }
}
