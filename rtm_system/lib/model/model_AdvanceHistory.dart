class AdvanceHistory {
  AdvanceHistory({
    this.id,
    this.customerId,
    this.amount,
    this.returnCash,
    this.advance,
    // this.datetime,
  });

  String id;
  String customerId;
  int amount;
  int returnCash;
  bool advance;
  // String datetime;

  factory AdvanceHistory.fromJson(Map<String, dynamic> json) => AdvanceHistory(
    id: json["id"],
    customerId: json["customer_id"],
    amount: json["amount"],
    // datetime: json["datetime"], cái có cái k nên cái này lỗi
    returnCash: json["return_cash"],
    advance: json["_advance"],
  );
}
