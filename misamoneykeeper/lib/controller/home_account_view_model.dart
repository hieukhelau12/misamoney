import 'package:misamoneykeeper_flutter/controller/splash_view_model.dart';
import 'package:misamoneykeeper_flutter/model/account_model.dart';
import 'package:misamoneykeeper_flutter/server/globs.dart';
import 'package:misamoneykeeper_flutter/server/service_call.dart';
import 'package:misamoneykeeper_flutter/utility/export.dart';

class HomeAccountViewModel extends GetxController {
  final splashVM = Get.find<SplashViewModel>();

  //Hàm lấy ra tài khoản của user
  Future<List<AccountModel>> serviceCallHomeAccount() async {
    List<AccountModel> data = [];
    await ServiceCall.post({
      "user_id": splashVM.userModel.value.id.toString(),
    }, SVKey.svReportAccount, isToken: true, withSuccess: (resObj) async {
      if (resObj[KKey.status] == 1) {
        data = (resObj[KKey.payload] as List? ?? []).map((oObj) {
          return AccountModel.fromJson(oObj);
        }).toList();
      }
    }, failure: (err) async {
      Get.snackbar(appname, err.toString());
    });
    return data;
  }
}
