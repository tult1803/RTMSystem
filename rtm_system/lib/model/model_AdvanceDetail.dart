
class AdvanceDetail {
  AdvanceDetail({
    this.id,
    this.customerId,
    this.customerName,
    this.amount,
    this.createDate,
    this.receiveDate,
    this.description,
    this.statusId,
    this.managerId,
    this.managerName,
    this.processDate,
    this.acceptStatusId,
  });

  String id;
  String customerId;
  String customerName;
  int amount;
  String createDate;
  String receiveDate;
  String description;
  int statusId;
  String managerId;
  String managerName;
  String processDate;
  int acceptStatusId;
  //nen can co cho status 6
  String reason;

  factory AdvanceDetail.fromJson(Map<String, dynamic> json) => AdvanceDetail(
    id: json["id"],
    customerId: json["customer_id"],
    customerName: json["customer_name"],
    amount: json["amount"],
    createDate: json["create_date"],
    receiveDate: json["receive_date"],
    description: json["description"],
    statusId: json["status_id"],
    managerId: json["manager_id"],
    managerName: json["manager_name"],
    processDate: json["process_date"],
    acceptStatusId: json["accept_status_id"],
  );

}
