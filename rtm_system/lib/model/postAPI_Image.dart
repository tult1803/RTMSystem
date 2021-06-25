import 'dart:io';
import 'package:dio/dio.dart';

class ImageService{
  uploadFile(token, userId, File file) async {
    String filePath = file.path;
    String fileName = file.path.split('/').last;
    try {
      FormData formData =
      new FormData.fromMap({
        "image": await MultipartFile.fromFile(filePath, filename: fileName,)});
      Response response =
      await Dio().post(
          "https://appointella-api.herokuapp.com/customer/$userId",
          data: formData,
          options: Options(
            headers: <String, String>{
              'Content-Type': 'multipart/form-data; charset=UTF-8',
              'Authorization': 'Bearer $token',
            },
          ),
      );
      return response;
      // var url = '${API_URL}ocr';
      // var bytes = image.readAsBytesSync();
      //
      // var response = await http.post(
      //     url,
      //     headers:{ "Content-Type":"multipart/form-data" } ,
      //     body: { "lang":"fas" , "image":bytes},
      //     encoding: Encoding.getByName("utf-8")
      // );
      //
      // return response.body;
    }on DioError catch (e) {
      return e.response;
    } catch(e){
    }
  }
}