import 'package:misamoneykeeper_flutter/controller/splash_view_model.dart';
import 'package:misamoneykeeper_flutter/server/globs.dart';
import 'package:misamoneykeeper_flutter/server/service_call.dart';
import 'package:misamoneykeeper_flutter/utility/export.dart';

class LoginViewModel extends GetxController {
  final txtEmail = TextEditingController().obs;
  final txtPassword = TextEditingController().obs;
  final isShowPasswordLogin = false.obs;

  final isLoading = false.obs;

  //Hàm để đăng nhập
  void serviceCallLogin() {
    isLoading(true);
    // Gửi yêu cầu post vs các tham số, đường dẫn, thành công, thất bại
    ServiceCall.post({
      "email": txtEmail.value.text,
      "password": txtPassword.value.text,
    }, SVKey.svLogin, withSuccess: (resObj) async {
      isLoading(false);
      if (resObj[KKey.status] == 1) {
        var payload = resObj[KKey.payload] as Map? ?? {};

        Globs.udSet(payload, Globs.userPayload);
        Globs.udBoolSet(true, Globs.userLogin);

        Get.delete<LoginViewModel>();
        Get.find<SplashViewModel>().goAfterLoginMainTab();

        Get.snackbar("MiSa", "Bạn đã đăng nhập thành công");
      } else {
        Get.snackbar("MiSa", "Sai mật khẩu hoặc tài khoản");
      }
    }, failure: (err) async {
      Get.snackbar("MiSA", err.toString());
    });
    isLoading(false);
  }

  //Hàm để ẩn hiện mật khẩu
  void showPassword() {
    isShowPasswordLogin.value = !isShowPasswordLogin.value;
  }
}
