class InvoiceList {


  int id, customer_id,creater_id, total, manager_confirm_id, status_id;
  String customer_name, manager_confirm_name;
  String creater_name, description;
  DateTime create_time, manager_confirm_date, customer_confirm_date;


  InvoiceList(
      {this.id,
      this.customer_id,
      this.creater_id,
      this.total,
      this.manager_confirm_id,
      this.status_id,
      this.customer_name,
      this.manager_confirm_name,
      this.creater_name,
      this.description,
      this.create_time,
      this.manager_confirm_date,
      this.customer_confirm_date});

  factory InvoiceList.fromJson(Map<String, dynamic> json) => InvoiceList(
    id: json["id"],
    customer_id: json["customer_id"],
    creater_id: json["creater_id"],
    total: json["total"],
    manager_confirm_id: json["manager_confirm_id"],
    status_id: json["status_id"],
    customer_name: json["customer_name"],
    manager_confirm_name: json["manager_confirm_name"],
    creater_name: json["creater_name"],
    description: json["description"],
    create_time: DateTime.parse(json["create_time"]),
    manager_confirm_date: DateTime.parse(json["manager_confirm_date"]),
    customer_confirm_date: DateTime.parse(json["customer_confirm_date"]),
  );

}
