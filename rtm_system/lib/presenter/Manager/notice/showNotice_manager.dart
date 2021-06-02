import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:rtm_system/model/notice/getAPI_all_notice.dart';
import 'package:rtm_system/model/notice/model_all_notice.dart';
import 'package:rtm_system/presenter/infinite_scroll_pagination/common/character_list_item.dart';
import 'package:rtm_system/presenter/infinite_scroll_pagination/common/character_search_input_sliver.dart';
import 'package:shared_preferences/shared_preferences.dart';

class showAllNotice extends StatefulWidget {
  @override
  _showAllNoticeState createState() => _showAllNoticeState();
}

class _showAllNoticeState extends State<showAllNotice> {
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
      CharacterSearchInputSliver(
        onChanged: (searchTerm) => _updateSearchTerm(searchTerm),
      ),
      PagedSliverList<int, NoticeList>(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<NoticeList>(
          itemBuilder: (context, item, index) => CharacterListItem(
            character: item,
          ),
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

