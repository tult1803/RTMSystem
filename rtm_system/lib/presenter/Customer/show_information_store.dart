import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:rtm_system/model/getAPI_allStore.dart';
import 'package:rtm_system/model/model_store.dart';
import 'package:rtm_system/ultils/common_widget.dart';
import 'package:rtm_system/ultils/component.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';
import 'package:rtm_system/ultils/src/message_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
                noItemsFoundIndicatorBuilder: (context) =>
                    noItemsFoundIndicatorBuilder(),
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

  Widget noItemsFoundIndicatorBuilder() {
    return Column(
      children: [
        firstPageErrorIndicatorBuilder(context,
            tittle: showMessage("", MSG032)),
        GestureDetector(
          onTap: () => _pagingController.refresh(),
          child: Text(
            showMessage('', MSG027),
            style: TextStyle(color: welcome_color, fontSize: 18),
          ),
        ),
      ],
    );
  }
}
