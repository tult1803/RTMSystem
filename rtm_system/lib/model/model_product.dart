class DataProduct {
  String id;
  String name;
  String description;
  int typeId;
  String typeName;
  int type;
  int productPriceId;
  String updateDateTime;
  int price;

  DataProduct({
    this.id,
    this.name,
    this.description,
    this.typeId,
    this.typeName,
    this.type,
    this.productPriceId,
    this.updateDateTime,
    this.price,
  });

  factory DataProduct.fromJson(Map<String, dynamic> json) {
    return DataProduct(
      id: json["id"],
      name: json["name"],
      description: json["description"],
      typeId: json["type_id"],
      typeName: json["type_name"],
      type: json["type"],
      productPriceId: json["product_price_id"],
      updateDateTime: json["updateDateTime"],
      price: json["update_price"],
    );
  }
}
