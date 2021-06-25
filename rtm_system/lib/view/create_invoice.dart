import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:rtm_system/model/getAPI_allStore.dart';
import 'package:rtm_system/model/getAPI_product.dart';
import 'package:rtm_system/model/model_product.dart';
import 'package:rtm_system/model/model_store.dart';
import 'package:rtm_system/ultils/component.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';
import 'package:rtm_system/ultils/src/messageList.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateInvoicePage extends StatefulWidget {
  const CreateInvoicePage({Key key, this.isNew, this.listProduct,
    this.isCustomer}): super(key: key);

  //false will show btn 'Sửa lại sản phẩm'
  final bool isNew;
  final List listProduct;
  final bool isCustomer;
  @override
  _CreateInvoicePageState createState() => _CreateInvoicePageState();
}

class _CreateInvoicePageState extends State<CreateInvoicePage> {
  String token, personSale = '', phoneSale = '', nameProduct, nameStore;
  DateTime date = DateTime.now();

  List<DataProduct> dataListProduct = [];
  Future _getProduct() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString("access_token");
      personSale = prefs.getString("fullname");
      phoneSale = prefs.getString("phone");
    });
    List<dynamic> dataList = [];
    GetProduct getProduct = GetProduct();
    dataListProduct.clear();
    if (token.isNotEmpty) {
      dataList = await getProduct.getProduct(token, "");
      dataList.forEach((element) {
        Map<dynamic, dynamic> data = element;
        dataListProduct.add(DataProduct.fromJson(data));
      });
      setState(() {
        // ignore: unnecessary_statements
        dataListProduct;
        nameProduct = _nameProduct();
      });
      return dataListProduct;
    }
  }

  String _nameProduct() {
    String name;
    if (dataListProduct != null) {
      dataListProduct?.map((item) {
            if (item.id== widget.listProduct[0]) {
              name = item.name;
            }
          })?.toList() ??
          [];
    }
    return name;
  }
  int _pageSize = 1;
  final PagingController<int, StoreElement> _pagingController =
  PagingController(firstPageKey: 10);
  Store store;
  List<StoreElement> storeList;


  Future<void> _fetchPage(pageKey) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      GetAPIAllStore getAPIAllStore = GetAPIAllStore();
      store = await getAPIAllStore.getStores(
        prefs.get("access_token"),
        pageKey,
        _pageSize,
      );
      storeList =  store.stores;
      final isLastPage = storeList.length < pageKey;
      if (isLastPage) {
        _pagingController.appendLastPage(storeList);
      } else {
        setState(() {
          _pageSize += 1;
        });
        final nextPageKey = pageKey;
        _pagingController.appendPage(storeList, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getProduct();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    _pagingController.addStatusListener((status) {
      if (status == PagingStatus.subsequentPageError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
              'Something went wrong while fetching a new page.',
            ),
            action: SnackBarAction(
              label: 'Thử lại',
              onPressed: () => _pagingController.retryLastFailedRequest(),
            ),
          ),
        );
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEEEEEE),
      appBar: AppBar(
        backgroundColor: Color(0xFF0BB791),
        centerTitle: true,
        leading: leadingAppbar(context),
        title: Text(
          "Tạo yêu cầu bán hàng",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w500, fontSize: 22),
        ),
      ),
      body:
      Container(
        // height: size.height * 0.08,
        child: CustomScrollView(
          slivers: <Widget>[
            PagedSliverList<int, StoreElement>(
              pagingController: _pagingController,
              builderDelegate: PagedChildBuilderDelegate<StoreElement>(
                  firstPageErrorIndicatorBuilder: (context) {
                    return Column(
                      children: [
                        firstPageErrorIndicatorBuilder(context,
                            tittle: showMessage(null, MSG008)),
                        GestureDetector(
                          onTap: () => _pagingController.refresh(),
                          child: Text(
                            showMessage(null, MSG027),
                            style: TextStyle(color: welcome_color, fontSize: 18),
                          ),
                        ),
                      ],
                    );
                  },
                  firstPageProgressIndicatorBuilder: (context) =>
                      firstPageProgressIndicatorBuilder(),
                  newPageProgressIndicatorBuilder: (context) =>
                      newPageProgressIndicatorBuilder(),
                  itemBuilder: (context, item, index) {
                    if(item.id.contains(widget.listProduct[4])){
                      nameStore = item.name;
                    }
                    return widgetCreateInvoice(
                        context, widget.isNew, widget.listProduct, nameProduct, nameStore,
                        personSale, phoneSale, widget.isCustomer);
                  }
              ),
            ),
          ],
        ),
      ),
    );
  }
}
