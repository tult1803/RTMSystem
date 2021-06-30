import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:rtm_system/presenter/Manager/debt/showAdvanceBill.dart';
import 'package:rtm_system/ultils/commonWidget.dart';
import 'package:rtm_system/ultils/helpers.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';

class showAllBill extends StatefulWidget {
  final int index;

  showAllBill({this.index});

  @override
  _showAllBillState createState() => _showAllBillState();
}

DateTime fromDate;
DateTime toDate;

class _showAllBillState extends State<showAllBill>
    with TickerProviderStateMixin {
  TabController _tabController;
  String getFromDate, getToDate;
  int index;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
        length: 3,
        vsync: this,
        initialIndex:
            widget.index == null ? index = 0 : index = this.widget.index);

    toDate = DateTime.now();
    fromDate = DateTime.now().subtract(Duration(days: 30));
    getFromDate =
        "${getDateTime("$fromDate", dateFormat: "yyyy-MM-dd 00:00:00")}";
    getToDate = "${getDateTime("$toDate", dateFormat: "yyyy-MM-dd 23:59:59")}";
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: titleAppBar(),
        bottom: bottomAppBar(),
      ),
      body: Stack(
        children: [
          rowButtonDatetime(),
          tabBarView(),
        ],
      ),
    );
  }

  Widget titleAppBar() {
    return Center(
      child: Text(
        "Ứng tiền",
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.w500, fontSize: 22),
      ),
    );
  }

  Widget bottomAppBar() {
    return TabBar(
      indicatorColor: primaryColor,
      isScrollable: true,
      labelColor: Colors.white,
      unselectedLabelColor: Colors.white.withOpacity(0.5),
      controller: _tabController,
      tabs: <Widget>[
        Tab(text: "Đang xử lý"),
        Tab(text: "Chấp nhận"),
        Tab(text: "Từ chối"),
      ],
    );
  }

  //Dùng để show 2 cái nút để chọn ngày
  Widget rowButtonDatetime() {
    return Container(
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          btnDateTime(
              context,
              "${getDateTime("$fromDate", dateFormat: "dd/MM/yyyy")}",
              Icon(Icons.date_range),
              datePick()),
          SizedBox(
            width: 20,
            child: Center(
                child: Container(
                    alignment: Alignment.topCenter,
                    height: 45,
                    child: Text(
                      "-",
                      style: TextStyle(fontSize: 20),
                    ))),
          ),
          btnDateTime(
              context,
              "${getDateTime("$toDate", dateFormat: "dd/MM/yyyy")}",
              Icon(Icons.date_range),
              datePick()),
        ],
      ),
    );
  }

  Widget tabBarView() {
    return Padding(
      padding: const EdgeInsets.only(top: 50.0),
      child: TabBarView(
        controller: _tabController,
        children: <Widget>[
          new showAdvancceBillManager(4, fromDate: getFromDate, toDate: getToDate),
          new showAdvancceBillManager(8, fromDate: getFromDate, toDate: getToDate),
          new showAdvancceBillManager(6, fromDate: getFromDate, toDate: getToDate),
        ],
      ),
    );
  }

  //Copy nó để tái sử dụng cho các trang khác nếu cần
  // Không thể tách vì nó có hàm setState
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
    final ThemeData theme = Theme.of(context);
    final initialDateRange = DateTimeRange(start: fromDate, end: toDate);
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
      });
    }
  }
}
