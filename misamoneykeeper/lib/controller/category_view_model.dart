import 'package:misamoneykeeper_flutter/model/category_model.dart';
import 'package:misamoneykeeper_flutter/server/globs.dart';
import 'package:misamoneykeeper_flutter/server/service_call.dart';
import 'package:misamoneykeeper_flutter/utility/export.dart';

class CategoryViewModel extends GetxController {
  //Hàm lấy ra các mục lớn của thu chi
  Future<List<CategoryModel>> serviceCallCategory() async {
    List<CategoryModel> category = [];
    await ServiceCall.post({"cad_type": 1.toString()}, SVKey.svCategory,
        isToken: true, withSuccess: (resObj) async {
      if (resObj[KKey.status] == 1) {
        category = (resObj[KKey.payload] as List? ?? []).map((oObj) {
          return CategoryModel.fromJson(oObj);
        }).toList();
      }
    }, failure: (err) async {
      Get.snackbar(appname, err.toString());
    });
    return category;
  }
}
