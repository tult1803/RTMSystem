import 'dart:convert';

Customer customerFromJson(String str) => Customer.fromJson(json.decode(str));

String customerToJson(Customer data) => json.encode(data.toJson());

class Customer {
  Customer({
    this.customerList,
    this.total,
  });

  List<CustomerList> customerList;
  int total;

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
    customerList: List<CustomerList>.from(json["customerList"].map((x) => CustomerList.fromJson(x))),
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "customerList": List<dynamic>.from(customerList.map((x) => x.toJson())),
    "total": total,
  };
}

class CustomerList {
  CustomerList({
    this.id,
    this.cmnd,
    this.level,
    this.statusId,
    this.accountId,
    this.advance,
    this.fullName,
    this.gender,
    this.phone,
    this.birthday,
    this.address,
    this.cmndFront,
    this.cmndBack,
    this.needConfirm,
  });

  int id;
  String cmnd;
  int level;
  int statusId;
  String accountId;
  int advance;
  String fullName;
  int gender;
  String phone;
  String birthday;
  String address;
  String cmndFront;
  String cmndBack;
  bool needConfirm;


  factory CustomerList.fromJson(Map<String, dynamic> json) => CustomerList(
    id: json["id"],
    cmnd: json["cmnd"],
    level: json["level"],
    statusId: json["status_id"],
    accountId: json["account_id"],
    advance: json["advance"],
    fullName: json["fullname"],
    gender: json["gender"],
    phone: json["phone"],
    birthday: json["birthday"],
    address: json["address"],
    cmndFront: json["cmndFront"],
    cmndBack: json["cmndBack"],
    needConfirm: json["need_confirm"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "cmnd": cmnd,
    "level": level,
    "status_id": statusId,
    "account_id": accountId,
    "advance": advance,
    "fullname": fullName,
    "gender": gender,
    "phone": phone,
    "birthday": birthday,
    "address": address,
    "cmndFront": cmndFront,
    "cmndBack": cmndBack,
    "need_confirm": needConfirm,
  };
}
