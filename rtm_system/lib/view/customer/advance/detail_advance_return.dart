import 'package:auto_size_text/auto_size_text.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:rtm_system/helpers/button.dart';
import 'package:rtm_system/model/get/getAPI_AdvanceReturnDetail.dart';
import 'package:rtm_system/helpers/common_widget.dart';
import 'package:rtm_system/helpers/component.dart';
import 'package:rtm_system/model/model_advance_return_detail.dart';
import 'package:rtm_system/ultils/get_data.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';
import 'package:rtm_system/ultils/src/message_list.dart';
import 'package:rtm_system/view/customer/advance/detail_invoice_in_advance.dart';
import 'package:rtm_system/view/manager/form_detail_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailAdvanceReturn extends StatefulWidget {
  final String id;
  final bool isDone;
  DetailAdvanceReturn({this.id, this.isDone});

  @override
  _DetailAdvanceReturnState createState() => _DetailAdvanceReturnState();
}

class _DetailAdvanceReturnState extends State<DetailAdvanceReturn> {
  AdvanceReturnDetail advanceReturnDetail = AdvanceReturnDetail();

  @override
  void initState() {
    super.initState();
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
          List<Widget> childrenInvoice = [];
          List<Widget> childrenAdvance = [];
          advanceReturnDetail.invoices.forEach((element) {
            childrenInvoice.add(boxForInvoice(
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
          advanceReturnDetail.advances.forEach((element) {
            childrenAdvance.add(boxForAdvanceHistory(
              context: context,
              id: element.id,
              amount: element.amount,
              isAdvance: true,
              dateTime: element.doneDate,
              returnCash: 0,
            ));
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
                    isDone: widget.isDone,
                  ),
                  Container(
                    width: size.width,
                    height: size.height * 0.5,
                    child: ContainedTabBarView(
                      tabBarProperties: TabBarProperties(
                        indicatorColor: Colors.black,
                        indicatorWeight: 1.0,
                        labelColor: primaryColor,
                        unselectedLabelColor: Colors.grey.withOpacity(1),
                      ),
                      tabs: [
                        AutoSizeText('Đơn nợ'),
                        AutoSizeText('Đơn ký gửi'),
                      ],
                      views: [
                        //show advance
                        Container(
                          height: 360,
                          child: SingleChildScrollView(
                            child: Column(
                              children: childrenAdvance,
                            ),
                          ),
                        ),
                        Container(
                          height: 360,
                          child: SingleChildScrollView(
                            child: Column(
                              children: childrenInvoice,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (widget.isDone == false)
                    btnConfirmAdvanceReturn(context, id: widget.id),
                ],
              ),
            ),
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
