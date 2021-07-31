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
  const AdvancePage({Key key}) : super(key: key);

  @override
  State<AdvancePage> createState() => _AdvancePageState();
}

DateTime fromDate;
DateTime toDate;

class _AdvancePageState extends State<AdvancePage>
    with TickerProviderStateMixin {
  TabController _tabController;
  String getFromDate, getToDate;
  int index, _selectedIndex;
  int level = 0;

  @override
  void initState() {
    super.initState();
    //tab 1: yeu cau
    index = 0;
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _selectedIndex = _tabController.index;
      });
    });
    getAPIProfile();
    toDate = DateTime.now();
    fromDate = DateTime.now().subtract(Duration(days: 30));
    setState(() {
      getFromDate =
          "${getDateTime("$fromDate", dateFormat: "yyyy-MM-dd HH:mm:ss")}";
      getToDate =
          "${getDateTime("$toDate", dateFormat: "yyyy-MM-dd HH:mm:ss")}";
    });
  }

  Future getAPIProfile() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString('access_token');
    String phone = sharedPreferences.getString('phone');
    GetAPIProfileCustomer getAPIProfileCustomer = GetAPIProfileCustomer();
    InfomationCustomer infomationCustomer = InfomationCustomer();
    // Đỗ dữ liệu lấy từ api
    infomationCustomer =
        await getAPIProfileCustomer.getProfileCustomer(token, phone);
    setState(() {
      level = infomationCustomer.level;
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
        title: titleAppBar('Ứng tiền'),
        bottom: bottomTabBar(),
      ),
      body: tabView(),
      floatingActionButton:
          level != 0 ? showFloatBtn(_selectedIndex) : showHiddenFloatBtn(),
    );
  }

  Widget bottomTabBar() {
    return TabBar(
      labelPadding: EdgeInsets.symmetric(horizontal: 7.0),
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
          text: 'Đã duyệt',
        ),
        Tab(
          text: 'Huỷ bỏ',
        ),
        Tab(
          text: 'Lịch sử giao dịch',
        ),
      ],
    );
  }

  Widget tabView() {
    var size = MediaQuery.of(context).size;
    return TabBarView(
      controller: _tabController,
      children: <Widget>[
        //show advance chờ xử lý
        containerAdvance(size.height, 4),
        //Show advance được chấp nhận, đã mượn
        containerAdvance(size.height, 8),
        //Show advance bị từ chối
        containerAdvance(size.height, 6),
        //show advance đã trả
        containerAdvanceHistory(size.height, 8),
      ],
    );
  }

  //show invoice advance request
  Widget containerAdvance(height, status) {
    return Container(
        height: height,
        margin: EdgeInsets.only(left: 5, top: 12, right: 5),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              rowButtonDatetime(),
              new showAdvanceRequestPage(status,
                  fromDate: getFromDate, toDate: getToDate),
            ],
          ),
        ));
  }

  //show invoice advance history
  Widget containerAdvanceHistory(height, status) {
    return Container(
        height: height,
        margin: EdgeInsets.only(left: 5, top: 12, right: 5),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              new showHistoryAdvancePage(),
            ],
          ),
        ));
  }

  Widget showFloatBtn(index) {
    if (index == 1) {
      return FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PayDebt()),
          );
        },
        label: Text(
          'Trả nợ',
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
            MaterialPageRoute(builder: (context) => CreateRequestAdvance(levelCustomer: level,)),
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
    return Row(
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
