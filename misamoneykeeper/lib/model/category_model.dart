class CategoryModel {
  int? categoryId;
  String? caName;
  String? caImage;
  String? caExplanation;
  List<CategoryDetails>? categoryDetails;

  CategoryModel(
      {categoryId,
      caName,
      caImage,
      caExplanation,
      categoryDetails});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    caName = json['ca_name'];
    caImage = json['ca_image'];
    caExplanation = json['ca_explanation'];
    if (json['category_details'] != null) {
      categoryDetails = <CategoryDetails>[];
      json['category_details'].forEach((v) {
        categoryDetails!.add(CategoryDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['category_id'] = categoryId;
    data['ca_name'] = caName;
    data['ca_image'] = caImage;
    data['ca_explanation'] = caExplanation;
    if (categoryDetails != null) {
      data['category_details'] =
          categoryDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CategoryDetails {
  int? categoryDetailsId;
  int? categoryId;
  int? cadType;
  String? cadName;
  String? cadImage;
  String? cadExplanation;

  CategoryDetails(
      {categoryDetailsId,
      categoryId,
      cadType,
      cadName,
      cadImage,
      cadExplanation});

  CategoryDetails.fromJson(Map<String, dynamic> json) {
    categoryDetailsId = json['category_details_id'];
    categoryId = json['category_id'];
    cadType = json['cad_type'];
    cadName = json['cad_name'];
    cadImage = json['cad_image'];
    cadExplanation = json['cad_explanation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['category_details_id'] = categoryDetailsId;
    data['category_id'] = categoryId;
    data['cad_type'] = cadType;
    data['cad_name'] = cadName;
    data['cad_image'] = cadImage;
    data['cad_explanation'] = cadExplanation;
    return data;
  }
}