import 'package:misamoneykeeper_flutter/controller/splash_view_model.dart';
import 'package:misamoneykeeper_flutter/server/globs.dart';
import 'package:misamoneykeeper_flutter/server/service_call.dart';
import 'package:misamoneykeeper_flutter/utility/export.dart';

class ChangePassVM extends GetxController {
  final splashVM = Get.find<SplashViewModel>();
  var txtPassOld = TextEditingController().obs;
  var txtPassNew = TextEditingController().obs;
  var txtPassConfirm = TextEditingController().obs;
  var isSuccess = false.obs;

  //Hàm để thay đổi mật khẩu cho user
  void serviceCallChangePass() async {
    await ServiceCallPatch.patch({
      "user_id": splashVM.userModel.value.id.toString(),
      "password": txtPassOld.value.text,
      "new_password": txtPassNew.value.text
    }, SVKey.svChangePass, isToken: true, withSuccess: (resObj) async {
      if (resObj[KKey.status] == 1) {
        reset();
        Get.snackbar(appname, "Chúc mừng, bạn đã đổi mật khẩu thành công");
        isSuccess.value = true;
        update();
      } else {
        reset();
        isSuccess.value = false;
        Get.snackbar(appname, "Mật khẩu cũ không chính xác, vui lòng nhập lại");
      }
    }, failure: (err) async {
      Get.snackbar(appname, err.toString());
    });
  }

  void reset() {
    txtPassOld.value.text = '';
    txtPassNew.value.text = '';
    txtPassConfirm.value.text = '';
  }
}
