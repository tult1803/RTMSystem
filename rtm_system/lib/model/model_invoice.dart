import 'dart:convert';

Invoice invoiceFromJson(String str) => Invoice.fromJson(json.decode(str));

String invoiceToJson(Invoice data) => json.encode(data.toJson());

class Invoice {
  Invoice({
    this.invoices,
    this.total,
  });

  List<InvoiceElement> invoices;
  int total;

  factory Invoice.fromJson(Map<String, dynamic> json) => Invoice(
    invoices: List<InvoiceElement>.from(json["invoices"].map((x) => InvoiceElement.fromJson(x))),
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "invoices": List<dynamic>.from(invoices.map((x) => x.toJson())),
    "total": total,
  };
}

class InvoiceElement {
  InvoiceElement({
    this.id,
    this.customerId,
    this.customerName,
    this.customerPhone,
    this.managerId,
    this.managerName,
    this.managerPhone,
    this.createTime,
    this.storeId,
    this.storeName,
    this.storeAddress,
    this.productId,
    this.productName,
    this.description,
    this.price,
    this.quantity,
    this.degree,
    this.activeDate,
    this.managerSignDate,
    this.customerSignDate,
    this.statusId,
  });

  String id;
  String customerId;
  String customerName;
  String customerPhone;
  String managerId;
  String managerName;
  String managerPhone;
  String createTime;
  String storeId;
  String storeName;
  String storeAddress;
  String productId;
  String productName;
  String description;
  int price;
  double quantity;
  double degree;
  String activeDate;
  String managerSignDate;
  String customerSignDate;
  int statusId;

  factory InvoiceElement.fromJson(Map<String, dynamic> json) => InvoiceElement(
    id: json["id"],
    customerId: json["customer_id"],
    customerName: json["customer_name"],
    customerPhone: json["customer_phone"],
    managerId: json["manager_id"],
    managerName: json["manager_name"],
    managerPhone: json["manager_phone"],
    createTime: json["create_time"],
    storeId: json["store_id"],
    storeName: json["store_name"],
    storeAddress: json["store_address"],
    productId: json["product_id"],
    productName: json["product_name"],
    description: json["description"],
    price: json["price"],
    quantity: json["quantity"],
    degree: json["degree"],
    activeDate: json["active_date"],
    managerSignDate: json["manager_sign_date"],
    customerSignDate: json["customer_sign_date"],
    statusId: json["status_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "customer_id": customerId,
    "customer_name": customerName,
    "customer_phone": customerPhone,
    "manager_id": managerId,
    "manager_name": managerName,
    "manager_phone": managerPhone,
    "create_time": createTime,
    "store_id": storeId,
    "store_name": storeName,
    "store_address": storeAddress,
    "product_id": productId,
    "product_name": productName,
    "description": description,
    "price": price,
    "quantity": quantity,
    "degree": degree,
    "active_date": activeDate,
    "manager_sign_date": managerSignDate,
    "customer_sign_date": customerSignDate,
    "status_id": statusId,
  };
}
