import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:rtm_system/model/get/getAPI_AdvanceRequest.dart';
import 'package:rtm_system/model/model_advance_request.dart';
import 'package:rtm_system/presenter/Manager/debt/show_all_advance_bill.dart';
import 'package:rtm_system/helpers/common_widget.dart';
import 'package:rtm_system/helpers/component.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';
import 'package:rtm_system/view/detail_advance_request.dart';
import 'package:rtm_system/view/manager/form_detail_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: camel_case_types, must_be_immutable
class showAdvancceBillManager extends StatefulWidget {
  final int statusId;
  String fromDate, toDate, searchItem;
  final Widget widgetToNavigator;

  showAdvancceBillManager(this.statusId,
      {this.fromDate, this.toDate, this.widgetToNavigator, this.searchItem});

  @override
  showAdvancceBillManagerState createState() => showAdvancceBillManagerState();
}

// ignore: camel_case_types
class showAdvancceBillManagerState extends State<showAdvancceBillManager> {
  int _pageSize = 1;
  final PagingController _pagingController = PagingController(firstPageKey: 10);
  String _searchTerm;
  AdvanceRequest advanceBill;

  Future<void> _fetchPage(pageKey) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      GetAdvanceRequest getAPIAllInvoice = GetAdvanceRequest();
      advanceBill = await getAPIAllInvoice.getAdvanceRequest(
        context,
        prefs.get("access_token"),
        0,
        "",
        prefs.get("phone"),
        widget.statusId,
        pageKey,
        _pageSize,
        this.widget.fromDate == null ? "" : "${this.widget.fromDate}",
        this.widget.toDate == null ? "" : "${this.widget.toDate}",
        searchTerm: itemToSearch,
      );
      final isLastPage = advanceBill.advances.length < pageKey;
      if (isLastPage) {
        _pagingController.appendLastPage(advanceBill.advances);
      } else {
        setState(() {
          _pageSize += 1;
        });
        final nextPageKey = pageKey;
        _pagingController.appendPage(advanceBill.advances, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  //H??m n??y nh???n bi???t s??? thay ?????i c???a Widget ????? th???c hi???n h??nh ?????ng
  @override
  void didUpdateWidget(covariant showAdvancceBillManager oldWidget) {

    super.didUpdateWidget(oldWidget);
    if (oldWidget.toDate != this.widget.toDate) {
      _pagingController.refresh();
    }

    if (oldWidget.searchItem != widget.searchItem) {
      _updateSearchTerm(widget.searchItem);
      setState(() {
        _pageSize = 1;
      });
    }
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
      margin: EdgeInsets.only(top: 0, left: 5, right: 5),
      height: size.height,
      width: size.width,
      child: new CustomScrollView(
        slivers: <Widget>[
          PagedSliverList(
            pagingController: _pagingController,
            builderDelegate: PagedChildBuilderDelegate(
                firstPageErrorIndicatorBuilder: (context) => noItemFound(),
                newPageErrorIndicatorBuilder: (context) =>
                    firstPageErrorIndicatorBuilder(context,
                        tittle: "Kh??ng c?? d??? li???u"),
                noItemsFoundIndicatorBuilder: (context) => noItemFound(),
                firstPageProgressIndicatorBuilder: (context) =>
                    firstPageProgressIndicatorBuilder(),
                newPageProgressIndicatorBuilder: (context) =>
                    newPageProgressIndicatorBuilder(),
                itemBuilder: (context, item, index) {
                  return boxForAdvance(
                         context: context,
                         id: item.id,
                         status: item.acceptStatusId,
                         statusAdvances: item.statusId,
                         createDate: "${item.createDate}",
                         amount: "${item.amount}",
                         storeId: item.storeId,
                         name: item.customerName,
                         receiveDate: item.receiveDate,
                         imageUrl: item.imageUrl,
                         isCheck: item.doneDate == null? false: true,
                         widget: FormForDetailPage(
                           tittle: "Chi ti???t ???ng ti???n",
                           bodyPage: DetailAdvancePage(
                             isCustomer: false,
                             id: item.id,
                             phoneCustomer: item.customerPhone,
                             status: item.statusId,
                             isRequest: false,
                             widgetToNavigator: widget.widgetToNavigator,
                           ),
                         ),
                         isCustomer: false
                   );
                }),
          ),
        ],
      ),
    ));
  }

  Widget noItemFound(){
    return Column(
      children: [
        firstPageErrorIndicatorBuilder(context,
            tittle: "Kh??ng c?? d??? li???u"),
        GestureDetector(
          onTap: () => _pagingController.refresh(),
          child: Text(
            "Nh???n ????? t???i l???i",
            style: TextStyle(color: welcome_color, fontSize: 18),
          ),
        ),
      ],
    );
  }
  //D??ng ????? search
  void _updateSearchTerm(String searchTerm) {
    _searchTerm = searchTerm;
    _pagingController.refresh();
  }
}
