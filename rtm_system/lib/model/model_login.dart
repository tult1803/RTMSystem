class DataLogin {
  final  int accountId, role_id;
  final String access_token;

  DataLogin({this.accountId, this.role_id, this.access_token});

  factory DataLogin.fromJson(Map<String, dynamic> json) {
    return DataLogin(
      accountId: json['accountId'],
      access_token: json['access_token'],
      role_id: json['role_id'],
    );
  }
}