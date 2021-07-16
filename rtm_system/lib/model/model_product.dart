class DataProduct {
  final int type_id, product_price_id;
  final String id, name, description, type, date_time, price;

  DataProduct(
      {this.id,
      this.name,
      this.description,
      this.type,
      this.date_time,
      this.price,
      this.product_price_id,
      this.type_id});

  factory DataProduct.fromJson(Map<String, dynamic> json) {
    return DataProduct(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      type: json['type'],
      date_time: json['updateDateTime'],
      price: "${json['update_price']}",
      type_id: json['type_id'],
      product_price_id: json['product_price_id'],
    );
  }
}
