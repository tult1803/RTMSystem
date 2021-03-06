import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rtm_system/helpers/component.dart';
import 'package:rtm_system/model/get/getAPI_customer_phone.dart';
import 'package:rtm_system/model/get/getAPI_invoice.dart';
import 'package:rtm_system/model/model_invoice.dart';
import 'package:rtm_system/model/model_profile_customer.dart';
import 'package:rtm_system/presenter/Manager/invoice/add_product_invoice.dart';
import 'package:rtm_system/ultils/get_data.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';
import 'package:rtm_system/view/customer/Profile/upgrade_account.dart';
import 'package:rtm_system/view/customer/advance/create_request_advance.dart';
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

  GetAPIProfileCustomer getAPIProfileCustomer = GetAPIProfileCustomer();
  InfomationCustomer infomationCustomer = InfomationCustomer();
  int level;
  int maxAdvance = 0;
  int maxAdvanceRequest = 0;

  Invoice invoice;
  @override
  void initState() {
    super.initState();
    getAmountDeposit();
    getAPIProfile();
  }

  Future<List> getAmountDeposit() async {
    List result;
    int _totalAmount = 0;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    GetInvoice getAPIAllInvoice = GetInvoice();
    invoice = await getAPIAllInvoice.getInvoice(
      context,
      prefs.get("access_token"),
      prefs.get("accountId"),
      "",
      5,
      1000,
      1,
      "",
      "",
    );
    if (invoice != null) {
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
      result = invoice.invoices;
    } else {
      result = [];
    }
    return result;
  }

  Future getAPIProfile() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString('access_token');
    String phone = sharedPreferences.getString('phone');
    // ????? d??? li???u l???y t??? api
    infomationCustomer =
        await getAPIProfileCustomer.getProfileCustomer(context, token, phone);
    if (infomationCustomer != null) {
      setState(() {
        level = infomationCustomer.level;
        advanceAmount = infomationCustomer.advance;
        maxAdvance = infomationCustomer.maxAdvance;
        maxAdvanceRequest = infomationCustomer.maxAdvanceRequest;
      });
    }
    return infomationCustomer;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: primaryColor,
        appBar: AppBar(
          backgroundColor: primaryColor,
          centerTitle: true,
          title: titleAppBar('Trang ch???'),
          elevation: 0,
        ),
        body: Column(
          children: [
            containerHeader(),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(35.0),
                    topRight: Radius.circular(35.0),
                  ),
                ),
                child: SingleChildScrollView(
                  child: level == null ? Container() : btnMenu(level),
                ),
              ),
            ),
          ],
        ));
  }

  Widget containerHeader() {
    return Container(
      margin: EdgeInsets.fromLTRB(12, 20, 12, 46),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(15.0),
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          centerTextMoney(context, "S??? ti???n hi???n c??", Icons.my_library_books,
              invoiceAmount),
          Container(
              child: Text(
            "|",
            style: TextStyle(fontSize: 27, color: primaryColor),
          )),
          centerTextMoney(context, "T???ng ti???n n???",
              Icons.monetization_on_outlined, advanceAmount),
        ],
      ),
    );
  }

  Widget centerTextMoney(
      BuildContext context, String title, IconData icon, int amount) {
    return Expanded(
      child: ListTile(
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: primaryColor,
              size: 29,
            ),
          ],
        ),
        title: AutoSizeText(
          "$title",
          style: TextStyle(color: Colors.black54, fontSize: 12),
        ),
        subtitle: AutoSizeText(
          "${getFormatPrice(amount.toString())} ??",
          style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black),
          maxLines: 1,
        ),
      ),
    );
  }

  Widget btnMenu(int levelCus) {
    if (levelCus == 0) {
      return Column(
        children: [
          btnContact(),
          twoBtnBody(
            "Xem ho?? ????n",
            Icons.post_add_outlined,
            null,
            null,
            HomeCustomerPage(
              index: 1,
              indexInvoice: 3,
              indexAdvance: 0,
            ),
            null,
            false,
          ),
          twoBtnBody(
            "C???p nh???t t??i kho???n",
            Icons.person_add_alt_1_outlined,
            null,
            null,
            UpgradeAccount(
              informationCustomer: infomationCustomer,
            ),
            null,
            true,
          ),
        ],
      );
    } else {
      return Column(
        children: [
          btnContact(),
          if (level == 2)
            twoBtnBody(
              "T???o b??n h??ng",
              Icons.playlist_add_check,
              "T???o ???ng ti???n",
              Icons.post_add_outlined,
              AddProductPage(
                isCustomer: true,
                tittle: "T???o y??u c???u b??n h??ng",
                level: level,
                widgetToNavigator: HomeCustomerPage(index: 0),
              ),
              CreateRequestAdvance(
                levelCustomer: level,
                maxAdvance: maxAdvance,
                maxAdvanceRequest: maxAdvanceRequest,
                totalAdvance: advanceAmount,
              ),
              true,
            ),
          twoBtnBody(
            "Nh???n ti???n",
            Icons.drive_file_rename_outline,
            "Tr??? n???",
            Icons.money_off_csred_rounded,
            GetMoneyDeposit(),
            PayDebt(),
            true,
          ),
          twoBtnBody(
              "X??c nh???n ho?? ????n",
              Icons.file_copy_outlined,
              "X??c nh???n ???ng ti???n",
              Icons.attach_money,
              HomeCustomerPage(
                index: 1,
                indexInvoice: 1,
                indexAdvance: 1,
              ),
              HomeCustomerPage(index: 2, indexAdvance: 1, indexInvoice: 0),
              false),
          if (level == 1)
            twoBtnBody(
              "T???o ???ng ti???n",
              Icons.post_add_outlined,
              "",
              null,
              CreateRequestAdvance(
                levelCustomer: level,
                maxAdvance: maxAdvance,
                maxAdvanceRequest: maxAdvanceRequest,
                totalAdvance: advanceAmount,
              ),
              null,
              true,
            ),
        ],
      );
    }
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
              blurRadius: 2,
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
              SizedBox(
                height: 10,
              ),
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
                  color: colorText,
                ),
              ),
            ],
          ),
        ));
  }

  Widget twoBtnBody(name1, icon1, name2, icon2, widget1, widget2, isCheck) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        miniIconTextContainer(context,
            height: 120,
            width: 150,
            borderRadius: 20,
            colorContainer: Colors.white,
            tittle: name1,
            colorText: Colors.black,
            icon: Icon(
              icon1,
            ),
            iconColor: primaryColor,
            iconSize: 50,
            widget: widget1,
            isCheck: isCheck,
            marginBottom: 30,
            fontSize: 15),
        if (name2 != "" && icon2 != null && widget2 != null)
          miniIconTextContainer(
            context,
            height: 120,
            width: 150,
            borderRadius: 20,
            colorContainer: Colors.white,
            tittle: name2,
            colorText: Colors.black,
            icon: Icon(icon2),
            iconColor: primaryColor,
            iconSize: 50,
            widget: widget2,
            isCheck: isCheck,
            marginBottom: 30,
            fontSize: 15,
          ),
      ],
    );
  }

  Widget btnContact() {
    return Container(
      margin: EdgeInsets.only(
        right: 24,
      ),
      child: TextButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => ContactPage()),
          );
        },
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(
                Icons.add_ic_call_outlined,
                color: primaryColor,
              ),
              SizedBox(
                width: 15,
              ),
              AutoSizeText(
                "Li??n h???",
                style:
                    TextStyle(color: primaryColor, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
