import 'dart:async';

import 'package:misamoneykeeper_flutter/controller/splash_view_model.dart';
import 'package:misamoneykeeper_flutter/model/account_model.dart';
import 'package:misamoneykeeper_flutter/server/globs.dart';
import 'package:misamoneykeeper_flutter/server/service_call.dart';
import 'package:misamoneykeeper_flutter/utility/export.dart';

class AccountViewModel extends GetxController {
  AccountViewModel() {
    serviceCallList();
  }

  final splashVM = Get.find<SplashViewModel>();

  //Hàm để lấy ra danh sách tài khoản
  StreamController<List<AccountModel>> streamController =
      StreamController<List<AccountModel>>.broadcast();
  void serviceCallList() async {
    await ServiceCall.post({
      "user_id": splashVM.userModel.value.id.toString(),
    }, SVKey.svReportAccount, isToken: true, withSuccess: (resObj) async {
      if (resObj[KKey.status] == 1) {
        var data = (resObj[KKey.payload] as List? ?? []).map((oObj) {
          return AccountModel.fromJson(oObj);
        }).toList();
        streamController.add(data);
      } else if (resObj[KKey.status] == 0) {
        var data = (resObj[KKey.message] as List? ?? []).map((e) {
          return AccountModel.fromJson(e);
        }).toList();
        streamController.add(data);
      }
    }, failure: (err) async {
      Get.snackbar(appname, err.toString());
    });
  }

  // // Lắng nghe sự thay đổi của streamController
  Stream<List<AccountModel>?> get dataStream => streamController.stream;
}
