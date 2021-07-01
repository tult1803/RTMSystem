import 'package:flutter/material.dart';
import 'package:rtm_system/model/model_invoice.dart';
import 'package:rtm_system/presenter/Manager/invoice/showInvoice.dart';
import 'package:rtm_system/presenter/Manager/invoice/showRequestInvoice.dart';
import 'package:rtm_system/presenter/infinite_scroll_pagination/common/character_search_input_sliver.dart';
import 'package:rtm_system/ultils/commonWidget.dart';
import 'package:rtm_system/ultils/helpers.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';
import 'package:rtm_system/view/manager/home_manager_page.dart';

class showAllInvoice extends StatefulWidget {
  final int index;

  showAllInvoice({this.index});

  @override
  _showAllInvoiceState createState() => _showAllInvoiceState();
}

DateTime fromDate;
DateTime toDate;
String itemToSearch;
class _showAllInvoiceState extends State<showAllInvoice>
    with TickerProviderStateMixin {
  TabController _tabController;
  int index;
  Invoice invoice;
  List invoiceList;
  String getFromDate, getToDate;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(
        length: 6,
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
        "Hóa đơn",
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.w500, fontSize: 22),
      ),
    );
  }

  Widget bottomAppBar() {
    return TabBar(
      // labelPadding: EdgeInsets.symmetric(horizontal: 7.0),
      indicatorColor: primaryColor,
      isScrollable: true,
      labelColor: Colors.white,
      unselectedLabelColor: Colors.white.withOpacity(0.5),
      controller: _tabController,
      tabs: <Widget>[
        Tab(text: "Yêu cầu"),
        Tab(text: "Xử lý"),
        Tab(text: "Hiệu lực"),
        Tab(text: "Ký gửi"),
        Tab(text: "Hoàn thành"),
        Tab(text: "Từ chối"),
      ],
    );
  }

  Widget tabBarView() {
    return Padding(
      padding: const EdgeInsets.only(top: 115.0),
      child: TabBarView(
        controller: _tabController,
        children: <Widget>[
          new showInvoiceRequestManager(
            fromDate: getFromDate,
            toDate: getToDate,
            widgetToNavigator: HomeAdminPage(
              index: 1,
            ),
            searchItem: itemToSearch,
          ),
          new showInvoiceManager(
            4,
            fromDate: getFromDate,
            toDate: getToDate,
            widgetToNavigator: HomeAdminPage(
              index: 1,
              indexInsidePage: 1,
            ),
            searchItem: itemToSearch,
          ),
          new showInvoiceManager(1, fromDate: getFromDate, toDate: getToDate, searchItem: itemToSearch,),
          new showInvoiceManager(5, fromDate: getFromDate, toDate: getToDate, searchItem: itemToSearch,),
          new showInvoiceManager(3, fromDate: getFromDate, toDate: getToDate, searchItem: itemToSearch,),
          new showInvoiceManager(2, fromDate: getFromDate, toDate: getToDate, searchItem: itemToSearch,),
        ],
      ),
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

  @override
  void dispose() {
    _tabController.dispose();
    itemToSearch = null;
    super.dispose();
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
            "${getDateTime("$fromDate", dateFormat: "yyyy-MM-dd 00:00:00")}";
        getToDate =
            "${getDateTime("$toDate", dateFormat: "yyyy-MM-dd 23:59:59")}";
        print(getToDate);
      });
    }
  }
}
