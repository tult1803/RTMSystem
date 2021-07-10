import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rtm_system/presenter/Manager/product/show_product_manager.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';
import 'package:rtm_system/view/manager/home_manager_page.dart';
import 'package:rtm_system/view/manager/process_Invoice_AdvanceBill/process_invoice_advance.dart';
import 'package:rtm_system/view/manager/product/update_price_product_manager.dart';
import 'package:rtm_system/view/manager/profile/allCustomer_manager.dart';

import '../../add_product_invoice.dart';

class AllProduct extends StatefulWidget {
  const AllProduct({Key key}) : super(key: key);

  @override
  _AllProductState createState() => _AllProductState();
}

class _AllProductState extends State<AllProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: welcome_color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.elliptical(30, 20),
              bottomRight: Radius.elliptical(30, 20),
            ),
          ),
          bottom: PreferredSize(
              // child: btnMain(context, 150, "Cập nhật giá", Icon(Icons.update),
              //     updatePriceProduct()),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: bottomHomeBar(context),
              ),
              preferredSize: Size.fromHeight(60.0)),
        ),
        body: new showAllProduct());
  }
}

Widget bottomHomeBar(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Flexible(
          child: Container(
        height: 10,
      )),
      miniIconTextContainer(
        context,
        height: 80,
        width: 80,
        borderRadius: 10,
        colorContainer: Colors.white,
        tittle: "Cập nhật",
        colorText: colorHexa("2B2D20"),
        icon: Icon(Icons.monetization_on_outlined),
        iconColor: welcome_color,
        iconSize: 35,
        widget: updatePriceProduct(
          widgetToNavigate: HomeAdminPage(
            index: 0,
          ),
        ),
      ),
      Flexible(
          child: Container(
        height: 10,
      )),
      miniIconTextContainer(
        context,
        height: 80,
        width: 80,
        borderRadius: 10,
        colorContainer: Colors.white,
        tittle: "Yêu cầu",
        colorText: colorHexa("2B2D20"),
        icon: Icon(Icons.assignment_outlined),
        iconColor: welcome_color,
        iconSize: 35,
        widget: requestInvoiceAdvance(),
      ),
      Flexible(
          child: Container(
        height: 10,
      )),
      miniIconTextContainer(context,
          height: 80,
          width: 80,
          borderRadius: 10,
          colorContainer: Colors.white,
          tittle: "Tạo",
          colorText: colorHexa("2B2D20"),
          icon: Icon(Icons.post_add),
          iconColor: welcome_color,
          iconSize: 35,
          widget: AddProductPage(
            tittle: "Tạo hóa đơn",
            isCustomer: false,
            widgetToNavigator: HomeAdminPage(
              index: 0,
            ),
          )),
      Flexible(
          child: Container(
        height: 10,
      )),
      miniIconTextContainer(context,
          height: 80,
          width: 80,
          borderRadius: 10,
          colorContainer: Colors.white,
          tittle: "Khách hàng",
          colorText: colorHexa("2B2D20"),
          fontSize: 12,
          icon: Icon(Icons.people_outline_rounded),
          iconColor: welcome_color,
          iconSize: 35,
          widget: AllCustomer(
              widgetToNavigator: HomeAdminPage(
            index: 0,
          ))),
      Flexible(
          child: Container(
        height: 10,
      )),
    ],
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
            : Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => widget),
                (route) => false),
        child: Column(
          children: [
            Expanded(
                child: icon == null
                    ? Icon(Icons.error)
                    : Icon(
                        icon.icon,
                        color: iconColor,
                        size: iconSize,
                      )),
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
