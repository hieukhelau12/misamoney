import 'package:misamoneykeeper_flutter/controller/splash_view_model.dart';
import 'package:misamoneykeeper_flutter/model/sc_money.dart';
import 'package:misamoneykeeper_flutter/server/globs.dart';
import 'package:misamoneykeeper_flutter/server/service_call.dart';
import 'package:misamoneykeeper_flutter/utility/export.dart';

class SCMoneyVM extends GetxController {
  final splashVM = Get.find<SplashViewModel>();
  String txtYear = '2024'.obs();

  //Hàm để lấy dữ liệu thu chi theo năm
  Future<List<SCMoney>> serviceCallList() async {
    List<SCMoney> data = [];
    await ServiceCall.post({
      "user_id": splashVM.userModel.value.id.toString(),
      "year": txtYear
    }, SVKey.svCollectSpending, isToken: true, withSuccess: (resObj) async {
      if (resObj[KKey.status] == 1) {
        data = (resObj[KKey.payload] as List? ?? []).map((oObj) {
          return SCMoney.fromJson(oObj);
        }).toList();
      }
    }, failure: (err) async {
      Get.snackbar(appname, err.toString());
    });
    return data;
  }
}
