import 'package:flutter/material.dart';
import 'package:rtm_system/helpers/component.dart';
import 'package:rtm_system/model/get/getAPI_customer_phone.dart';
import 'package:rtm_system/model/model_profile_customer.dart';
import 'package:rtm_system/presenter/Customer/show_all_invoice.dart';
import 'package:rtm_system/presenter/Customer/show_invoice_request.dart';
import 'package:rtm_system/helpers/button.dart';
import 'package:rtm_system/ultils/get_data.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';
import 'package:rtm_system/presenter/Manager/invoice/add_product_invoice.dart';
import 'package:rtm_system/view/customer/get_money_deposit.dart';
import 'package:rtm_system/view/customer/home_customer_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InvoiceTab extends StatefulWidget {
  InvoiceTab({this.index});

  int index;

  @override
  State<InvoiceTab> createState() => _InvoiceTabState();
}

DateTime fromDate;
DateTime toDate;

class _InvoiceTabState extends State<InvoiceTab> with TickerProviderStateMixin {
  TabController _tabController;
  String getFromDate, getToDate;
  int _index, _selectedIndex;
  GetAPIProfileCustomer getAPIProfileCustomer = GetAPIProfileCustomer();
  InfomationCustomer infomationCustomer = InfomationCustomer();
  int level = 0;

  Future getAPIProfile() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString('access_token');
    String phone = sharedPreferences.getString('phone');
    // Đỗ dữ liệu lấy từ api
    infomationCustomer =
        await getAPIProfileCustomer.getProfileCustomer(context, token, phone);
    if (infomationCustomer != null) {
      setState(() {
        level = infomationCustomer.level;
      });
    }
    return infomationCustomer;
  }

  @override
  void initState() {
    super.initState();
    print(widget.index);
    _tabController = TabController(
        length: 5,
        vsync: this,
        initialIndex:
            widget.index == null ? _index = 0 : _index = widget.index);
    _tabController.addListener(() {
      setState(() {
        _selectedIndex = _tabController.index;
      });
    });
    getAPIProfile();
    toDate = DateTime.now();
    fromDate = DateTime.now().subtract(Duration(days: 30));
    getFromDate =
        "${getDateTime("$fromDate", dateFormat: "yyyy-MM-dd HH:mm:ss")}";
    getToDate = "${getDateTime("$toDate", dateFormat: "yyyy-MM-dd 23:59:59")}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        centerTitle: true,
        title: titleAppBar('Hoá đơn'),
        bottom: bottomTabBar(),
      ),
      body: Stack(children: [
        rowButtonDatetime(),
        tabView(),
      ]),
      floatingActionButton: showFloatBtn(_selectedIndex, level),
    );
  }

  Widget bottomTabBar() {
    return TabBar(
      labelPadding: EdgeInsets.symmetric(horizontal: 12.0),
      indicatorColor: primaryColor,
      isScrollable: true,
      labelColor: Colors.white,
      unselectedLabelColor: Colors.white.withOpacity(0.5),
      controller: _tabController,
      tabs: <Widget>[
        Tab(
          text: 'Chờ duyệt',
        ),
        Tab(
          text: 'Chờ xác nhận',
        ),
        Tab(
          text: 'Ký gửi',
        ),
        Tab(
          text: 'Bán hàng',
        ),
        Tab(
          text: 'Từ chối',
        ),
      ],
    );
  }

  Widget tabView() {
    return Padding(
      padding: const EdgeInsets.only(top: 60.0),
      child: TabBarView(
        controller: _tabController,
        children: <Widget>[
          new Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: new showAllInvoiceRequestPage(
                fromDate: getFromDate, toDate: getToDate),
          ),
          //Show invoice processing
          new showAllInvoicePage(4, fromDate: getFromDate, toDate: getToDate),
          //Show invoice deposit
          new showAllInvoicePage(5, fromDate: getFromDate, toDate: getToDate),
          //Show sale's invoice: -1 ( done, undone, actice)
          new showAllInvoicePage(3, fromDate: getFromDate, toDate: getToDate),
          new showAllInvoicePage(2, fromDate: getFromDate, toDate: getToDate),
        ],
      ),
    );
  }

  Widget showFloatBtn(index, levelCustomer) {
    //index = 2 là tab thứ 2 "Ký gửi"
    if (index == 2) {
      if (levelCustomer != 0) {
        return FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => GetMoneyDeposit()),
            );
          },
          label: Text(
            'Nhận tiền',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0),
          ),
          elevation: 10,
        );
      } else {
        return showHiddenFloatBtn();
      }
    } else {
      if (levelCustomer == 2) {
        return FloatingActionButton(
          backgroundColor: primaryColor,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddProductPage(
                        isCustomer: true,
                        tittle: "Tạo yêu cầu bán hàng",
                        level: level,
                        widgetToNavigator: HomeCustomerPage(
                          index: 1,
                          indexInvoice: 0,
                        ),
                      )),
            );
          },
          child: Icon(
            Icons.post_add_outlined,
            color: Colors.white,
            size: 25,
          ),
        );
      } else {
        return showHiddenFloatBtn();
      }
    }
  }

  //show btn select date, it have setState should dont reuse
  Widget rowButtonDatetime() {
    return Container(
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          btnDateTimeForCustomer(
              context,
              "${getDateTime("$fromDate", dateFormat: "dd-MM-yyyy")}",
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
              "${getDateTime("$toDate", dateFormat: "dd-MM-yyyy")}",
              Icon(Icons.date_range),
              datePick()),
        ],
      ),
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
    final initialDateRange = DateTimeRange(start: fromDate, end: toDate);
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
      setState(() {
        fromDate = dateRange.start;
        toDate = dateRange.end;
        getFromDate =
            "${getDateTime("$fromDate", dateFormat: "yyyy-MM-dd HH:mm:ss")}";
        getToDate =
            "${getDateTime("$toDate", dateFormat: "yyyy-MM-dd 23:59:59")}";
      });
    }
  }
}
