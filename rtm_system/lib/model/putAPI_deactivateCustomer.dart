import 'package:rtm_system/ultils/src/url_api.dart';
import 'package:http/http.dart' as http;

//Type = 0 là update Password, != 0 là updata dữ liệu khác
//CMND mà trống là update manager, ngược lại là update Customer
class PutDeactivateCustomer{

  deactivateCustomer(String token, String accountId) async {
    final response = await http.put(
      Uri.http('${url_main}', '${url_deactivateCustomer}/$accountId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );
    print("Status putAPI Deactivate Customer:${response.statusCode}");
    return response.statusCode;
  }

}
