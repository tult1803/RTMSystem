// class DataAllInvoice {
//   final int id, customer_id, creater_id, total, manager_confirm_id, status_id;
//   final String customer_name, manager_confirm_name;
//   final String creater_name, description;
//   final DateTime create_time, manager_confirm_date, customer_confirm_date;
//
//   DataAllInvoice(
//     this.id,
//     this.customer_id,
//     this.customer_name,
//     this.creater_id,
//     this.creater_name,
//     this.create_time,
//     this.total,
//     this.description,
//     this.manager_confirm_id,
//     this.manager_confirm_name,
//     this.manager_confirm_date,
//     this.customer_confirm_date,
//     this.status_id,
//   );
//
//   DataAllInvoice.fromJson(Map<String, dynamic> json)
//       : id = json["id"],
//         customer_id = json["customer_id"],
//         customer_name = json["customer_name"],
//         creater_id = json["creater_id"],
//         creater_name = json["creater_name"],
//         create_time = DateTime.parse(json["create_time"]),
//         total = json["total"],
//         description = json["description"],
//         manager_confirm_id = json["manager_confirm_id"],
//         manager_confirm_name = json["manager_confirm_name"],
//         manager_confirm_date = DateTime.parse(json["manager_confirm_date"]),
//         customer_confirm_date = DateTime.parse(json["customer_confirm_date"]),
//         status_id = json["status_id"];
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "customer_id": customer_id,
//         "customer_name": customer_name,
//         "creater_id": creater_id,
//         "creater_name": creater_name,
//         "create_time": create_time,
//         "total": total,
//         "description": description,
//         "manager_confirm_id": manager_confirm_id,
//         "manager_confirm_name": manager_confirm_name,
//         "manager_confirm_date": manager_confirm_date,
//         "customer_confirm_date": customer_confirm_date,
//         "status_id": status_id,
//       };
// }
