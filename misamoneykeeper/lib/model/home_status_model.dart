class HomeStatusModel {
  List<Sum>? sum;
  List<Category>? category;

  HomeStatusModel({this.sum, this.category});

  HomeStatusModel.fromJson(Map<String, dynamic> json) {
    if (json['sum'] != null) {
      sum = <Sum>[];
      json['sum'].forEach((v) {
        sum!.add(Sum.fromJson(v));
      });
    }
    if (json['category'] != null) {
      category = <Category>[];
      json['category'].forEach((v) {
        category!.add(Category.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (sum != null) {
      data['sum'] = sum!.map((v) => v.toJson()).toList();
    }
    if (category != null) {
      data['category'] = category!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Sum {
  int? pMoneyPay;
  int? pMoneyCollect;

  Sum({this.pMoneyPay, this.pMoneyCollect});

  Sum.fromJson(Map<String, dynamic> json) {
    pMoneyPay = json['p_money_pay'];
    pMoneyCollect = json['p_money_collect'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['p_money_pay'] = pMoneyPay;
    data['p_money_collect'] = pMoneyCollect;
    return data;
  }
}

class Category {
  int? categoryId;
  String? caName;
  String? caImage;
  int? sumMoney;

  Category({this.categoryId, this.caName, this.caImage, this.sumMoney});

  Category.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    caName = json['ca_name'];
    caImage = json['ca_image'];
    sumMoney = json['sum_money'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['category_id'] = categoryId;
    data['ca_name'] = caName;
    data['ca_image'] = caImage;
    data['sum_money'] = sumMoney;
    return data;
  }
}