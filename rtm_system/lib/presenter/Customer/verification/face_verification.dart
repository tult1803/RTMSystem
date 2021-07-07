import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:rtm_system/helpers/component.dart';
import 'package:rtm_system/ultils/get_api_data.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';

import 'front_identity_card.dart';

class FaceIdentifyCard extends StatefulWidget {
  @override
  _FaceIdentifyCardState createState() => _FaceIdentifyCardState();
}

class _FaceIdentifyCardState extends State<FaceIdentifyCard> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: leadingAppbar(context,colorIcon: Colors.white),
        centerTitle: true,
        title: const Text('Xác thực thông tin', style: TextStyle( color: Colors.white),),),
      body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                tittleBody(),
                showImage(size.width, size.height, imageFace),
                btnImage(context, size.width * 0.9, size.height * 0.1),
                nextPage(imageFace),
              ],
            ),
          )),
    );
  }

  Widget tittleBody() {
    return Container(
        margin: EdgeInsets.only(top: 10),
        child: Text(
          "Chụp ảnh khuôn mặt của bạn",
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
        child: Center(
          child: Container(
            height: 150,
            child: Image.asset(
              "images/face_scan.png",
              fit: BoxFit.scaleDown,
            ),
          ),
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
    Uint8List byteFront, byteFace, byteBack;
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
            onPressed: () async{
               // byteFront = imageFront.readAsBytesSync();
               // byteFace = imageFace.readAsBytesSync();
               // byteBack =imageBack.readAsBytesSync();
                    doValidateCustomer(cmndFrontBase64: imageFront, cmndBackBase64: imageBack, faceBase64: imageFace);
                  },
            child: Text("Xác thực", style: GoogleFonts.roboto(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 17),)
            // child: Icon(Icons.arrow_forward, ),
          )),
    );
  }

//get image from camera
  _imageFromCamera() async {
    PickedFile image = await ImagePicker()
        .getImage(source: ImageSource.camera, imageQuality: 50);
    if (image != null) {
      setState(() {
        imageFace = File(image.path);
      });
    }
  }

//get image from gallery
  _imageFromGallery() async {
    PickedFile image = await ImagePicker()
        .getImage(source: ImageSource.gallery, imageQuality: 50);
    if (image != null) {
      setState(() {
        imageFace = File(image.path);
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
