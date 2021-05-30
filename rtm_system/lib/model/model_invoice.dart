class DataInvoice {
  final int id, customer_id, status_id, total, creater_id;
  final String description, create_time, customer_name, creater_name;
  final bool manager_confirm, customer_confirm;

  DataInvoice({
    this.id,
    this.customer_id,
    this.creater_id,
    this.creater_name,
    this.status_id,
    this.customer_name,
    this.description,
    this.create_time,
    this.total,
    this.manager_confirm,
    this.customer_confirm});

  factory DataInvoice.fromJson(Map<String, dynamic> json) {
    return DataInvoice(
      id: json['id'],
      customer_id: json['customer_id'],
      customer_name: json['customer_name'],
      creater_id: json['creater_id'],
      creater_name: json['creater_name'],
      status_id: json['status_id'],
      description: json['description'],
      create_time: json['create_time'],
      total: json['total'],
      manager_confirm: json['manager_confirm'],
      customer_confirm: json['customer_confirm'],
    );
  }
}
