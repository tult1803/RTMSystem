import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:rtm_system/presenter/Manager/debt/showAdvanceBill.dart';
import 'package:rtm_system/presenter/infinite_scroll_pagination/common/character_search_input_sliver.dart';
import 'package:rtm_system/helpers/common_widget.dart';
import 'package:rtm_system/ultils/get_data.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';
import 'package:rtm_system/view/manager/home_manager_page.dart';

class showAllBill extends StatefulWidget {
  final int index;

  showAllBill({this.index});

  @override
  _showAllBillState createState() => _showAllBillState();
}

DateTime fromDate;
DateTime toDate;
String itemToSearch;
class _showAllBillState extends State<showAllBill>
    with TickerProviderStateMixin {
  TabController _tabController;
  String getFromDate, getToDate;
  int index;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(
        length: 4,
        vsync: this,
        initialIndex:
            widget.index == null ? index = 1 : index = this.widget.index);

    toDate = DateTime.now();
    fromDate = DateTime.now().subtract(Duration(days: 30));
    getFromDate = "${getDateTime("$fromDate", dateFormat: "yyyy-MM-dd 00:00:00")}";
    getToDate = "${getDateTime("$toDate", dateFormat: "yyyy-MM-dd 23:59:59")}";
  }

  @override
  void dispose() {
    _tabController.dispose();
    itemToSearch = "";
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
          searchItem(context),
          tabBarView(),
        ],
      ),
    );
  }

  Widget searchItem(context){
    var size = MediaQuery.of(context).size;
    return Container(
        key: Key('Search'),
        padding: EdgeInsets.only(top: 40),
        width: size.width,
        child: new CustomScrollView(
          physics: NeverScrollableScrollPhysics(),
          slivers: [
            CharacterSearchInputSliver(
              hintText: "Tìm kiếm theo số điện thoại",
              onChanged: (searchTerm) {
                setState(() {
                  itemToSearch = searchTerm;
                });
              },
            ),
          ],
        )
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
        Tab(text: "Tất cả"),
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
      child:Row(
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
      padding: const EdgeInsets.only(top: 120.0),
      child: TabBarView(
        controller: _tabController,
        children: <Widget>[
          new showAdvancceBillManager(0, searchItem: itemToSearch),
          new showAdvancceBillManager(4, fromDate: getFromDate, toDate: getToDate, searchItem: itemToSearch, widgetToNavigator: HomeAdminPage(index: 2),),
          new showAdvancceBillManager(8, fromDate: getFromDate, toDate: getToDate, searchItem: itemToSearch),
          new showAdvancceBillManager(6, fromDate: getFromDate, toDate: getToDate, searchItem: itemToSearch),
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
        getFromDate =
        "${getDateTime("$fromDate", dateFormat: "yyyy-MM-dd 00:00:00")}";
        getToDate =
        "${getDateTime("$toDate", dateFormat: "yyyy-MM-dd 23:59:59")}";
      });
    }
  }
}
