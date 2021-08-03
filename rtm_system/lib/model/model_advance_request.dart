class AdvanceRequest {
  AdvanceRequest({
    this.advances,
    this.total,
  });

  List<Advance> advances;
  int total;

  factory AdvanceRequest.fromJson(Map<String, dynamic> json) => AdvanceRequest(
    advances: List<Advance>.from(json["advances"].map((x) => Advance.fromJson(x))),
    total: json["total"],
  );
}

class Advance {
  Advance({
    this.id,
    this.customerId,
    this.customerName,
    this.customerPhone,
    this.storeId,
    this.storeName,
    this.amount,
    this.createDate,
    this.receiveDate,
    this.description,
    this.imageUrl,
    this.statusId,
    this.managerId,
    this.managerName,
    this.processDate,
    this.acceptId,
    this.acceptStatusId,
    this.doneDate,
    this.cancelId,
    this.reason,
  });

  String id;
  String customerId;
  String customerName;
  String customerPhone;
  String storeId;
  String storeName;
  int amount;
  String createDate;
  String receiveDate;
  String description;
  String imageUrl;
  int statusId;
  String managerId;
  String managerName;
  String processDate;
  int acceptId;
  int acceptStatusId;
  String doneDate;
  int cancelId;
  String reason;

  factory Advance.fromJson(Map<String, dynamic> json) => Advance(
    id: json["id"],
    customerId: json["customer_id"],
    customerName: json["customer_name"],
    customerPhone: json["customer_phone"],
    storeId: json["store_id"],
    storeName: json["store_name"],
    amount: json["amount"],
    createDate: json["create_date"],
    receiveDate: json["receive_date"],
    description: json["description"],
    imageUrl: json["image_url"],
    statusId: json["status_id"],
    managerId: json["manager_id"],
    managerName: json["manager_name"],
    processDate: json["process_date"],
    acceptId: json["accept_id"],
    acceptStatusId: json["accept_status_id"],
    doneDate: json["done_date"] == null ? null : json["done_date"],
    cancelId: json["cancel_id"],
    reason: json["reason"],
  );

}
