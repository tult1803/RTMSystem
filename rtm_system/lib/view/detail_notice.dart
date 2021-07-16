import 'package:flutter/material.dart';
import 'package:rtm_system/helpers/common_widget.dart';
import 'package:rtm_system/helpers/component.dart';
import 'package:shared_preferences/shared_preferences.dart';



class DetailOfNotice extends StatefulWidget {
  final String titleNotice ,contentNotice;
  final String noticeId;
  // true is Customer. Used to hide the button  in page of manager.
  final bool isCustomer;


  DetailOfNotice({this.titleNotice, this.contentNotice, this.noticeId, this.isCustomer});

  @override
  _DetailOfNoticeState createState() => _DetailOfNoticeState();
}

String token;
class _DetailOfNoticeState extends State<DetailOfNotice> {

  Future _getToken() async {
    SharedPreferences prefs =  await SharedPreferences.getInstance();
    setState(() {
      token = prefs.get("access_token");
    });
  }

  @override
  void initState() {
    super.initState();
    _getToken();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            CustomScrollView(
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              slivers: <Widget>[
                SliverAppBar(
                  leading: leadingAppbar(context),
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
                            this.widget.titleNotice,
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          subtitle: Text(
                            this.widget.contentNotice,
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
              ],
            ),
            if(!widget.isCustomer)
            Padding(
              padding: const EdgeInsets.only(bottom: 30.0),
              child: btnDeactivateCustomer(
                  token: "$token",
                  context: context,
                  status: "1",
                  isDeactivateNotice: true,
                  deactivateId:  this.widget.noticeId),
            ),
          ],
        ),
      ),
    );
  }
}