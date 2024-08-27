import 'dart:async';

import 'package:misamoneykeeper_flutter/controller/splash_view_model.dart';
import 'package:misamoneykeeper_flutter/model/recnet_note.dart';
import 'package:misamoneykeeper_flutter/server/globs.dart';
import 'package:misamoneykeeper_flutter/server/service_call.dart';
import 'package:misamoneykeeper_flutter/utility/export.dart';

class HistoryViewModel extends GetxController {
  var month = 0.obs;
  var isMonth = false.obs;
  DateTime now = DateTime.now();

  final splashVM = Get.find<SplashViewModel>();

  //Hàm lấy ra lịch sử thêm thu chi theo tháng năm
  Future<List<RecnetNote>> serviceCallRecnetNote(int mounth) async {
    List<RecnetNote> recnetNote = [];
    await ServiceCall.post({
      "user_id": splashVM.userModel.value.id.toString(),
      "month": mounth.toString(),
      "year": now.year.toString()
    }, SVKey.svRecnetNote, isToken: true, withSuccess: (resObj) async {
      if (resObj[KKey.status] == 1) {
        recnetNote = (resObj[KKey.payload] as List? ?? []).map((oObj) {
          return RecnetNote.fromJson(oObj);
        }).toList();
      }
    }, failure: (err) async {
      Get.snackbar(appname, err.toString());
    });
    return recnetNote;
  }
}
