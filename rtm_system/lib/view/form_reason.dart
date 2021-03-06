import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rtm_system/helpers/button.dart';
import 'package:rtm_system/helpers/component.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';

class ReasonToDelete extends StatefulWidget {
  String invoiceId;
  bool isCustomer, isRequest;
  Widget widgetToNavigator;
  bool isAdvanceBill;
  ReasonToDelete(
      {this.invoiceId,
        this.isAdvanceBill,
      this.isCustomer,
      this.isRequest,
      this.widgetToNavigator});

  @override
  _ReasonToDeleteState createState() => _ReasonToDeleteState();
}

class _ReasonToDeleteState extends State<ReasonToDelete> {
  String reason;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: leadingAppbar(context, colorIcon: Colors.white),
          centerTitle: true,
          title: Text(
            widget.isAdvanceBill != null
                ? "Từ chối ứng tiền"
            :"Hủy ${widget.isRequest == true ? "yêu cầu" : "hoá đơn"}",
            style: GoogleFonts.roboto(color: Colors.white),
          ),
        ),
        body: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Container(
              height: 350,
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black54,
                    blurRadius: 3,
                    offset: Offset(1, 1), // Shadow position
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  _txt("Lý do hủy:"),
                  SizedBox(
                    height: 10,
                  ),
                  _txtfield("Nhập lý do (Không bắt buộc)", 10, 1),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      btnDeleteRequestPage(
                          context, 140, 40, Colors.redAccent, "Hủy", false, isInvoice: widget.isRequest, isAdvanceBill: widget.isAdvanceBill,),
                      btnDeleteRequestPage(
                          context, 140, 40, welcome_color, "Xác nhận", false,
                          isInvoice: widget.isRequest,
                        isAdvanceBill: widget.isAdvanceBill,
                        reason: reason,
                        id: widget.invoiceId,
                      )
                    ],
                  ),
                ],
              )),
        ));
  }

  Widget _txt(String tittle) {
    return Container(
      margin: EdgeInsets.only(top: 10, left: 15),
      child: Text(
        tittle,
        style: GoogleFonts.roboto(color: Colors.black, fontSize: 17),
      ),
    );
  }

  Widget _txtfield(String hintText, int maxLines, int minLines) {
    return Container(
      margin: EdgeInsets.all(10),
      child: TextField(
        onChanged: (value) {
          setState(() {
            reason = value;
          });
        },
        maxLines: maxLines,
        keyboardType: TextInputType.text,
        style: TextStyle(fontSize: 15),
        cursorColor: welcome_color,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: '$hintText',
            //Sau khi click vào "Nhập tiêu đề" thì màu viền sẽ đổi
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: welcome_color),
            ),
            contentPadding: EdgeInsets.all(10)),
      ),
    );
  }
}

