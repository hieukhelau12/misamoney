import 'dart:async';

import 'package:misamoneykeeper_flutter/controller/splash_view_model.dart';
import 'package:misamoneykeeper_flutter/model/account_model.dart';
import 'package:misamoneykeeper_flutter/model/home_status_model.dart';
import 'package:misamoneykeeper_flutter/model/recnet_note_home.dart';
import 'package:misamoneykeeper_flutter/server/globs.dart';
import 'package:misamoneykeeper_flutter/server/service_call.dart';
import 'package:misamoneykeeper_flutter/utility/export.dart';

class HomeViewModel extends GetxController {
  StreamController<List<AccountModel>> streamAccount =
      StreamController<List<AccountModel>>.broadcast();
  StreamController<List<HomeStatusModel>> streamHomeStatus =
      StreamController<List<HomeStatusModel>>.broadcast();
  StreamController<List<RecnetNoteHome>> streamRecnetNoteHome =
      StreamController<List<RecnetNoteHome>>.broadcast();

  HomeViewModel() {
    serviceCallAccount();
    serviceCallStatus();
    serviceCallRecnetNote();
  }

  //Hàm để đóng các stream
  @override
  void onClose() {
    streamAccount.close();
    streamRecnetNoteHome.close();
    super.onClose();
  }

  final splashVM = Get.find<SplashViewModel>();

  //Hàm lấy ra các tài khoản
  void serviceCallAccount() async {
    await ServiceCall.post({
      "user_id": splashVM.userModel.value.id.toString(),
    }, SVKey.svReportAccount, isToken: true, withSuccess: (resObj) async {
      if (resObj[KKey.status] == 1) {
        var data = (resObj[KKey.payload] as List? ?? []).map((oObj) {
          return AccountModel.fromJson(oObj);
        }).toList();
        streamAccount.add(data);
        streamAccount.close();
      } else if (resObj[KKey.status] == 0) {
        var data = (resObj[KKey.message] as List? ?? []).map((e) {
          return AccountModel.fromJson(e);
        }).toList();
        streamAccount.add(data);
        streamAccount.close();
      }
    }, failure: (err) async {
      Get.snackbar(appname, err.toString());
    });
  }

  //Hàm lấy ra các khoản thu chi
  void serviceCallStatus() async {
    await ServiceCall.post({
      "user_id": splashVM.userModel.value.id.toString(),
    }, SVKey.svHomeStatus, isToken: true, withSuccess: (resObj) async {
      if (resObj[KKey.status] == 1) {
        var data = (resObj[KKey.payload] as List? ?? []).map((oObj) {
          return HomeStatusModel.fromJson(oObj);
        }).toList();
        streamHomeStatus.add(data);
        streamHomeStatus.close();
      } else if (resObj[KKey.status] == 0) {
        var data = (resObj[KKey.message] as List? ?? []).map((e) {
          return HomeStatusModel.fromJson(e);
        }).toList();
        streamHomeStatus.add(data);
        streamHomeStatus.close();
      }
    }, failure: (err) async {
      Get.snackbar(appname, err.toString());
    });
  }

  //Hàm lấy ra lịch sử thêm thu chi gần đây
  void serviceCallRecnetNote() async {
    await ServiceCall.post({
      "user_id": splashVM.userModel.value.id.toString(),
      "month": 3.toString()
    }, SVKey.svRecnetNoteHome, isToken: true, withSuccess: (resObj) async {
      if (resObj[KKey.status] == 1) {
        var data = (resObj[KKey.payload] as List? ?? []).map((oObj) {
          return RecnetNoteHome.fromJson(oObj);
        }).toList();
        streamRecnetNoteHome.add(data);
        streamRecnetNoteHome.close();
      } else if (resObj[KKey.status] == 0) {
        var data = (resObj[KKey.message] as List? ?? []).map((e) {
          return RecnetNoteHome.fromJson(e);
        }).toList();
        streamRecnetNoteHome.add(data);
        streamRecnetNoteHome.close();
      }
    }, failure: (err) async {
      Get.snackbar(appname, err.toString());
    });
  }
}
