import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rtm_system/blocs/count_total_invoices.dart';
import 'package:rtm_system/blocs/count_total_invoices_selected.dart';
import 'package:rtm_system/blocs/list_id_invoice.dart';
import 'package:rtm_system/blocs/select_dates_bloc.dart';
import 'package:rtm_system/blocs/total_amount_bloc.dart';
import 'package:rtm_system/blocs/total_deposit_bloc.dart';
import 'package:rtm_system/model/get/getAPI_invoice.dart';
import 'package:rtm_system/model/model_invoice.dart';
import 'package:rtm_system/helpers/common_widget.dart';
import 'package:rtm_system/ultils/get_data.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';
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

  Future<List> loadInvoiceDeposit() async {
    int _totalAmount = 0;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    GetInvoice getAPIAllInvoice = GetInvoice();
    invoice = await getAPIAllInvoice.getInvoice(
      context,
      prefs.get("access_token"),
      prefs.get("accountId"),
      "",
      5,
      1000,
      1,
      "",
      "",
    );
    invoice.invoices.forEach((element) {
      double amount = getPriceTotal(
              double.parse(element.price.toString()),
              double.parse(element.degree.toString()),
              double.parse(element.quantity.toString())) ??
          0;
      _totalAmount += amount.round();
    });
    BlocProvider.of<TotalAmountBloc>(context).emit(_totalAmount);
    BlocProvider.of<CountTotalInvoicesBloc>(context).emit(invoice.total);
    return invoice.invoices;
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
                int count = 0;
                invoice.invoices.forEach((element) {
                  DateTime compare = DateTime.parse("${element.createTime}");
                  if (compare.isAfter(from) && compare.isBefore(to)) {
                    count = count + 1;
                    double amountDeposit = 0;
                    amountDeposit = getPriceTotal(
                        double.parse(element.price.toString()),
                        double.parse(element.degree.toString()),
                        double.parse(element.quantity.toString()));
                    _totalDeposit += amountDeposit.round();
                    BlocProvider.of<TotalDepositBloc>(context)
                        .emit(_totalDeposit);
                    invoiceIdList.add(element.id);
                    children.add(
                      boxForInvoice(
                          context: context,
                          status: element.statusId,
                          createDate: "${element.createTime}",
                          price: element.price,
                          quantity: element.quantity,
                          degree: element.degree,
                          id: element.id,
                          activeDate: element.activeDate,
                          name: element.customerName,
                          product: element.productName,
                          widget: FormForDetailPage(
                            tittle: "Chi tiết hóa đơn",
                            bodyPage: DetailInvoice(
                              isCustomer: true,
                              invoiceElement: element,
                            ),
                          ),
                          isRequest: false,
                          isCustomer: true),
                    );
                  } else {
                    BlocProvider.of<TotalDepositBloc>(context)
                        .emit(_totalDeposit);
                  }
                  BlocProvider.of<ListInvoiceIdBloc>(context)
                      .emit(invoiceIdList);
                  BlocProvider.of<CountTotalInvoicesSelectedBloc>(context)
                      .emit(count);
                });
                return Column(
                  children: children,
                );
              },
            );
          } else if (snapshot.hasError) {
            return showErrorLoadData();
          } else {
            return CircularProgressIndicator(
              color: primaryColor,
            );
          }
        });
  }
}
