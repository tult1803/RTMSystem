import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MaintainPage extends StatefulWidget {
  const MaintainPage({Key key}) : super(key: key);

  @override
  _MaintainPageState createState() => _MaintainPageState();
}

class _MaintainPageState extends State<MaintainPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
          width: 200,
            height: 200,
            child: Image.asset("images/maintain.png"),
          ),
          Container(
              margin: EdgeInsets.only(top: 20),
              child: Text("Hệ thống đang bảo trì", style: GoogleFonts.roboto(fontSize: 25, color: Colors.black87),)),
          Container(
              margin: EdgeInsets.only(top: 10),
              child: Text("Vui lòng truy cập lại sau", style: GoogleFonts.roboto(fontSize: 20, color: Colors.black54))),
        ],
    );
  }
}
