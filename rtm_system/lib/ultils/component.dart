import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

// AutoSizeText chữ tự động co giãn theo kích thước mặc định
Widget componentCard(String tittle, String type, CrossAxisAlignment cross){
  return Padding(
    padding: const EdgeInsets.only(left: 10.0, top: 10, bottom: 10),
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
          style: TextStyle(fontWeight: FontWeight.w300, fontSize: 18),
        ),
      ],
    ),
  );
}