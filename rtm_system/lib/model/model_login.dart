class DataLogin {
  final  int accountId;
  final String access_token, fullname;
  List<int> roles;
  int gender;
  String birthday, phone;

  DataLogin({this.accountId, this.roles, this.access_token, this.fullname, this.gender, this.birthday, this.phone});

  factory DataLogin.fromJson(Map<String, dynamic> json) {
    return DataLogin(
      accountId: json['accountId'],
      access_token: json['access_token'],
      roles: List<int>.from(json["roles"].map((x) => x)),
      // role_id: json['role_id'],
      fullname: json['fullname'],
      phone: json['phone'],
      birthday: json['birthday'],
      gender: json['gender'],
    );
  }
}