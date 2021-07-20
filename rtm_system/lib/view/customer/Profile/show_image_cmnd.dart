import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rtm_system/helpers/component.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';

// ignore: must_be_immutable
class ImageCMND extends StatefulWidget {
  String imageFCMND, imageBCMND;

  ImageCMND({this.imageFCMND, this.imageBCMND});

  @override
  _ImageCMNDState createState() => _ImageCMNDState();
}

class _ImageCMNDState extends State<ImageCMND> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        leading: leadingAppbar(context, colorIcon: Colors.white),
        backgroundColor: primaryColor,
        centerTitle: true,
        title: titleAppBar("Thông tin cá nhân"),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                child: Image.network(widget.imageFCMND),
              ),
              Container(
                child: Image.network(widget.imageBCMND),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

