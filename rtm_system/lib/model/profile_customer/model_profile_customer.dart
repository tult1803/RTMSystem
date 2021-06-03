class InfomationCustomer {
  int id;
  String cmnd;
  bool vip;
  int statusId;
  int accountId;
  int advance;
  String fullname;
  int gender;
  String phone;
  DateTime birthday;
  String address;

  InfomationCustomer({
    this.id,
    this.cmnd,
    this.vip,
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
      vip: json["vip"],
      statusId: json["status_id"],
      accountId: json["account_id"],
      advance: json["advance"],
      fullname: json["fullname"],
      gender: json["gender"],
      phone: json["phone"],
      birthday: DateTime.parse(json["birthday"]),
      address: json["address"],
    );

    // Map<String, dynamic> toJson() => {
    //   "id": id,
    //   "cmnd": cmnd,
    //   "vip": vip,
    //   "status_id": statusId,
    //   "account_id": accountId,
    //   "advance": advance,
    //   "fullname": fullname,
    //   "gender": gender,
    //   "phone": phone,
    //   "birthday": "${birthday.year.toString().padLeft(4, '0')}-${birthday.month.toString().padLeft(2, '0')}-${birthday.day.toString().padLeft(2, '0')}",
    //   "address": address,
    // };
  }
}
