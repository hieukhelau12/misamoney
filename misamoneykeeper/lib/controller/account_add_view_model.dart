import 'package:misamoneykeeper_flutter/controller/account_view_model.dart';
import 'package:misamoneykeeper_flutter/controller/splash_view_model.dart';
import 'package:misamoneykeeper_flutter/server/globs.dart';
import 'package:misamoneykeeper_flutter/server/service_call.dart';
import 'package:misamoneykeeper_flutter/utility/export.dart';

class AccountAddViewModel extends GetxController {
  var balanceController = TextEditingController().obs;
  var nameController = TextEditingController().obs;
  var descriptionController = TextEditingController().obs;

  final splashVM = Get.find<SplashViewModel>();
  final accountViewModel = Get.find<AccountViewModel>();
  var isLoading = false.obs;
  var isSuccess = false.obs;

  // Loại tài khoản
  var accountType = 'Tiền mặt'.obs;
  var accountTypeId = 1.obs;

  //Hàm để thêm tài khoản
  void serviceCallAddAccount() async {
    isLoading(true);
    isSuccess(false);
    await ServiceCall.post({
      "ac_name": nameController.value.text,
      "ac_money": balanceController.value.text,
      "ac_type": accountTypeId.value.toString(),
      "ac_explanation": descriptionController.value.text,
      "user_id": splashVM.userModel.value.id.toString()
    }, SVKey.svAddAccount, isToken: true, withSuccess: (resObj) async {
      if (resObj[KKey.status] == 1) {
        isLoading(false);
        isSuccess(true);
        accountViewModel.serviceCallList();
        Get.snackbar(appname, "Chúc mừng, bạn đã thêm tài khoản thành công");
      } else {
        clean();
        Get.snackbar(
            appname, "Ví chỉ có thể chứa tối đa 1 tỷ, vui lòng thêm lại");
      }
    }, failure: (err) async {
      Get.snackbar(appname, err.toString());
    });
  }

  //Hàm để xoá toàn bộ dữ liệu user nhập
  void clean() {
    balanceController.value.text = "";
    isLoading(false);
    isSuccess(false);
    nameController.value.text = "";
    descriptionController.value.text = "";
    accountType.value = 'Tiền mặt';
    accountTypeId.value = 1;
  }
}
