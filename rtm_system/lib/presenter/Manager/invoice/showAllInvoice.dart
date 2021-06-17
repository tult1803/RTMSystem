import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:rtm_system/model/getAPI_invoice.dart';
import 'package:rtm_system/model/model_invoice.dart';
import 'package:rtm_system/presenter/Manager/invoice/showProcessInvoice.dart';
import 'package:rtm_system/ultils/commonWidget.dart';
import 'package:rtm_system/ultils/helpers.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';
import 'package:rtm_system/view/add_product_in_invoice.dart';
import 'package:shared_preferences/shared_preferences.dart';

class showAllInvoice extends StatefulWidget {
  const showAllInvoice({Key key}) : super(key: key);

  @override
  _showAllInvoiceState createState() => _showAllInvoiceState();
}

DateTime fromDate;
DateTime toDate;

class _showAllInvoiceState extends State<showAllInvoice> {
  final PageController _pageController = PageController();
  final PagingController _pagingController = PagingController(firstPageKey: 10);
  int _pageSize = 1;
  int index;
  String _searchTerm;
  Invoice invoice;
  List invoiceList;

  Future<void> _fetchPage(pageKey) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      GetInvoice getAPIAllInvoice = GetInvoice();
      invoice = await getAPIAllInvoice.getInvoice(
        prefs.get("access_token"),
        0,
        //Customer Id: truyền 0 là get All cho manager
        0,
        //Product Id: truyền 0 là get All cho manager
        -1,
        //Status Id: truyền -1 là get all invoice trừ invoice đang ở trạng thái process
        pageKey,
        _pageSize,
        getDateTime("$fromDate", dateFormat: 'yyyy-MM-dd hh:mm:ss'),
        getDateTime("$toDate", dateFormat: 'yyyy-MM-dd hh:mm:ss'),
        searchTerm: _searchTerm,
      );
      invoiceList = invoice.invoices;
      final isLastPage = invoiceList.length < pageKey;
      if (isLastPage) {
        _pagingController.appendLastPage(invoiceList);
      } else {
        setState(() {
          _pageSize += 1;
        });
        final nextPageKey = pageKey;
        _pagingController.appendPage(invoiceList, nextPageKey);
      }
    } catch (error) {
      print(error);
      _pagingController.error = error;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    index = 0;
    toDate = DateTime.now();
    fromDate = DateTime.now().subtract(Duration(days: 30));
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });

    _pagingController.addStatusListener((status) {
      if (status == PagingStatus.subsequentPageError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
              'Có lỗi xảy ra',
            ),
            action: SnackBarAction(
              label: 'Thử lại',
              onPressed: () => _pagingController.retryLastFailedRequest(),
            ),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery
        .of(context)
        .size;
    return Container(
      height: size.height,
      width: size.width,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              btnMain(
                  context,
                  120,
                  "Tạo hóa đơn",
                  Icon(Icons.post_add),
                  //Đây là trang create invoice
                  AddProductPage(
                    tittle: "Tạo hóa đơn",
                    isCustomer: false,
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  btnDateTime(
                      context,
                      "${getDateTime("$fromDate", dateFormat: "dd/MM/yyyy")}",
                      Icon(Icons.date_range),
                      datePick()),
                  SizedBox(
                    width: 20,
                    child: Center(
                        child: Container(
                            alignment: Alignment.topCenter,
                            height: 45,
                            child: Text(
                              "-",
                              style: TextStyle(fontSize: 20),
                            ))),
                  ),
                  btnDateTime(
                      context,
                      "${getDateTime("$toDate", dateFormat: "dd/MM/yyyy")}",
                      Icon(Icons.date_range),
                      datePick()),
                ],
              ),
              Container(
                child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      tittleBarForInvoice("Đang xử lý",
                          isChoose: index == 0 ? true : null),
                      spaceTittleBarForInvoice(),
                      tittleBarForInvoice("Ký gửi",
                          isChoose: index == 1 ? true : null),
                      spaceTittleBarForInvoice(),
                      tittleBarForInvoice("Hoàn thành",
                          isChoose: index == 2 ? true : null),
                      spaceTittleBarForInvoice(),
                      tittleBarForInvoice("Từ chối",
                          isChoose: index == 3 ? true : null),
                      spaceTittleBarForInvoice(),
                      tittleBarForInvoice("Có hiệu lực",
                          isChoose: index == 4 ? true : null),
                    ]),
              ),
              Expanded(
                child: Container(
                    child: PageView(
                      controller: _pageController,
                      scrollDirection: Axis.horizontal,
                      onPageChanged: (value) {
                        setState(() {
                          index = value;
                        });
                      },
                      children: [
                        Scaffold(
                          body: showInvoiceManager(4),
                        ),
                        Scaffold(
                          body: showInvoiceManager(5),
                        ),
                        Scaffold(
                          body: showInvoiceManager(3),
                        ),
                        Scaffold(
                          body: showInvoiceManager(2),
                        ),
                        Scaffold(
                          body: showInvoiceManager(1),
                        ),
                      ],
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _updateSearchTerm(String searchTerm) {
    _searchTerm = searchTerm;
    _pagingController.refresh();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    _pageController.dispose();
    super.dispose();
  }

//Copy nó để tái sử dụng cho các trang khác nếu cần
// Không thể tách vì nó có hàm setState
  Widget datePick() {
    return TextButton(
      onPressed: () {
        setState(() {
          pickedDate();
          _pageSize = 1;
        });
      },
      child: null,
    );
  }

  Future pickedDate() async {
    final initialDateRange = DateTimeRange(start: fromDate, end: toDate);
    final ThemeData theme = Theme.of(context);
    DateTimeRange dateRange = await showDateRangePicker(
        context: context,
        firstDate: DateTime(2000),
        lastDate: DateTime.now(),
        initialDateRange: initialDateRange,
        saveText: "Xác nhận",
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              //Dùng cho nút "X" của lịch
                appBarTheme: AppBarTheme(
                  iconTheme:
                  theme.primaryIconTheme.copyWith(color: Colors.white),
                ),
                //Dùng cho nút chọn ngày và background
                colorScheme: ColorScheme.light(
                  primary: welcome_color,
                )),
            child: child,
          );
        });
    if (dateRange != null) {
      setState(() {
        fromDate = dateRange.start;
        toDate = dateRange.end;
        _pagingController.refresh();
      });
    }
  }

  Widget tittleBarForInvoice(String tittle, {bool isChoose}) {
    return GestureDetector(
      onTap: () {
        setState(() {
          switch(tittle){
            case "Đang xử lý": _pageController.jumpToPage(0); break;
            case "Ký gửi": _pageController.jumpToPage(1); break;
            case "Hoàn thành": _pageController.jumpToPage(2); break;
            case "Từ chối": _pageController.jumpToPage(3); break;
            case "Có hiệu lực": _pageController.jumpToPage(4); break;
          }
        });
      },
      child: Text(
        tittle,
        style: TextStyle(
            fontSize: 15,
            decoration: TextDecoration.none,
            color: isChoose == null ? Colors.black54 : welcome_color),
      ),
    );
  }

  Widget spaceTittleBarForInvoice() {
    return SizedBox(
      width: 15,
      child: Text(
        " |",
        style: TextStyle(
            fontSize: 15,
            decoration: TextDecoration.none,
            color: Colors.black54),
      ),
    );
  }
}