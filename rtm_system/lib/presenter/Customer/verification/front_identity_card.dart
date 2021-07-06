import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:rtm_system/presenter/Customer/verification/back_identity_card.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';

class FrontIdentifyCard extends StatefulWidget {
  @override
  _FrontIdentifyCardState createState() => _FrontIdentifyCardState();
}

File imageBack;
File imageFront;
File imageFace;
class _FrontIdentifyCardState extends State<FrontIdentifyCard> {

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            tittleBody(),
            showImage(size.width, size.height, imageFront),
            btnImage(context, size.width * 0.9, size.height * 0.1),
            nextPage(imageFront),
          ],
        ),
      ),
    );
  }

  Widget tittleBody() {
    return Container(
        margin: EdgeInsets.only(top: 10),
        child: Text(
          "Chụp ảnh mặt trước CMND/CCCD",
          style: GoogleFonts.roboto(fontSize: 17, fontWeight: FontWeight.w500),
        ));
  }

  Widget showImage(width, height, image) {
    if (image != null) {
      return Container(
        margin: EdgeInsets.all(20),
        width: width,
        height: 300,
        child: Image.file(image, fit: BoxFit.fill),
      );
    } else {
      return Container(
        margin: EdgeInsets.all(20),
        width: width,
        height: 300,
        color: Colors.white,
        child: Image.asset(
          "images/cmnd_front.png",
          fit: BoxFit.scaleDown,
        ),
      );
    }
  }

  Widget btnImage(context, width, height) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      width: 250,
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          showPicker(context);
        },
        child: Center(
          child: Icon(
            Icons.camera_alt,
            color: Colors.black,
          ),
        ),
        style: ElevatedButton.styleFrom(
          primary: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            side: BorderSide(color: Color(0xFFcccccc), width: 1),
          ),
        ),
      ),
    );
  }
  Widget nextPage(image) {
    return Container(
      child: image == null
          ? null
          : Container(
              width: 120,
              height: 40,
              margin: EdgeInsets.only(top: 20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 3,
                  primary: welcome_color,
                ),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  BackIdentifyCard()));
                },
                // child: Text("Tiếp tục", style: GoogleFonts.roboto(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 17),)
                child: Icon(Icons.arrow_forward, ),
              )),
    );
  }

//get image from camera
  _imageFromCamera() async {
    PickedFile image = await ImagePicker()
        .getImage(source: ImageSource.camera, imageQuality: 50);
    if (image != null) {
      setState(() {
        imageFront = File(image.path);
      });
    }
  }

//get image from gallery
  _imageFromGallery() async {
    PickedFile image = await ImagePicker()
        .getImage(source: ImageSource.gallery, imageQuality: 50);
    if (image != null) {
      setState(() {
        imageFront = File(image.path);
      });
    }
  }

// show option choice camera or gallery
  void showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
              child: Wrap(
            children: [
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Chọn ảnh trong thư viện'),
                onTap: () {
                  _imageFromGallery();
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('Mở camera'),
                onTap: () {
                  _imageFromCamera();
                  Navigator.of(context).pop();
                },
              )
            ],
          ));
        });
  }
}
