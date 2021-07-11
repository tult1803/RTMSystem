class DataLogin {
  final String accessToken, fullName, accountId;
  int roleId, gender;
  String birthday, phone;

  DataLogin(
      {this.accountId,
      this.roleId,
      this.accessToken,
      this.fullName,
      this.gender,
      this.birthday,
      this.phone});

  factory DataLogin.fromJson(Map<String, dynamic> json) {
    return DataLogin(
      accountId: json['accountId'],
      accessToken: json['access_token'],
      roleId: json['role_id'],
      fullName: json['fullname'],
      phone: json['phone'],
      birthday: json['birthday'],
      gender: json['gender'],
    );
  }
}
