import 'package:flutter/material.dart';
import 'package:rtm_system/helpers/component.dart';
import 'package:rtm_system/model/get/getAPI_customer_phone.dart';
import 'package:rtm_system/model/model_profile_customer.dart';
import 'package:rtm_system/presenter/Customer/show_advance_request.dart';
import 'package:rtm_system/presenter/Customer/show_history_advance.dart';
import 'package:rtm_system/helpers/button.dart';
import 'package:rtm_system/ultils/get_data.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';
import 'package:rtm_system/view/customer/advance/create_request_advance.dart';
import 'package:rtm_system/view/customer/pay_advance.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdvancePage extends StatefulWidget {
  AdvancePage({this.index});

  int index;

  @override
  State<AdvancePage> createState() => _AdvancePageState();
}

DateTime fromDate;
DateTime toDate;

class _AdvancePageState extends State<AdvancePage>
    with TickerProviderStateMixin {
  TabController _tabController;
  String getFromDate, getToDate;
  int _selectedIndex, _index;
  int level = 0;
  int maxAdvance = 0;
  int maxAdvanceRequest = 0;
  int totalAdvance = 0;

  @override
  void initState() {
    super.initState();
    setState(() {
      _index = widget.index;
    });
    _tabController = TabController(
        length: 5,
        vsync: this,
        initialIndex: widget.index == null ? 0 : _index);
    _tabController.addListener(() {
      setState(() {
        _selectedIndex = _tabController.index;
      });
    });
    getAPIProfile();
    fromDate = DateTime.now().subtract(Duration(days: 30));
    toDate = DateTime.now();
    setState(() {
      getFromDate =
          "${getDateTime("$fromDate", dateFormat: "yyyy-MM-dd HH:mm:ss")}";
      getToDate =
          "${getDateTime("$toDate", dateFormat: "yyyy-MM-dd 23:59:59")}";
    });
  }

  Future getAPIProfile() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString('access_token');
    String phone = sharedPreferences.getString('phone');
    GetAPIProfileCustomer getAPIProfileCustomer = GetAPIProfileCustomer();
    InfomationCustomer infomationCustomer = InfomationCustomer();
    // ????? d??? li???u l???y t??? api
    infomationCustomer =
        await getAPIProfileCustomer.getProfileCustomer(context, token, phone);
    setState(() {
      level = infomationCustomer.level;
      maxAdvance = infomationCustomer.maxAdvance;
      maxAdvanceRequest = infomationCustomer.maxAdvanceRequest;
      totalAdvance = infomationCustomer.advance;
    });
    return infomationCustomer;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        centerTitle: true,
        title: titleAppBar('???ng ti???n'),
        bottom: bottomTabBar(),
      ),
      body: Stack(children: [
        Container(child: _selectedIndex == 2 ? null : rowButtonDatetime()),
        tabView(),
      ]),
      floatingActionButton:
          level != 0 ? showFloatBtn(_selectedIndex == null? _index: _selectedIndex) : showHiddenFloatBtn(),
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
          text: 'Ch??? duy???t',
        ),
        Tab(
          text: '???? duy???t',
        ),
        Tab(
          text: 'L???ch s??? giao d???ch',
        ),
        Tab(
          text: 'H???t h???n',
        ),
        Tab(
          text: 'T??? ch???i',
        ),
      ],
    );
  }

  Widget tabView() {
    return Padding(
      padding: EdgeInsets.only(top: _selectedIndex == 2 ? 20 : 65.0),
      child: TabBarView(
        controller: _tabController,
        children: <Widget>[
          //show advance ch??? x??? l??
          new showAdvanceRequestPage(4,
              fromDate: getFromDate, toDate: getToDate),
          //Show advance ???????c ch???p nh???n, ???? m?????n
          new showAdvanceRequestPage(8,
              fromDate: getFromDate, toDate: getToDate),
          //show advance ???? tr???
          // containerAdvanceHistory(size.height, 8),
          new showHistoryAdvancePage(),
          //show advance h???t h???n
          new showAdvanceRequestPage(7,
              fromDate: getFromDate, toDate: getToDate),
          //Show advance b??? t??? ch???i
          new showAdvanceRequestPage(6,
              fromDate: getFromDate, toDate: getToDate),
        ],
      ),
    );
  }

  Widget showFloatBtn(int index) {
    if (index == 1) {
      return FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PayDebt()),
          );
        },
        label: Text(
          'Tr??? n???',
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
      return FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CreateRequestAdvance(
                      levelCustomer: level,
                      maxAdvance: maxAdvance,
                      maxAdvanceRequest: maxAdvanceRequest,
                      totalAdvance: totalAdvance,
                    )),
          );
        },
        child: Icon(
          Icons.post_add_outlined,
          color: Colors.white,
          size: 25,
        ),
        backgroundColor: primaryColor,
      );
    }
  }

  Widget rowButtonDatetime() {
    return Container(
      height: 75,
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
