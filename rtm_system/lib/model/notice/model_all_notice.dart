import 'dart:convert';

Notice fromJson(String str) => Notice.fromJson(json.decode(str));

String toJson(Notice data) => json.encode(data.toJson());

class Notice {
  Notice({
    this.noticeList,
    this.total,
  });

  List<NoticeList> noticeList;
  int total;

  factory Notice.fromJson(Map<String, dynamic> json) => Notice(
    noticeList: List<NoticeList>.from(json["noticeList"].map((x) => NoticeList.fromJson(x))),
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "noticeList": List<dynamic>.from(noticeList.map((x) => x.toJson())),
    "total": total,
  };
}

class NoticeList {
  NoticeList({
    this.id,
    this.title,
    this.content,
    this.accountId,
    this.createDate,
  });

  int id;
  String title;
  String content;
  int accountId;
  DateTime createDate;

  factory NoticeList.fromJson(Map<String, dynamic> json) => NoticeList(
    id: json["id"],
    title: json["title"],
    content: json["content"],
    accountId: json["account_id"],
    createDate: DateTime.parse(json["create_date"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "content": content,
    "account_id": accountId,
    "create_date": "${createDate.year.toString().padLeft(4, '0')}-${createDate.month.toString().padLeft(2, '0')}-${createDate.day.toString().padLeft(2, '0')}",
  };
}
