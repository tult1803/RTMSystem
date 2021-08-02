import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rtm_system/helpers/component.dart';
import 'package:rtm_system/model/get/getAPI_customer_phone.dart';
import 'package:rtm_system/model/get/getAPI_invoice.dart';
import 'package:rtm_system/model/model_invoice.dart';
import 'package:rtm_system/model/model_profile_customer.dart';
import 'package:rtm_system/ultils/get_data.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';
import 'package:rtm_system/view/customer/contact/ContactPage.dart';
import 'package:rtm_system/view/customer/get_money_deposit.dart';
import 'package:rtm_system/view/customer/home_customer_page.dart';
import 'package:rtm_system/view/customer/pay_advance.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeMenu extends StatefulWidget {
  const HomeMenu({Key key}) : super(key: key);

  @override
  State<HomeMenu> createState() => _HomeMenuState();
}

class _HomeMenuState extends State<HomeMenu> with TickerProviderStateMixin {
  TabController _tabController;
  int advanceAmount = 0, invoiceAmount = 0;
  Invoice invoice;
  @override
  void initState() {
    super.initState();
    getAmountAdvance();
    getAmountDeposit();
  }

  Future getAmountAdvance() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString('access_token');
    String phone = sharedPreferences.getString('phone');
    GetAPIProfileCustomer getAPIProfileCustomer = GetAPIProfileCustomer();
    InfomationCustomer infomationCustomer = InfomationCustomer();
    // Đỗ dữ liệu lấy từ api
    infomationCustomer =
        await getAPIProfileCustomer.getProfileCustomer(token, phone);
    setState(() {
      advanceAmount = infomationCustomer.advance;
    });
    return infomationCustomer;
  }

  Future<List> getAmountDeposit() async {
    int _totalAmount = 0;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    GetInvoice getAPIAllInvoice = GetInvoice();
    invoice = await getAPIAllInvoice.getInvoice(
      prefs.get("access_token"),
      prefs.get("accountId"),
      "",
      5,
      1000,
      1,
      "",
      "",
    );
    invoice.invoices.forEach((element) {
      double amount = getPriceTotal(
              double.parse(element.price.toString()),
              double.parse(element.degree.toString()),
              double.parse(element.quantity.toString())) ??
          0;
      _totalAmount += amount.round();
    });
    setState(() {
      invoiceAmount = _totalAmount;
    });
    return invoice.invoices;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: primaryColor,
        appBar: AppBar(
          backgroundColor: primaryColor,
          centerTitle: true,
          title: titleAppBar('Trang chủ'),
        ),
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(12, 24, 12, 24),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(15.0),
                  )),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  centerTextMoney(context, "Số tiền hiện có",
                      Icons.my_library_books, invoiceAmount),
                  centerTextMoney(context, "Tổng tiền nợ",
                      Icons.monetization_on_outlined, advanceAmount),
                ],
              ),
            ),
            Expanded(
              child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(35.0),
                      topRight: Radius.circular(35.0),
                    ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 35,
                      ),
                      twoBtnBody(
                        "Nhận tiền",
                        Icons.border_color,
                        "Trả nợ",
                        Icons.money_off,
                        GetMoneyDeposit(),
                        PayDebt(),
                        true,
                      ),
                      SizedBox(
                        height: 35,
                      ),
                      twoBtnBody(
                          "Xác nhận hoá đơn",
                          Icons.my_library_books,
                          "Xác nhận ứng tiền",
                          Icons.monetization_on_outlined,
                          HomeCustomerPage(index: 1, indexInvoice: 1, indexAdvance: 0,),
                          HomeCustomerPage(index: 2, indexAdvance: 1, indexInvoice: 0),
                          false),
                      SizedBox(
                        height: 35,
                      ),
                      twoBtnBody("Liên hệ", Icons.contact_page, "", null,
                          ContactPage(), null, true),
                    ],
                  )),
            ),
          ],
        ));
  }

  Widget bottomTabBar() {
    return TabBar(
      labelPadding: EdgeInsets.symmetric(horizontal: 7.0),
      indicatorColor: primaryColor,
      labelColor: Colors.white,
      unselectedLabelColor: Colors.white.withOpacity(0.5),
      controller: _tabController,
      tabs: <Widget>[
        Tab(
          child: Text('a'),
        ),
        Tab(
          child: Text('a'),
        ),
      ],
    );
  }

  Widget tabView() {
    var size = MediaQuery.of(context).size;
    return TabBarView(
      controller: _tabController,
      children: <Widget>[
        Container(),
        Container(),
      ],
    );
  }

  Widget centerTextMoney(
      BuildContext context, String title, IconData icon, int amount) {
    return Center(
      child: Column(
        children: [
          Row(
            children: [
              icon == null
                  ? Icon(Icons.error)
                  : Icon(
                      icon,
                      color: primaryColor,
                    ),
              SizedBox(
                width: 5,
              ),
              AutoSizeText(
                "${getFormatPrice(amount.toString())} đ",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ],
          ),
          AutoSizeText(
            "$title",
            style: TextStyle(color: Colors.black54, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget miniIconTextContainer(
    BuildContext context, {
    Icon icon,
    Widget widget,
    String tittle,
    double height,
    double width,
    Color colorContainer,
    Color colorText,
    Color iconColor,
    double marginLeft,
    double marginRight,
    double marginTop,
    double marginBottom,
    double borderRadius,
    double fontSize,
    double iconSize,
    FontWeight fontWeightText,
    bool isCheck,
  }) {
    return Container(
        margin: EdgeInsets.only(
          right: marginRight == null ? 0 : marginRight,
          top: marginTop == null ? 0 : marginTop,
          bottom: marginBottom == null ? 0 : marginBottom,
          left: marginLeft == null ? 0 : marginLeft,
        ),
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius:
              BorderRadius.circular(borderRadius == null ? 0 : borderRadius),
          color: colorContainer,
          boxShadow: [
            BoxShadow(
              color: Colors.black54,
              blurRadius: 3,
              offset: Offset(1, 1), // Shadow position
            ),
          ],
        ),
        child: TextButton(
          onPressed: () => widget == null
              ? null
              : isCheck
                  ? Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => widget),
                    )
                  : Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => widget),
                      (route) => false),
          child: Column(
            children: [
              Container(
                  child: icon == null
                      ? Icon(Icons.error)
                      : Icon(
                          icon.icon,
                          color: iconColor,
                          size: iconSize,
                        )),
              SizedBox(
                height: 3,
              ),
              AutoSizeText(
                tittle == null ? "" : tittle,
                style: GoogleFonts.roboto(
                    fontSize: fontSize,
                    fontWeight: fontWeightText,
                    color: colorText),
              ),
            ],
          ),
        ));
  }

  Widget twoBtnBody(name1, icon1, name2, icon2, widget1, widget2, isCheck) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        miniIconTextContainer(
          context,
          height: 120,
          width: 140,
          borderRadius: 20,
          colorContainer: Colors.white,
          tittle: name1,
          colorText: colorHexa("2B2D20"),
          icon: Icon(
            icon1,
          ),
          iconColor: welcome_color,
          iconSize: 65,
          widget: widget1,
          isCheck: isCheck,
        ),
        if (name2 != "" && icon2 != null && widget2 != null)
          miniIconTextContainer(
            context,
            height: 120,
            width: 140,
            borderRadius: 20,
            colorContainer: Colors.white,
            tittle: name2,
            colorText: colorHexa("2B2D20"),
            icon: Icon(icon2),
            iconColor: welcome_color,
            iconSize: 65,
            widget: widget2,
            isCheck: isCheck,
          ),
      ],
    );
  }
}
