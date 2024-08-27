class ReportAccount {
  int? accountId;
  String? acName;
  int? acMoney;
  int? acType;
  String? acBank;
  String? acCurrency;
  String? acExplanation;
  int? acStatus;
  String? acCreatedDate;
  String? acModifyDate;
  int? userId;

  ReportAccount(
      {this.accountId,
      this.acName,
      this.acMoney,
      this.acType,
      this.acBank,
      this.acCurrency,
      this.acExplanation,
      this.acStatus,
      this.acCreatedDate,
      this.acModifyDate,
      this.userId});

  ReportAccount.fromJson(Map<String, dynamic> json) {
    accountId = json['account_id'];
    acName = json['ac_name'];
    acMoney = json['ac_money'];
    acType = json['ac_type'];
    acBank = json['ac_bank'];
    acCurrency = json['ac_currency'];
    acExplanation = json['ac_explanation'];
    acStatus = json['ac_status'];
    acCreatedDate = json['ac_created_date'];
    acModifyDate = json['ac_modify_date'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['account_id'] = accountId;
    data['ac_name'] = acName;
    data['ac_money'] = acMoney;
    data['ac_type'] = acType;
    data['ac_bank'] = acBank;
    data['ac_currency'] = acCurrency;
    data['ac_explanation'] = acExplanation;
    data['ac_status'] = acStatus;
    data['ac_created_date'] = acCreatedDate;
    data['ac_modify_date'] = acModifyDate;
    data['user_id'] = userId;
    return data;
  }
}
