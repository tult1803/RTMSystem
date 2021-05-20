import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class DetailOfNotice extends StatelessWidget {
  const DetailOfNotice({Key key,  this.titleNotice, this.contentNotice})
      : super(key: key);
  final String titleNotice ,contentNotice;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        slivers: <Widget>[
          SliverAppBar(
            stretch: true,
            onStretchTrigger: () {
              // Function callback for stretch
              return Future<void>.value();
            },
            expandedHeight: 145.0,
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: const <StretchMode>[
                StretchMode.zoomBackground,
                StretchMode.blurBackground,
                StretchMode.fadeTitle,
              ],
              background: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  Image(
                    image: AssetImage("images/notice_detail.png"),
                  ),
                ],
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
    );
  }
}

//
// class DetailOfNotice extends StatefulWidget {
//   const DetailOfNotice({Key key, this.titleNotice, this.contentNotice}) : super(key: key);
//   final String title = "Thông báo";
//
//   final String titleNotice, contentNotice;
//
//   @override
//   _DetailOfNoticeState createState() => _DetailOfNoticeState();
// }
//
// class _DetailOfNoticeState extends State<DetailOfNotice> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: CustomScrollView(
//         physics: const BouncingScrollPhysics(
//             parent: AlwaysScrollableScrollPhysics()),
//         slivers: <Widget>[
//           SliverAppBar(
//             stretch: true,
//             onStretchTrigger: () {
//               // Function callback for stretch
//               return Future<void>.value();
//             },
//             expandedHeight: 145.0,
//             flexibleSpace: FlexibleSpaceBar(
//               stretchModes: const <StretchMode>[
//                 StretchMode.zoomBackground,
//                 StretchMode.blurBackground,
//                 StretchMode.fadeTitle,
//               ],
//
//               background: Stack(
//                 fit: StackFit.expand,
//                 children: <Widget>[
//                   Image(image: AssetImage("images/notice_detail.png"), ),
//                   const DecoratedBox(
//                     decoration: BoxDecoration(
//                       gradient: LinearGradient(
//                         begin: Alignment(0.0, 0.5),
//                         end: Alignment.center,
//                         colors: <Color>[
//                           Color(0xFF0BB791),
//                           // Color(0xFF000),
//                         ],
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ),
//           Container(
//             margin: EdgeInsets.all(5),
//             height: 96,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   children: [
//                     Text(
//                       "s",
//                       style: TextStyle(
//                         fontWeight: FontWeight.w500,
//                       ),
//                       overflow: TextOverflow.ellipsis,
//                       textAlign: TextAlign.left,
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//
//                             SizedBox(
//               child: Text(
//                 "$content",
//                 style: TextStyle(
//                   fontSize: 14,
//                 ),
//                 textAlign: TextAlign.left,
//                 overflow: TextOverflow.ellipsis,
//               ),
//             ),
//
//               ],
//             ),)
//           // new showNoticeDetail(),
//         ],
//
//       ),
//     );
//   }
// }
