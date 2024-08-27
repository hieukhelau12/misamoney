class RecnetNoteHome {
  int? payId;
  int? categoryDetailsId;
  String? categoryName;
  String? cadImage;
  int? pType;
  String? pDate;
  int? pMoney;
  String? pExplanation;
  int? accountId;
  String? acName;
  int? acType;

  RecnetNoteHome(
      {payId,
      categoryDetailsId,
      categoryName,
      cadImage,
      pType,
      pDate,
      pMoney,
      pExplanation,
      accountId,
      acName,
      acType});

  RecnetNoteHome.fromJson(Map<String, dynamic> json) {
    payId = json['pay_id'];
    categoryDetailsId = json['category_details_id'];
    categoryName = json['category_name'];
    cadImage = json['cad_image'];
    pType = json['p_type'];
    pDate = json['p_date'];
    pMoney = json['p_money'];
    pExplanation = json['p_explanation'];
    accountId = json['account_id'];
    acName = json['ac_name'];
    acType = json['ac_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['pay_id'] = payId;
    data['category_details_id'] = categoryDetailsId;
    data['category_name'] = categoryName;
    data['cad_image'] = cadImage;
    data['p_type'] = pType;
    data['p_date'] = pDate;
    data['p_money'] = pMoney;
    data['p_explanation'] = pExplanation;
    data['account_id'] = accountId;
    data['ac_name'] = acName;
    data['ac_type'] = acType;
    return data;
  }
}
