import 'package:auto_size_text/auto_size_text.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rtm_system/blocs/count_total_invoices.dart';
import 'package:rtm_system/blocs/count_total_invoices_selected.dart';
import 'package:rtm_system/blocs/list_id_invoice.dart';
import 'package:rtm_system/blocs/select_dates_bloc.dart';
import 'package:rtm_system/blocs/total_amount_bloc.dart';
import 'package:rtm_system/blocs/total_deposit_bloc.dart';
import 'package:rtm_system/helpers/dialog.dart';
import 'package:rtm_system/model/get/getAPI_AdvanceRequest.dart';
import 'package:rtm_system/model/modelAdvance_checked.dart';
import 'package:rtm_system/model/model_advance_request.dart';
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

class PayDebt extends StatefulWidget {
  const PayDebt({Key key}) : super(key: key);
  @override
  _PayDebtState createState() => _PayDebtState();
}

class _PayDebtState extends State<PayDebt> {
  List<DataProduct> dataListProduct = [];
  bool checkClick = false;
  String errNameProduct, token;
  bool checkProduct = true;
  int idProduct;
  String title;
  int totalAdvance = 0, totalAdvanceSelected = 0, totalDepositSelected;
  SelectDatesBloc _selectDatesBloc;

  GetAPIProfileCustomer getAPIProfileCustomer = GetAPIProfileCustomer();
  InfomationCustomer informationCustomer = InfomationCustomer();

  List<AdvanceChecked> selectedContacts = [];
  List<String> advanceIdList = [];
  List<Advance> advanceAccept = [];
  List<AdvanceChecked> advanceItem = [];

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

  Future<List<Advance>> loadAdvance() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    AdvanceRequest listAdvance;
    GetAdvanceRequest getAdvanceRequest = GetAdvanceRequest();
    listAdvance = await getAdvanceRequest.getAdvanceRequest(
      prefs.get("access_token"),
      prefs.get("accountId"),
      prefs.get("phone"),
      8, //get all status
      10000,
      1,
      "",
      "",
      searchTerm: "",
    );
    advanceAccept.clear();
    advanceAccept = listAdvance.advances;
    advanceAccept.forEach((element) {
      var idSplit = element.id.split("-");
      String prefixId = idSplit[0].trim();
      if (prefixId == "UT") {
        addIdAndAmount(element.id, element.amount);
      } else {
        print("tra no");
      }
    });
    return advanceAccept;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _selectDatesBloc = SelectDatesBloc(SelectDatesBloc.initDate());
    title = 'Trả nợ';
    getAPIProfile();
    loadAdvance();
    totalDepositSelected = 0;
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
        BlocProvider<CountTotalInvoicesBloc>(
          create: (context) => CountTotalInvoicesBloc(),
        ),
        BlocProvider<CountTotalInvoicesSelectedBloc>(
          create: (context) => CountTotalInvoicesSelectedBloc(),
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
                      _txtItemDetail(
                          context,
                          'Tổng tiền nợ: ',
                          totalAdvance != 0
                              ? '${getFormatPrice(totalAdvance.toString())} đ'
                              : "0 đ"),
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
                SizedBox(
                  height: 12,
                ),
                Container(
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
                                'Tống đơn ký gửi đã chọn($state1/$state2):',
                                style: TextStyle(
                                  color: Color(0xFF0BB791),
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
                SizedBox(
                  height: 12,
                ),
                Container(
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
                      AutoSizeText(
                        'Tống đơn nợ đã chọn(${selectedContacts.length}/ ${advanceItem.length}):',
                        style: TextStyle(
                          color: Color(0xFF0BB791),
                        ),
                      ),
                      AutoSizeText(
                        totalAdvanceSelected != 0
                            ? "${getFormatPrice(totalAdvanceSelected.toString())} đ"
                            : "$totalAdvanceSelected đ",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      )
                    ],
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
                      Container(
                        height: 360,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 5,
                              ),
                              rowButtonDatetime(),
                              showDepositToProcess(),
                            ],
                          ),
                        ),
                      ),

                      Container(
                        height: 500,
                        margin: EdgeInsets.fromLTRB(5, 12, 5, 12),
                        child: Column(
                          children: [
                            if (advanceItem.length > 0)
                              Container(
                                height: 300,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: ListView.builder(
                                    itemCount: advanceItem.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      // return item
                                      return AdvanceItem(
                                        advanceItem[index].id,
                                        advanceItem[index].amount,
                                        advanceItem[index].isSelected,
                                        index,
                                      );
                                    }),
                              ),
                          ],
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
                              Text(showMessage('', MSG028)),
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
                              if (selectedContacts.length > 0) {
                                if (totalAdvanceSelected >
                                    totalDepositSelected) {
                                  showCustomDialog(
                                    context,
                                    isSuccess: false,
                                    content: showMessage("", MSG033),
                                  );
                                } else {
                                  selectedContacts.forEach((element) {
                                    advanceIdList.add(element.id);
                                  });
                                  putReturnAdvance(context, state,
                                      advanceIdList, totalAdvance);
                                }
                              }else{
                                showCustomDialog(
                                    context,
                                    isSuccess: false,
                                    content: showMessage("", MSG034),
                                  );
                              }
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

  void addTotalAdvance(int amount) {
    setState(() {
      totalAdvanceSelected += amount;
    });
  }

  void removeTotalAdvance(int amount) {
    setState(() {
      totalAdvanceSelected -= amount;
    });
  }

  void addIdAndAmount(String id, int amount) {
    final expense = AdvanceChecked(
      id: id,
      amount: amount,
      isSelected: false,
    );
    advanceItem.add(expense);
  }

  Widget AdvanceItem(String id, int amount, bool isSelected, int index) {
    return ListTile(
      title: Text(
        "Mã: $id",
        style: TextStyle(
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        "Số tiền: ${getFormatPrice(amount.toString())} đ",
        style: TextStyle(
            // fontWeight: FontWeight.w500,
            color: primaryColor),
      ),
      trailing: isSelected
          ? Icon(
              Icons.check_circle,
              color: Colors.green[700],
            )
          : Icon(
              Icons.check_circle_outline,
              color: Colors.grey,
            ),
      onTap: () {
        setState(() {
          advanceItem[index].isSelected = !advanceItem[index].isSelected;
          if (advanceItem[index].isSelected == true) {
            selectedContacts.add(
                AdvanceChecked(id: id, amount: amount, isSelected: isSelected));
            addTotalAdvance(amount);
          } else if (advanceItem[index].isSelected == false) {
            selectedContacts
                .removeWhere((element) => element.id == advanceItem[index].id);
            removeTotalAdvance(amount);
          }
        });
      },
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
