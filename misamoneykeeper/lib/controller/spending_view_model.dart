import 'package:misamoneykeeper_flutter/controller/splash_view_model.dart';
import 'package:misamoneykeeper_flutter/model/spending_money.dart';
import 'package:misamoneykeeper_flutter/server/globs.dart';
import 'package:misamoneykeeper_flutter/server/service_call.dart';
import 'package:misamoneykeeper_flutter/utility/export.dart';

class SpendingVM extends GetxController {
  final splashVM = Get.find<SplashViewModel>();
  String txtYear = '2024'.obs();

  //Hàm để lấy ra các khoản chi theo năm
  Future<List<SpendingMoney>> serviceCallList() async {
    List<SpendingMoney> data = [];
    await ServiceCall.post({
      "user_id": splashVM.userModel.value.id.toString(),
      "year": txtYear
    }, SVKey.svSpending, isToken: true, withSuccess: (resObj) async {
      if (resObj[KKey.status] == 1) {
        data = (resObj[KKey.payload] as List? ?? []).map((oObj) {
          return SpendingMoney.fromJson(oObj);
        }).toList();
      }
    }, failure: (err) async {
      Get.snackbar(appname, err.toString());
    });
    return data;
  }
}
