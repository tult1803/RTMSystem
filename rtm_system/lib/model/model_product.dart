class DataProduct{
  final int id;
  final String name, description, type, date_time, price;

  DataProduct({this.id, this.name, this.description, this.type, this.date_time, this.price});

factory DataProduct.fromJson(Map<String, dynamic> json) {
    return DataProduct(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      type: json['type'],
      date_time: json['updateDateTime'],
      price: "${json['update_price']}",
    );
  }
}
