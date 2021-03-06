import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:rtm_system/model/get/getAPI_allStore.dart';
import 'package:rtm_system/model/model_store.dart';
import 'package:rtm_system/helpers/component.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';
import 'package:rtm_system/ultils/src/message_list.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class showStore extends StatefulWidget {
  @override
  _showStoreState createState() => _showStoreState();
}

class _showStoreState extends State<showStore> {
  int _pageSize = 1;
  final PagingController<int, StoreElement> _pagingController =
      PagingController(firstPageKey: 10);
  Store store;
  List<StoreElement> storeList;
  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    _pagingController.addStatusListener((status) {
      if (status == PagingStatus.subsequentPageError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              showMessage(MSG030, MSG027),
            ),
            action: SnackBarAction(
              label: showMessage("", MSG027),
              onPressed: () => _pagingController.retryLastFailedRequest(),
            ),
          ),
        );
      }
    });
    super.initState();
  }

  Future<void> _fetchPage(pageKey) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      GetAPIAllStore getAPIAllStore = GetAPIAllStore();
      store = await getAPIAllStore.getStores(
        context,
        prefs.get("access_token"),
        pageKey,
        _pageSize,
      );
      storeList = store.stores;
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
  Widget build(BuildContext context) => CustomScrollView(
        slivers: <Widget>[
          PagedSliverList<int, StoreElement>(
            pagingController: _pagingController,
            builderDelegate: PagedChildBuilderDelegate<StoreElement>(
                firstPageErrorIndicatorBuilder: (context) => noItemFound(),
                noItemsFoundIndicatorBuilder: (context) => noItemFound(),
                firstPageProgressIndicatorBuilder: (context) =>
                    firstPageProgressIndicatorBuilder(),
                newPageProgressIndicatorBuilder: (context) =>
                    newPageProgressIndicatorBuilder(),
                itemBuilder: (context, item, index) {
                  return containerStores(context, item.name, item.address,
                      item.phone, "${item.email}");
                }),
          ),
        ],
      );

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  Widget noItemFound(){
    return Column(
      children: [
        firstPageErrorIndicatorBuilder(context,
            tittle: "$MSG008"),
        GestureDetector(
          onTap: () => _pagingController.refresh(),
          child: Text(
            "$MSG027",
            style: TextStyle(color: primaryColor, fontSize: 18),
          ),
        ),
      ],
    );
  }

  Widget containerStores(BuildContext context, String name, String address,
      String phone, String email) {
    var size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15.0),
          topRight: Radius.circular(15.0),
        ),
      ),
      child: TextButton(
        style: TextButton.styleFrom(
          primary: Colors.black, // foreground
          textStyle: TextStyle(
            fontSize: 16,
          ),
        ),
        onPressed: () {
          setState(() {
            _makePhoneCall('tel:$phone');
          });
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: size.width * 0.93,
                  child: AutoSizeText(
                    "$name",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            AutoSizeText(
              "$address",
              style: TextStyle(
                fontSize: 14,
              ),
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(
              height: 10,
            ),
            AutoSizeText(
              "$phone",
              style: TextStyle(
                fontSize: 14,
              ),
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(
              height: 10,
            ),
            AutoSizeText(
              "$email",
              style: TextStyle(
                fontSize: 12,
                color: welcome_color,
              ),
              textAlign: TextAlign.left,
            ),
            SizedBox(
              height: 9,
            ),
            SizedBox(
              height: 0.5,
              child: Container(
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
