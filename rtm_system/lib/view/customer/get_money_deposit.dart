import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rtm_system/blocs/count_total_invoices.dart';
import 'package:rtm_system/blocs/count_total_invoices_selected.dart';
import 'package:rtm_system/blocs/list_id_invoice.dart';
import 'package:rtm_system/blocs/select_dates_bloc.dart';
import 'package:rtm_system/blocs/total_amount_bloc.dart';
import 'package:rtm_system/blocs/total_deposit_bloc.dart';
import 'package:rtm_system/helpers/dialog.dart';
import 'package:rtm_system/presenter/Customer/show_deposit_to_process.dart';
import 'package:rtm_system/helpers/button.dart';
import 'package:rtm_system/helpers/component.dart';
import 'package:rtm_system/ultils/get_api_data.dart';
import 'package:rtm_system/ultils/get_data.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';
import 'package:rtm_system/ultils/src/message_list.dart';

class GetMoneyDeposit extends StatefulWidget {
  @override
  _GetMoneyDepositState createState() => _GetMoneyDepositState();
}

class _GetMoneyDepositState extends State<GetMoneyDeposit> {
  SelectDatesBloc _selectDatesBloc;
  int totalDepositSelected;
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _selectDatesBloc = SelectDatesBloc(SelectDatesBloc.initDate());
    totalDepositSelected = 0;
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TotalAmountBloc>(
          create: (BuildContext context) => TotalAmountBloc(),
        ),
        BlocProvider<TotalDepositBloc>(
          create: (BuildContext context) => TotalDepositBloc(),
        ),
        BlocProvider<SelectDatesBloc>(
          create: (context) => _selectDatesBloc,
        ),
        BlocProvider<ListInvoiceIdBloc>(
          create: (context) => ListInvoiceIdBloc(),
        ),
        BlocProvider<CountTotalInvoicesBloc>(
          create: (context) => CountTotalInvoicesBloc(),
        ),
        BlocProvider<CountTotalInvoicesSelectedBloc>(
          create: (context) => CountTotalInvoicesSelectedBloc(),
        ),
      ],
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          centerTitle: true,
          leading: leadingAppbar(context),
          backgroundColor: primaryColor,
          title: titleAppBar("Nh???n ti???n"),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.fromLTRB(5, 26, 5, 12),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Column(
                    children: [
                      BlocBuilder<TotalAmountBloc, int>(
                        builder: (context, state) {
                          return _txtItemDetail(context, 'S???? ti????n hi????n co??:',
                              '${getFormatPrice(state.toString())} ??');
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                containerTextInProcess(),
                SizedBox(
                  height: 5,
                ),
                rowButtonDatetime(),
                SizedBox(
                  height: 5,
                ),
                Container(
                  margin: EdgeInsets.only(left: 5, right: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                  padding: EdgeInsets.all(12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BlocBuilder<CountTotalInvoicesSelectedBloc, int>(
                        builder: (context, state1) {
                          return BlocBuilder<CountTotalInvoicesBloc, int>(
                            builder: (context, state2) {
                              return AutoSizeText(
                                'T????ng ti???n c??c ho?? ????n ???? ch???n($state1/$state2):',
                                style: TextStyle(
                                  color: primaryColor,
                                ),
                              );
                            },
                          );
                        },
                      ),
                      BlocBuilder<TotalDepositBloc, int>(
                        builder: (context, state) {
                          totalDepositSelected = state;
                          return AutoSizeText(
                            "${getFormatPrice(state.toString())} ??",
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                showDepositToProcess(),
                SizedBox(
                  height: 12,
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: BlocBuilder<ListInvoiceIdBloc, List<String>>(
          builder: (context, state) {
            return BlocBuilder<TotalAmountBloc, int>(
              builder: (context, state1) {
                if (state1 == 0) {
                  return showHiddenFloatBtn();
                }
                return FloatingActionButton.extended(
                  onPressed: () {
                    if (totalDepositSelected == 0) {
                      showEasyLoadingError(context, showMessage("", MSG043));
                    } else {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Th??ng b??o'),
                            content: SingleChildScrollView(
                              child: Column(
                                children: <Widget>[
                                  Text(showMessage('', MSG029)),
                                ],
                              ),
                            ),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  'Kh??ng',
                                  style: TextStyle(
                                    color: Colors.redAccent,
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  doConfirmOrAcceptOrRejectInvoice(
                                    context,
                                    "",
                                    state,
                                    1,
                                    true,
                                  );
                                },
                                child: Text(
                                  'C??',
                                  style: TextStyle(
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  label: titleAppBar('X??c nh???n'),
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  elevation: 10,
                );
              },
            );
          },
        ),
      ),
    );
  }

//show btn select date, it have setState should dont reuse
  Widget rowButtonDatetime() {
    return BlocBuilder<SelectDatesBloc, DateTimeRange>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            btnDateTimeForCustomer(
                context,
                "${getDateTime(state.start.toString(), dateFormat: "dd-MM-yyyy")}",
                Icon(Icons.date_range),
                datePick()),
            SizedBox(
              child: Center(
                  child: Container(
                      alignment: Alignment.topCenter,
                      height: 20,
                      child: Text(
                        "-",
                        style: TextStyle(fontSize: 20),
                      ))),
            ),
            btnDateTimeForCustomer(
                context,
                "${getDateTime(state.end.toString(), dateFormat: "dd-MM-yyyy")}",
                Icon(Icons.date_range),
                datePick()),
          ],
        );
      },
    );
  }

  Widget datePick() {
    return TextButton(
      onPressed: () {
        setState(() {
          pickedDate();
        });
      },
      child: null,
    );
  }

  Future pickedDate() async {
    final initialDateRange = DateTimeRange(
        start: _selectDatesBloc.state.start, end: _selectDatesBloc.state.end);
    final ThemeData theme = Theme.of(context);
    DateTimeRange dateRange = await showDateRangePicker(
        context: context,
        firstDate: DateTime(2000),
        lastDate: DateTime.now(),
        initialDateRange: initialDateRange,
        saveText: "X??c nh???n",
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
                //D??ng cho n??t "X" c???a l???ch
                appBarTheme: AppBarTheme(
                  iconTheme:
                      theme.primaryIconTheme.copyWith(color: Colors.white),
                ),
                //D??ng cho n??t ch???n ng??y v?? background
                colorScheme: ColorScheme.light(
                  primary: primaryColor,
                )),
            child: child,
          );
        });
    if (dateRange != null) {
      DateTimeRange newDateRange = DateTimeRange(
          start: dateRange.start,
          end: dateRange.end.add(Duration(
            hours: 23,
            minutes: 59,
            seconds: 59,
          )));

      _selectDatesBloc.emit(newDateRange);
    }
  }

  Widget _txtItemDetail(context, String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            AutoSizeText(
              title,
              style: TextStyle(
                color: primaryColor,
              ),
              overflow: TextOverflow.clip,
              textAlign: TextAlign.left,
            ),
          ],
        ),
        SizedBox(
          height: 5,
        ),
        AutoSizeText(
          content,
          style: TextStyle(
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.left,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 1,
          child: Container(
            color: lineColor,
          ),
        ),
      ],
    );
  }
}
