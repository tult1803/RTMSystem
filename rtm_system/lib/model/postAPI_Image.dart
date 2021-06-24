import 'package:dio/dio.dart';

class ImageService{
  uploadFile(authToken, userId, filePath) async {
    try {
      FormData formData =
      new FormData.fromMap({
        "image":
        await MultipartFile.fromFile(filePath, filename: "dp")});

      Response response =
      await Dio().put(
          "https://appointella-api.herokuapp.com/customer/$userId",
          data: formData,
          options: Options(
              headers: <String, String>{
                'Authorization': 'Bearer $authToken',
              }
          )
      );
      return response;
    }on DioError catch (e) {
      return e.response;
    } catch(e){
    }
  }
}