
class InvoiceRequest {
  final List invoiceRequests;
  final int total;

  InvoiceRequest({this.invoiceRequests, this.total});

  factory InvoiceRequest.fromJson(Map<String, dynamic> json) {
    return InvoiceRequest(
      invoiceRequests: json["invoiceRequests"],
      total: json["total"],
    );
  }
}
