import 'package:misamoneykeeper_flutter/controller/splash_view_model.dart';
import 'package:misamoneykeeper_flutter/model/collect_money.dart';
import 'package:misamoneykeeper_flutter/server/globs.dart';
import 'package:misamoneykeeper_flutter/server/service_call.dart';
import 'package:misamoneykeeper_flutter/utility/export.dart';

class CollectVM extends GetxController {
  final splashVM = Get.find<SplashViewModel>();
  String txtYear = '2024'.obs();

  //Hàm lấy các khoản thu
  Future<List<CollectMoney>> serviceCallList() async {
    List<CollectMoney> data = [];
    await ServiceCall.post({
      "user_id": splashVM.userModel.value.id.toString(),
      "year": txtYear
    }, SVKey.svCollect, isToken: true, withSuccess: (resObj) async {
      if (resObj[KKey.status] == 1) {
        data = (resObj[KKey.payload] as List? ?? []).map((oObj) {
          return CollectMoney.fromJson(oObj);
        }).toList();
      }
    }, failure: (err) async {
      Get.snackbar(appname, err.toString());
    });
    return data;
  }
}
