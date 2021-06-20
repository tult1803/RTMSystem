class DataLogin {
  final String access_token, fullname, accountId;
  int role_id, gender;
  String birthday, phone;

  DataLogin(
      {this.accountId,
      this.role_id,
      this.access_token,
      this.fullname,
      this.gender,
      this.birthday,
      this.phone});

  factory DataLogin.fromJson(Map<String, dynamic> json) {
    return DataLogin(
      accountId: json['accountId'],
      access_token: json['access_token'],
      role_id: json['role_id'],
      fullname: json['fullname'],
      phone: json['phone'],
      birthday: json['birthday'],
      gender: json['gender'],
    );
  }
}
