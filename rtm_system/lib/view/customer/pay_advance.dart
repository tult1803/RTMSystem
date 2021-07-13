import 'package:auto_size_text/auto_size_text.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rtm_system/blocs/list_id_invoice.dart';
import 'package:rtm_system/blocs/select_dates_bloc.dart';
import 'package:rtm_system/blocs/total_amount_bloc.dart';
import 'package:rtm_system/blocs/total_deposit_bloc.dart';
import 'package:rtm_system/model/model_product.dart';
import 'package:rtm_system/model/get/getAPI_customer_phone.dart';
import 'package:rtm_system/model/model_profile_customer.dart';
import 'package:rtm_system/presenter/Customer/show_deposit_to_process.dart';
import 'package:rtm_system/helpers/button.dart';
import 'package:rtm_system/helpers/component.dart';
import 'package:rtm_system/ultils/get_api_data.dart';
import 'package:rtm_system/ultils/get_data.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';
import 'package:rtm_system/ultils/src/message_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetMoneyOrPayDebt extends StatefulWidget {
  const GetMoneyOrPayDebt({Key key, this.isPay}) : super(key: key);

  // isPay = true là hoá đơn để trả nợ
  final bool isPay;

  @override
  _GetMoneyOrPayDebtState createState() => _GetMoneyOrPayDebtState();
}

class _GetMoneyOrPayDebtState extends State<GetMoneyOrPayDebt> {
  List<DataProduct> dataListProduct = [];
  bool checkClick = false;
  String errNameProduct, token;
  bool checkProduct = true;
  int idProduct;
  // String getFromDate, getToDate;
  String title;
  int totalAdvance = 0;
  SelectDatesBloc _selectDatesBloc;
  bool _value= false;

  GetAPIProfileCustomer getAPIProfileCustomer = GetAPIProfileCustomer();
  InfomationCustomer informationCustomer = InfomationCustomer();
  //get total advance
  Future getAPIProfile() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString('access_token');
    String phone = sharedPreferences.getString('phone');
    // Đỗ dữ liệu lấy từ api
    informationCustomer =
        await getAPIProfileCustomer.getProfileCustomer(token, phone);
    if (informationCustomer != null) {
      setState(() {
        totalAdvance = informationCustomer.advance;
      });
    }
    return informationCustomer;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _selectDatesBloc = SelectDatesBloc(SelectDatesBloc.initDate());
    widget.isPay ? title = 'Trả nợ' : title = 'Nhận tiền';
    getAPIProfile();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
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
      ],
      child: Scaffold(
        backgroundColor: Color(0xffEEEEEE),
        appBar: AppBar(
          centerTitle: true,
          leading: leadingAppbar(context),
          backgroundColor: Color(0xFF0BB791),
          title: Text(
            title,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
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
                      if (widget.isPay)
                        _txtItemDetail(
                            context,
                            'Tổng tiền nợ: ',
                            totalAdvance != 0
                                ? '${getFormatPrice(totalAdvance.toString())} đ'
                                : "0 đ"),
                      if (widget.isPay)
                        SizedBox(
                          height: 10,
                        ),
                      BlocBuilder<TotalAmountBloc, int>(
                        builder: (context, state) {
                          return _txtItemDetail(context, 'Số tiền hiện có:',
                              '${getFormatPrice(state.toString())} đ');
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                  child: Center(
                    child: AutoSizeText(
                      'Các hóa đơn sẽ được thanh toán:',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 12),
                  width: size.width,
                  height: size.height * 0.6,
                  child: ContainedTabBarView(
                    tabBarProperties: TabBarProperties(
                      indicatorColor: Colors.green,
                      indicatorWeight: 1.0,
                      labelColor: primaryColor,
                      unselectedLabelColor: Colors.grey.withOpacity(1),
                      background: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.4),
                              spreadRadius: 0.5,
                              blurRadius: 2,
                            ),
                          ],
                        ),
                      ),
                    ),
                    tabs: [
                      AutoSizeText('Đơn ký gửi'),
                      AutoSizeText('Đơn nợ'),
                    ],
                    views: [
                      //show advance
                     
                      Container(
                        height: 360,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 5,
                              ),
                              rowButtonDatetime(),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10.0),
                                    ),
                                  ),
                                  padding: EdgeInsets.all(12),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      AutoSizeText(
                                        'Tống tiền các hóa đơn:',
                                        style: TextStyle(
                                          color: Color(0xFF0BB791),
                                        ),
                                      ),
                                      BlocBuilder<TotalDepositBloc, int>(
                                        builder: (context, state) {
                                          return AutoSizeText(
                                            "${getFormatPrice(state.toString())} đ",
                                            style: TextStyle(
                                              color: Colors.black,
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              showDepositToProcess(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                // _showBottomButton()
              ],
            ),
          ),
        ),
        // có nợ thì mới show ra, hiện tại api nợ = 0 vẫn trả được
        floatingActionButton: BlocBuilder<ListInvoiceIdBloc, List<String>>(
          builder: (context, state) {
            if (state.isNotEmpty) {
              if (widget.isPay) {
                if (totalAdvance == 0) {
                  return Container(
                    width: 1,
                    height: 1,
                    child: FloatingActionButton(
                      backgroundColor: backgroundColor,
                      onPressed: () {},
                    ),
                  );
                }
              }
              return FloatingActionButton.extended(
                onPressed: () {
                  //có bloc nên k thể tách hàm
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Thông báo'),
                        content: SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              widget.isPay
                                  ? Text(showMessage('', MSG028))
                                  : Text(showMessage('', MSG029)),
                            ],
                          ),
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              'Không',
                              style: TextStyle(
                                color: Colors.redAccent,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              widget.isPay
                                  ? putReturnAdvance(
                                      context, state, totalAdvance)
                                  : doConfirmOrAcceptOrRejectInvoice(
                                      context,
                                      "",
                                      state,
                                      1,
                                      true,
                                    );
                              ;
                            },
                            child: Text(
                              'Có',
                              style: TextStyle(
                                color: welcome_color,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
                label: Text(
                  'Xác nhận',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                backgroundColor: welcome_color,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0),
                ),
                elevation: 10,
              );
            } else {
              return Container(
                width: 1,
                height: 1,
                child: FloatingActionButton(
                  backgroundColor: backgroundColor,
                  onPressed: () {},
                ),
              );
            }
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
                color: Color(0xFF0BB791),
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
            color: Color(0xFFBDBDBD),
          ),
        ),
      ],
    );
  }
}