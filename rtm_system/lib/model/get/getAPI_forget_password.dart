import 'package:rtm_system/ultils/src/url_api.dart';
import 'package:http/http.dart' as http;

class ChangeForgotPassword{
  getPassword(String fbToken, String password, String confirmPassword) async {
    final response = await http.get(
      Uri.http('$urlMain', '$urlForgetPassword', {'password': password, 'confirmPassword': confirmPassword, 'firebaseToken':fbToken}),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },
    );
    print("Status getApi Forget Password:${response.statusCode}");
    return response.statusCode;
  }
}
