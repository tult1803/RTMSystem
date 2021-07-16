class AdvanceReturnDetail {
  AdvanceReturnDetail({
    this.id,
    this.createDate,
    this.customerId,
    this.customerName,
    this.returnCash,
    this.total,
    this.invoices,
    this.advances,
  });

  String id;
  String createDate;
  String customerId;
  String customerName;
  int returnCash;
  int total;
  List<InvoiceInAdvanceReturn> invoices;
  List<AdvanceInAdvanceReturn> advances;
  factory AdvanceReturnDetail.fromJson(Map<String, dynamic> json) =>
      AdvanceReturnDetail(
        id: json["id"],
        createDate: json["create_date"],
        customerId: json["customer_id"],
        customerName: json["customer_name"],
        returnCash: json["return_cash"],
        total: json["total"],
        invoices: List<InvoiceInAdvanceReturn>.from(
            json["invoices"].map((x) => InvoiceInAdvanceReturn.fromJson(x))),
        advances: List<AdvanceInAdvanceReturn>.from(
            json["advances"].map((x) => AdvanceInAdvanceReturn.fromJson(x))),
      );
}

class AdvanceInAdvanceReturn {
  AdvanceInAdvanceReturn({
    this.id,
    this.amount,
    this.createDate,
    this.statusId,
    this.managerId,
    this.managerName,
    this.doneDate,
  });

  String id;
  int amount;
  String createDate;
  int statusId;
  String managerId;
  String managerName;
  String doneDate;

  factory AdvanceInAdvanceReturn.fromJson(Map<String, dynamic> json) =>
      AdvanceInAdvanceReturn(
        id: json["id"],
        amount: json["amount"],
        createDate:json["create_date"],
        statusId: json["status_id"],
        managerId: json["manager_id"],
        managerName: json["manager_name"],
        doneDate: json["done_date"],
      );
}

class InvoiceInAdvanceReturn {
  InvoiceInAdvanceReturn({
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
  String customerSignDate;
  int statusId;

  factory InvoiceInAdvanceReturn.fromJson(Map<String, dynamic> json) =>
      InvoiceInAdvanceReturn(
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
        customerSignDate: json["customer_sign_date"],
        statusId: json["status_id"],
      );
}
