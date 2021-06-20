import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';
import 'package:rtm_system/view/customer/home_customer_page.dart';

class HomeMenu extends StatefulWidget {
  const HomeMenu({Key key}) : super(key: key);

  @override
  _HomeMenuState createState() => _HomeMenuState();
}
String money = '20,000,000';
class _HomeMenuState extends State<HomeMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEEEEEE),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: AppBar(
          backgroundColor: Color(0xFF0BB791),
          title: Container(
            width: 220,
            height: 200,
            child: Center(
              child: Image(
                image: AssetImage("images/rtmLogo.png"),
              ),
            ),
          ),
          centerTitle: true,
        ),
      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(height: 40,),
            twoBtnBody("Thông báo", Icons.notifications,"Cá nhân",Icons.people_rounded,  HomeCustomerPage(index: 3), HomeCustomerPage(index: 4)),
            SizedBox(height: 40,),
            twoBtnBody( "Hoá đơn",Icons.my_library_books, "Ứng tiền",
              Icons.monetization_on_outlined,HomeCustomerPage(index: 2),
              HomeCustomerPage(index: 1), ),
            SizedBox(height: 40,),
            twoBtnBody( "Liên hệ",Icons.contact_page, "",
              null, HomeCustomerPage(index: 2),
              null, ),
          ],
        )
      ),
    );
  }
  Widget twoBtnBody(name1, icon1, name2, icon2, widget1, widget2){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
            child: Container(
              height: 10,
            )),
        miniIconTextContainer(
          context,
          height: 125,
          width: 150,
          borderRadius: 20,
          colorContainer: Colors.white,
          tittle: name1,
          colorText: colorHexa("2B2D20"),
          icon: Icon(icon1,),
          iconColor: welcome_color,
          iconSize: 75,
          widget: widget1,
        ),
        Flexible(
            child: Container(
              height: 10,
            )),
        if(name2 != "" && icon2 != null && widget2 != null)
          miniIconTextContainer(
            context,
            height: 125,
            width: 150,
            borderRadius: 20,
            colorContainer: Colors.white,
            tittle: name2,
            colorText: colorHexa("2B2D20"),
            icon: Icon(icon2),
            iconColor: welcome_color,
            iconSize: 75,
            widget: widget2,
        ),
        if(name2 != "" && icon2 != null && widget2 != null)
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
              Container(
                  child: icon == null
                      ? Icon(Icons.error)
                      : Icon(
                    icon.icon,
                    color: iconColor,
                    size: iconSize,
                  )),
              SizedBox(height: 3,),
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
}
