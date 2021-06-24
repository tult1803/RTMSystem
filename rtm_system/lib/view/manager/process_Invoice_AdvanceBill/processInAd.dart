import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rtm_system/presenter/Manager/invoice/showRequestInvoice.dart';
import 'package:rtm_system/ultils/component.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';
import 'package:rtm_system/view/manager/home_manager_page.dart';

// ignore: camel_case_types
class requestInvoiceAdvance extends StatefulWidget {
  const requestInvoiceAdvance({Key key}) : super(key: key);

  @override
  _requestInvoiceAdvanceState createState() => _requestInvoiceAdvanceState();
}

class _requestInvoiceAdvanceState extends State<requestInvoiceAdvance> {
  bool isInvoice = true;
  final PageController _pageController = PageController();
  int index;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    index = 0;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: leadingAppbar(context,
              colorIcon: Colors.black,
              widget: HomeAdminPage(
                index: 0,
              )),
          title: Text(
            "Yêu cầu chờ xử lý",
            style: GoogleFonts.roboto(color: Colors.black, fontSize: 20),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.elliptical(30, 10),
              bottomRight: Radius.elliptical(30, 10),
            ),
          ),
          bottom: PreferredSize(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 0),
                child: bottomProcess(context),
              ),
              preferredSize: Size.fromHeight(20.0)),
        ),
        body: new SingleChildScrollView(
          child: pageViewInvocie(context),
        ));
  }

  //Để show các hóa đơn dựa trên _wrapToShowTittleBar tương ứng
  Widget pageViewInvocie(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
        width: size.width,
        height: size.height,
        child: PageView(
          controller: _pageController,
          scrollDirection: Axis.horizontal,
          onPageChanged: (value) {
            setState(() {
              value == 0 ? isInvoice = true : isInvoice = false;
            });
          },
          children: [
            new showInvoiceRequestManager(widgetToNavigator: requestInvoiceAdvance(),),
            //Chờ API Advance Bill
            new Container(
              width: size.width,
              height: size.height,
              child: Center(
                child: Text("Chờ API"),
              ),
            ),
          ],
        ));
  }

  Widget bottomProcess(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
            child: componentBottomProcessBar(
                title: "Hoá đơn",
                colorTitle: isInvoice ? welcome_color : Colors.black54)),
        Padding(
          padding: const EdgeInsets.only(bottom: 5.0),
          child: Text(
            "|",
            style: TextStyle(color: Colors.black54, fontSize: 20),
          ),
        ),
        Flexible(
            child: componentBottomProcessBar(
                title: "Ứng tiền",
                colorTitle: !isInvoice ? welcome_color : Colors.black54)),
      ],
    );
  }

  Widget componentBottomProcessBar({String title, Color colorTitle}) {
    return GestureDetector(
        onTap: () {
          setState(() {
            title == "Hoá đơn" ? isInvoice = true : isInvoice = false;
            title == "Hoá đơn"
                ? _pageController.jumpToPage(0)
                : _pageController.jumpToPage(1);
          });
        },
        child: Container(
            margin: EdgeInsets.only(left: 0, right: 0),
            height: 40,
            color: Colors.white10,
            child: Center(
                child: Text(
              title,
              style: GoogleFonts.roboto(color: colorTitle),
            ))));
  }
}
