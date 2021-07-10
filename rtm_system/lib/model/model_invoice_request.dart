import 'dart:convert';

InvoiceRequest invoiceRequestFromJson(String str) => InvoiceRequest.fromJson(json.decode(str));

String invoiceRequestToJson(InvoiceRequest data) => json.encode(data.toJson());

class InvoiceRequest {
  InvoiceRequest({
    this.invoiceRequests,
    this.total,
  });

  List<InvoiceRequestElement> invoiceRequests;
  int total;

  factory InvoiceRequest.fromJson(Map<String, dynamic> json) => InvoiceRequest(
    invoiceRequests: List<InvoiceRequestElement>.from(json["invoiceRequests"].map((x) => InvoiceRequestElement.fromJson(x))),
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "invoiceRequests": List<dynamic>.from(invoiceRequests.map((x) => x.toJson())),
    "total": total,
  };
}

class InvoiceRequestElement {
  InvoiceRequestElement({
    this.id,
    this.customerId,
    this.customerName,
    this.customerPhone,
    this.storeId,
    this.storeName,
    this.storeAddress,
    this.productPriceId,
    this.price,
    this.productId,
    this.productName,
    this.createDate,
    this.sellDate,
    this.statusId,
  });

  String id;
  String customerId;
  String customerName;
  String customerPhone;
  String storeId;
  String storeName;
  String storeAddress;
  int productPriceId;
  int price;
  String productId;
  String productName;
  String createDate;
  String sellDate;
  int statusId;

  factory InvoiceRequestElement.fromJson(Map<String, dynamic> json) => InvoiceRequestElement(
    id: json["id"],
    customerId: json["customer_id"],
    customerName: json["customer_name"],
    customerPhone: json["customer_phone"],
    storeId: json["store_id"],
    storeName: json["store_name"],
    storeAddress: json["store_address"],
    productPriceId: json["product_price_id"],
    price: json["price"],
    productId: json["product_id"],
    productName: json["product_name"],
    createDate: json["create_date"],
    sellDate: json["sell_date"],
    statusId: json["status_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "customer_id": customerId,
    "customer_name": customerName,
    "customer_phone": customerPhone,
    "store_id": storeId,
    "store_name": storeName,
    "store_address": storeAddress,
    "product_price_id": productPriceId,
    "price": price,
    "product_id": productId,
    "product_name": productName,
    "create_date": createDate,
    "sell_date": sellDate,
    "status_id": statusId,
  };
}
