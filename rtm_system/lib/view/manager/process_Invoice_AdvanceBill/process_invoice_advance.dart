import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rtm_system/presenter/Manager/debt/showAdvanceBill.dart';
import 'package:rtm_system/presenter/Manager/invoice/show_request_invoice.dart';
import 'package:rtm_system/helpers/component.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';
import 'package:rtm_system/view/manager/home_manager_page.dart';

// ignore: camel_case_types
class requestInvoiceAdvance extends StatefulWidget {
  final int index;

  requestInvoiceAdvance({this.index});

  @override
  _requestInvoiceAdvanceState createState() => _requestInvoiceAdvanceState();
}

// ignore: camel_case_types
class _requestInvoiceAdvanceState extends State<requestInvoiceAdvance>
    with TickerProviderStateMixin {
  bool isInvoice = true;
  TabController _tabController;
  int index;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
        length: 2,
        vsync: this,
        initialIndex:
            widget.index == null ? index = 0 : index = this.widget.index);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          leading: leadingAppbar(context,
              colorIcon: Colors.white,
              widget: HomeAdminPage(
                index: 0,
              )),
          title: Text(
            "Yêu cầu chờ xử lý",
            style: GoogleFonts.roboto(color: Colors.white, fontSize: 20),
          ),
          centerTitle: true,
          backgroundColor: welcome_color,
          bottom: bottomAppBar(),
        ),
        body: new SingleChildScrollView(
          child: Container(
              width: size.width, height: size.height, child: tabBarView()),
        ));
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
        Tab(text: "Hoá đơn"),
        Tab(text: "Ứng tiền"),
      ],
    );
  }

  Widget tabBarView() {
    return Padding(
      padding: const EdgeInsets.only(top: 1.0),
      child: TabBarView(
        controller: _tabController,
        children: [
          new showInvoiceRequestManager(
            widgetToNavigator: requestInvoiceAdvance(
              index: 0,
            ),
          ),
          //Chờ API Advance Bill
          new showAdvancceBillManager(
            4,
            widgetToNavigator: requestInvoiceAdvance(
              index: 1,
            ),
          )
        ],
      ),
    );
  }
}
