import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:rtm_system/model/get/getAPI_AdvanceReturnDetail.dart';
import 'package:rtm_system/helpers/common_widget.dart';
import 'package:rtm_system/helpers/component.dart';
import 'package:rtm_system/model/model_advance_return_detail.dart';
import 'package:rtm_system/ultils/src/message_list.dart';
import 'package:rtm_system/view/customer/advance/detail_invoice_in_advance.dart';
import 'package:rtm_system/view/manager/form_detail_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailAdvanceReturn extends StatefulWidget {
  final String id;

  DetailAdvanceReturn({this.id});

  @override
  _DetailAdvanceReturnState createState() => _DetailAdvanceReturnState();
}

class _DetailAdvanceReturnState extends State<DetailAdvanceReturn> {
  AdvanceReturnDetail advanceReturnDetail = AdvanceReturnDetail();
  @override
  void initState() {
    super.initState();
    getDetail();
  }

  Future getDetail() async {
    GetAdvanceReturnDetail getAdvanceReturnDetail = GetAdvanceReturnDetail();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString('access_token');
    // Đỗ dữ liệu lấy từ api
    advanceReturnDetail = await getAdvanceReturnDetail.getAdvanceReturnDetail(
      token,
      widget.id,
    );
    return advanceReturnDetail;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return new FutureBuilder(
      future: getDetail(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          List<Widget> children = [];
          advanceReturnDetail.invoices.forEach((element) {
            children.add(boxForInvoice(
                context: context,
                status: element.statusId,
                createDate: element.createTime,
                price: element.price,
                quantity: element.quantity,
                degree: element.degree,
                id: element.id,
                activeDate: element.activeDate,
                name: element.customerName,
                product: element.productName,
                widget: FormForDetailPage(
                  tittle: "Chi tiết hóa đơn",
                  bodyPage: DetailInvoiceInAdvance(
                    invoice: element,
                  ),
                ),
                isRequest: false,
                isCustomer: true));
          });
          return SingleChildScrollView(
            child: containerDetail(
                context,
                Column(
                  children: [
                    componentContainerAdvanceReturnDetail(
                      context,
                      id: widget.id,
                      createDate: advanceReturnDetail.createDate,
                      invoices: advanceReturnDetail.invoices,
                      returnCash: advanceReturnDetail.returnCash,
                      total: advanceReturnDetail.total,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: AutoSizeText(
                        'Các hoá đơn dùng để trả nợ:',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),
                    SingleChildScrollView(
                      child: Container(
                        child: Column(
                          children: children,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                  ],
                )),
          );
        } else if (snapshot.hasError) {
          return Container(
            margin: EdgeInsets.all(12),
            child: Center(
              child: Column(
                children: [
                  AutoSizeText(showMessage("", MSG008),
                      style: TextStyle(fontWeight: FontWeight.w500)),
                ],
              ),
            ),
          );
        }
        return Container(
            height: size.height,
            child: Center(
                child: CircularProgressIndicator(
              color: Colors.white,
            )));
      },
    );
  }
}
