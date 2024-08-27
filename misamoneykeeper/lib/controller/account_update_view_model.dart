import 'package:misamoneykeeper_flutter/controller/account_view_model.dart';
import 'package:misamoneykeeper_flutter/controller/splash_view_model.dart';
import 'package:misamoneykeeper_flutter/server/globs.dart';
import 'package:misamoneykeeper_flutter/server/service_call.dart';
import 'package:misamoneykeeper_flutter/utility/export.dart';

class AccountUpdateViewModel extends GetxController {
  var balanceController = TextEditingController().obs;
  var nameController = TextEditingController().obs;
  var descriptionController = TextEditingController().obs;

  final splashVM = Get.find<SplashViewModel>();
  final accountViewModel = Get.find<AccountViewModel>();
  var isLoading = false.obs;
  var isSuccess = false.obs;
  var previousBalance = "".obs;
  var previousType = "".obs;
  var previousName = "".obs;
  var previousDescription = "".obs;
  // Loại tài khoản
  var accountType = 'Tiền mặt'.obs;
  var accountTypeId = 1.obs;

  final int accountId;
  AccountUpdateViewModel(this.accountId);

  //Hàm để sửa thông tin tài sản
  void serviceCallAccountUpdate() async {
    isLoading(true);
    isSuccess(false);
    previousBalance.value = balanceController.value.text;
    previousName.value = nameController.value.text;
    previousType.value = accountType.value;
    previousDescription.value = descriptionController.value.text;
    await ServiceCallPatch.patch({
      "account_id": accountId.toString(),
      "ac_name": nameController.value.text,
      "ac_money": balanceController.value.text,
      "ac_type": accountTypeId.value.toString(),
      "ac_explanation": descriptionController.value.text,
      "user_id": splashVM.userModel.value.id.toString()
    }, SVKey.svUpdateAccount, isToken: true, withSuccess: (resObj) async {
      if (resObj[KKey.status] == 1) {
        isLoading(false);
        isSuccess(true);
        balanceController.value.text = "";
        nameController.value.text = "";
        descriptionController.value.text = "";
        accountViewModel.serviceCallList();
        Get.snackbar(appname,
            "Chúc mừng, bạn đã thay đổi thông tin tài khoản thành công");
      } else {
        isSuccess(false);
        Get.snackbar(
            appname, "Ví chỉ có thế chứa tối đa 1 tỷ, vui lòng sửa lại");
      }
    }, failure: (err) async {
      Get.snackbar(appname, err.toString());
    });
  }
}
