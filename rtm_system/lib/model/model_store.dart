import 'dart:convert';

Store storeFromJson(String str) => Store.fromJson(json.decode(str));

String storeToJson(Store data) => json.encode(data.toJson());

class Store {
  Store({
    this.stores,
    this.total,
  });

  List<StoreElement> stores;
  int total;

  factory Store.fromJson(Map<String, dynamic> json) => Store(
    stores: List<StoreElement>.from(json["stores"].map((x) => StoreElement.fromJson(x))),
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "stores": List<dynamic>.from(stores.map((x) => x.toJson())),
    "total": total,
  };
}

class StoreElement {
  StoreElement({
    this.id,
    this.name,
    this.address,
    this.phone,
    this.email,
    this.statusId,
  });

  String id;
  String name;
  String address;
  String phone;
  String email;
  int statusId;

  factory StoreElement.fromJson(Map<String, dynamic> json) => StoreElement(
    id: json["id"],
    name: json["name"],
    address: json["address"],
    phone: json["phone"],
    email: json["email"],
    statusId: json["status_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "address": address,
    "phone": phone,
    "email": email,
    "status_id": statusId,
  };
}
