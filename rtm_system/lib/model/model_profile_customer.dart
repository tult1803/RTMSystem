class InfomationCustomer {
    InfomationCustomer({
        this.id,
        this.cmnd,
        this.level,
        this.statusId,
        this.accountId,
        this.advance,
        this.fullname,
        this.gender,
        this.phone,
        this.birthday,
        this.address,
        this.cmndFront,
        this.cmndBack,
        this.needConfirm,
        this.maxAdvance,
        this.maxAdvanceRequest,
    });

    int id;
    String cmnd;
    int level;
    int statusId;
    String accountId;
    int advance;
    String fullname;
    int gender;
    String phone;
    String birthday;
    String address;
    String cmndFront;
    String cmndBack;
    bool needConfirm;
    int maxAdvance;
    int maxAdvanceRequest;

    factory InfomationCustomer.fromJson(Map<String, dynamic> json) => InfomationCustomer(
        id: json["id"],
        cmnd: json["cmnd"],
        level: json["level"],
        statusId: json["status_id"],
        accountId: json["account_id"],
        advance: json["advance"],
        fullname: json["fullname"],
        gender: json["gender"],
        phone: json["phone"],
        birthday: json["birthday"],
        address: json["address"],
        cmndFront: json["cmndFront"],
        cmndBack: json["cmndBack"],
        needConfirm: json["need_confirm"],
        maxAdvance: json["max_advance"],
        maxAdvanceRequest: json["max_advance_request"],
    );

}
