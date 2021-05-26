import 'package:flutter/material.dart';

class DetailOfNotice extends StatelessWidget {
  const DetailOfNotice({Key key,  this.titleNotice, this.contentNotice})
      : super(key: key);
  final String titleNotice ,contentNotice;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          slivers: <Widget>[
            SliverAppBar(
              stretch: true,
              onStretchTrigger: () {
                // Function callback for stretch
                return Future<void>.value();
              },
              expandedHeight: 200.0,
              flexibleSpace: FlexibleSpaceBar(
                stretchModes: const <StretchMode>[
                  StretchMode.zoomBackground,
                  StretchMode.blurBackground,
                  StretchMode.fadeTitle,
                ],
                background:  Image(
                  image: AssetImage("images/notice_detail.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  return Container(
                    margin: EdgeInsets.all(10),
                    child: ListTile(
                      title: Text(
                        titleNotice,
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      subtitle: Text(
                        contentNotice,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  );
                },
                childCount: 1,
              ),
            ),
            // new showNoticeDetail(),
          ],
        ),
      ),
    );
  }
}