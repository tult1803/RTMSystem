import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:rtm_system/model/notice/getAPI_all_notice.dart';
import 'package:rtm_system/model/notice/model_all_notice.dart';
import 'package:rtm_system/presenter/infinite_scroll_pagination/common/character_search_input_sliver.dart';
import 'package:rtm_system/ultils/commonWidget.dart';
import 'package:rtm_system/ultils/component.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class showNotice extends StatefulWidget {
  @override
  _showNoticeState createState() => _showNoticeState();
}

class _showNoticeState extends State<showNotice> {
  int _pageSize = 1;
  final PagingController<int, NoticeList> _pagingController =
  PagingController(firstPageKey: 10);

  String _searchTerm;
  Notice notice;
  List<NoticeList> noticeList;
  @override
  void initState() {

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
              label: 'Retry',
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
      GetAPIAllNotice getAPIAllNotice = GetAPIAllNotice();
      notice = await getAPIAllNotice.getNotices(
        prefs.get("access_token"),
        pageKey,
        _pageSize,
        searchTerm: _searchTerm,
      );

      noticeList =  notice.noticeList;
      // print('Length NoticeList: ${noticeList.length}');
      // print("${_pagingController}");
      final isLastPage = noticeList.length < pageKey;
      // print("isLastPage: ${isLastPage} ---- ${noticeList.length} < ${pageKey}");
      if (isLastPage) {
        _pagingController.appendLastPage(noticeList);
      } else {
        setState(() {
          _pageSize += 1;
        });
        // final nextPageKey = pageKey + noticeList.length;
        final nextPageKey = pageKey;
        _pagingController.appendPage(noticeList, nextPageKey);


      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) => CustomScrollView(
    slivers: <Widget>[
      PagedSliverList<int, NoticeList>(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<NoticeList>(
            firstPageErrorIndicatorBuilder: (context) {
              return Column(
                children: [
                  firstPageErrorIndicatorBuilder(context,
                      tittle: "Không có dữ liệu."),
                  GestureDetector(
                    onTap: () => _pagingController.refresh(),
                    child: Text(
                      "Nhấn để tải lại",
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
              return containerButton(context, item.id, item.title, item.content, "${item.createDate}");
            }
        ),
      ),
    ],
  );

  void _updateSearchTerm(String searchTerm) {
    _searchTerm = searchTerm;
    _pagingController.refresh();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}

