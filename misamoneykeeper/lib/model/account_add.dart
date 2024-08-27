class AccountAdd {
  String? acName;
  int? acMoney;
  int? acType;
  String? acExplanation;
  int? userId;

  AccountAdd(
      {this.acName,
      this.acMoney,
      this.acType,
      this.acExplanation,
      this.userId});

  AccountAdd.fromJson(Map<String, dynamic> json) {
    acName = json['ac_name'];
    acMoney = json['ac_money'];
    acType = json['ac_type'];
    acExplanation = json['ac_explanation'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ac_name'] = acName;
    data['ac_money'] = acMoney;
    data['ac_type'] = acType;
    data['ac_explanation'] = acExplanation;
    data['user_id'] = userId;
    return data;
  }
}
