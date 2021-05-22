import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

// AutoSizeText chữ tự động co giãn theo kích thước mặc định
// Hiện tại dùng cho trang "Product" và "Bill"
//componentCardS là 1 phần bên phải của Card trong trang // E là End
Widget componentCardE(String tittle, String type, CrossAxisAlignment cross, Color color){
  return Padding(
    padding: const EdgeInsets.only(left: 0.0, top: 10),
    child: Column(
      crossAxisAlignment: cross,
      children: [
        AutoSizeText(
          tittle,
          maxLines: 1,
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
        ),
        // Expanded(
        //   child: SizedBox(),
        // ),
        SizedBox(height: 10,),
        AutoSizeText(
          "${type}",
          maxLines: 1,
          style: TextStyle(fontWeight: FontWeight.w200, fontSize: 15, color: color,),
        ),
      ],
    ),
  );
}

// Hiện tại dùng cho trang "Product" và "Bill"
//componentCardS là 1 phần bên trái của Card trong trang // S là Start
Widget componentCardS(String tittle, String type, String detailType, CrossAxisAlignment cross, Color color){
  return Padding(
    padding: const EdgeInsets.only(left: 0.0, top: 10),
    child: Column(
      crossAxisAlignment: cross,
      children: [
        AutoSizeText(
          tittle,
          maxLines: 1,
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
        ),
        // Expanded(
        //   child: SizedBox(),
        // ),
        SizedBox(height: 10,),
        Row(
          children: [
            AutoSizeText(
              "$type: ",
              maxLines: 1,
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15, color: Colors.black54,),
            ),
            AutoSizeText(
              "${detailType}",
              maxLines: 1,
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15, color: color,),
            ),
          ],
        ),
      ],
    ),
  );
}

// Hiện tại dùng cho trang "Profile"
Widget txtFullNameProfile(String tittle) {
  return Container(
      margin: EdgeInsets.only(left: 10),
      child: Text(
        tittle,
        style: TextStyle(fontSize: 23),
      ));
}

// Hiện tại dùng cho trang "Profile"
Widget txtCanClick(BuildContext context, Widget widget, String tittle) {
  return Container(
    margin: EdgeInsets.only(left: 10),
    child: GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
      },
      child: Row(
        children: [
          Text(
            tittle,
            style: TextStyle(fontSize: 15, color: Colors.black54),
          ),
          Icon(Icons.arrow_forward_ios_outlined, size: 13, color: Colors.black54,),
        ],
      ),
    ),
  );
}
