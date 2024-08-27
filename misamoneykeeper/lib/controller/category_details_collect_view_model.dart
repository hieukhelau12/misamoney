import 'package:misamoneykeeper_flutter/model/category_model.dart';
import 'package:misamoneykeeper_flutter/server/globs.dart';
import 'package:misamoneykeeper_flutter/server/service_call.dart';
import 'package:misamoneykeeper_flutter/utility/export.dart';

class CategoryDetailsCollectViewModel extends GetxController {
  //Hàm lấy ra các mục con của mục lớn thi chi
  Future<List<CategoryDetails>> serviceCallCategory() async {
    List<CategoryDetails> category = [];
    await ServiceCall.post({"cad_type": 2.toString()}, SVKey.svCategoryCollect,
        isToken: true, withSuccess: (resObj) async {
      if (resObj[KKey.status] == 1) {
        category = (resObj[KKey.payload] as List? ?? []).map((oObj) {
          return CategoryDetails.fromJson(oObj);
        }).toList();
      }
    }, failure: (err) async {
      Get.snackbar(appname, err.toString());
    });
    return category;
  }
}
