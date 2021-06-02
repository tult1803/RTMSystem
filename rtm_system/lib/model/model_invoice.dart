
class Invoice {
  final List invoices;
  final int total;

  Invoice({this.invoices, this.total});

  factory Invoice.fromJson(Map<String, dynamic> json) {
    return Invoice(
      invoices: json["invoices"],
      total: json["total"],
    );
  }
}
