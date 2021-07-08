class InfomationCustomer {
  int id;
  String cmnd;
  int level;
  int statusId;
  String accountId;
  int advance;
  String fullname;
  int gender;
  String phone;
  DateTime birthday;
  String address;

  InfomationCustomer({
    this.id,
    this.cmnd,
    this.level,
    this.statusId,
    this.accountId,
    this.advance,
    this.fullname,
    this.gender,
    this.phone,
    this.birthday,
    this.address,
  });

  factory InfomationCustomer.fromJson(Map<String, dynamic> json) {
    return InfomationCustomer(
      id: json["id"],
      cmnd: json["cmnd"],
      level: json["level"],
      statusId: json["status_id"],
      accountId: json["account_id"],
      advance: json["advance"],
      fullname: json["fullname"],
      gender: json["gender"],
      phone: json["phone"],
      birthday: DateTime.parse(json["birthday"]),
      address: json["address"],
    );

  }
}
