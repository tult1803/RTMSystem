class Customer{
  final List customerList;
  final int total;

  Customer({this.customerList, this.total});

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      customerList: json["customerList"],
      total: json["total"],
    );
  }
}