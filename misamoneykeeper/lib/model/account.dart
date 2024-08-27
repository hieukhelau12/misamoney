class Account {
  int? accountId;
  int? userId;
  String? acName;
  int? acMoney;
  int? acType;
  String? acExplanation;
  int? acStatus;
  String? acModifyDate;

  Account(
      {this.accountId,
      this.userId,
      this.acName,
      this.acMoney,
      this.acType,
      this.acExplanation,
      this.acStatus,
      this.acModifyDate});

  Account.fromJson(Map<String, dynamic> json) {
    accountId = json['account_id'];
    userId = json['user_id'];
    acName = json['ac_name'];
    acMoney = json['ac_money'];
    acType = json['ac_type'];
    acExplanation = json['ac_explanation'];
    acStatus = json['ac_status'];
    acModifyDate = json['ac_modify_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['account_id'] = accountId;
    data['user_id'] = userId;
    data['ac_name'] = acName;
    data['ac_money'] = acMoney;
    data['ac_type'] = acType;
    data['ac_explanation'] = acExplanation;
    data['ac_status'] = acStatus;
    data['ac_modify_date'] = acModifyDate;
    return data;
  }
}
