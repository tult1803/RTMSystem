
class AdvanceRequest {
  final List advances;
  final int total;

  AdvanceRequest({this.advances, this.total});

  factory AdvanceRequest.fromJson(Map<String, dynamic> json) {
    return AdvanceRequest(
      advances: json["advances"],
      total: json["total"],
    );
  }
}
