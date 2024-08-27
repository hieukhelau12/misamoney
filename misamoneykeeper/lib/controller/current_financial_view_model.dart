import 'dart:async';

import 'package:misamoneykeeper_flutter/controller/splash_view_model.dart';
import 'package:misamoneykeeper_flutter/model/account.dart';
import 'package:misamoneykeeper_flutter/server/globs.dart';
import 'package:misamoneykeeper_flutter/server/service_call.dart';
import 'package:misamoneykeeper_flutter/utility/export.dart';

class CurrentFinancialViewModel extends GetxController {
  CurrentFinancialViewModel() {
    serviceCallList();
  }

  final splashVM = Get.find<SplashViewModel>();

  //Hàm lấy ra tài chính hiện tại
  StreamController<List<Account>> streamController =
      StreamController<List<Account>>();
  void serviceCallList() async {
    await ServiceCall.post({
      "user_id": splashVM.userModel.value.id.toString(),
    }, SVKey.svReportAccount, isToken: true, withSuccess: (resObj) async {
      if (resObj[KKey.status] == 1) {
        var data = (resObj[KKey.payload] as List? ?? []).map((oObj) {
          return Account.fromJson(oObj);
        }).toList();
        streamController.add(data);
      }
    }, failure: (err) async {
      Get.snackbar(appname, err.toString());
    });
  }

  // // Lắng nghe sự thay đổi của streamController
  Stream<List<Account>?> get dataStream => streamController.stream;
}
