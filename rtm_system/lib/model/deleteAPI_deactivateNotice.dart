import 'package:rtm_system/ultils/src/url_api.dart';
import 'package:http/http.dart' as http;

//Type = 0 là update Password, != 0 là updata dữ liệu khác
//CMND mà trống là update manager, ngược lại là update Customer
class DeleteDeactivateNotice{

  deactivateNotice(String token, String noticeId ) async {
    final response = await http.delete(
      Uri.http('${urlMain}', '${urlDeactivateNotice}/$noticeId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );
    print("Status deleteAPI Deactivate Notice:${response.statusCode}");
    return response.statusCode;
  }

}
