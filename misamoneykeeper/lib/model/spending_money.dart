class SpendingMoney {
  int? pMonth;
  int? pSum;

  SpendingMoney({this.pMonth, this.pSum});

  SpendingMoney.fromJson(Map<String, dynamic> json) {
    pMonth = json['p_month'];
    pSum = json['p_sum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['p_month'] = pMonth;
    data['p_sum'] = pSum;
    return data;
  }
}
