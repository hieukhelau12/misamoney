class SCMoney {
  int? pMonth;
  int? pTotalRevenue;
  int? pTotalExpense;

  SCMoney({this.pMonth, this.pTotalRevenue, this.pTotalExpense});

  SCMoney.fromJson(Map<String, dynamic> json) {
    pMonth = json['p_month'];
    pTotalRevenue = json['p_total_revenue'];
    pTotalExpense = json['p_total_expense'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['p_month'] = pMonth;
    data['p_total_revenue'] = pTotalRevenue;
    data['p_total_expense'] = pTotalExpense;
    return data;
  }
}
