import 'package:misamoneykeeper_flutter/model/user_model.dart';
import 'package:misamoneykeeper_flutter/server/globs.dart';
import 'package:misamoneykeeper_flutter/view/home/home_main.dart';
import 'package:get/get.dart';
import 'package:misamoneykeeper_flutter/view/start/introduction_page.dart';

class SplashViewModel extends GetxController {
  final userModel = UserModel().obs;

  void loadView() async {
    await Future.delayed(const Duration(seconds: 2));

    if (Globs.udValueBool(Globs.userLogin)) {
      userModel.value = UserModel.fromJson(Globs.udValue(Globs.userPayload));
      Get.to(const HomeMain());
    } else {
      Get.to(const IntroductionPage());
    }
  }

  void goAfterLoginMainTab() {
    userModel.value = UserModel.fromJson(Globs.udValue(Globs.userPayload));
    Get.to(const HomeMain());
  }

  void setData() {
    userModel.value = UserModel.fromJson(Globs.udValue(Globs.userPayload));
  }

  void logout() {
    userModel.value = UserModel();
    Globs.udBoolSet(false, Globs.userLogin);
    Get.offAll(const IntroductionPage());
  }
}
