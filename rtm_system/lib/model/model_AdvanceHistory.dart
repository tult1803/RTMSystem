class AdvanceHistory {
  AdvanceHistory({
    this.id,
    this.customerId,
    this.amount,
    this.datetime,
    this.returnCash,
    this.advance,
  });

  String id;
  String customerId;
  int amount;
  String datetime;
  int returnCash;
  bool advance;

  factory AdvanceHistory.fromJson(Map<String, dynamic> json) => AdvanceHistory(
    id: json["id"],
    customerId: json["customer_id"],
    amount: json["amount"],
    datetime: json["datetime"],
    returnCash: json["return_cash"],
    advance: json["_advance"],
  );
}
