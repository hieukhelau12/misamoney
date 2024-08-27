import 'package:intl/intl.dart';
import 'package:misamoneykeeper_flutter/controller/splash_view_model.dart';
import 'package:misamoneykeeper_flutter/server/globs.dart';
import 'package:misamoneykeeper_flutter/server/service_call.dart';
import 'package:misamoneykeeper_flutter/utility/export.dart';

class CollectViewModel extends GetxController {
  var payId = 0.obs;
  var categoryIcon = ''.obs;
  var categoryTitle = ''.obs;
  var categoryDetailsId = 0.obs;
  var isLoading = false.obs;

  // Tài khoản
  var accountIcon = 0.obs;
  var accountTitle = ''.obs;
  var accountId = 0.obs;

  final dateController = TextEditingController(
          text: DateFormat('yyyy-MM-dd').format(DateTime.now()).toString())
      .obs;

  final moneyAccount = TextEditingController().obs;
  final descriptionAccount = TextEditingController().obs;

  final splashVM = Get.find<SplashViewModel>();

  @override
  void dispose() {
    super.dispose();
    clean();
  }

  //Hàm để thêm khoản thu
  void serviceAddPay() async {
    isLoading(true);
    await ServiceCall.post({
      "user_id": splashVM.userModel.value.id.toString(),
      "category_details_id": categoryDetailsId.value.toString(),
      "account_id": accountId.value.toString(),
      "p_type": 2.toString(),
      "p_money": moneyAccount.value.text,
      "p_explanation": descriptionAccount.value.text,
      "p_date": dateController.value.text
    }, SVKey.svAddPlay, isToken: true, withSuccess: (resObj) async {
      if (resObj[KKey.status] == 1) {
        clean();
        Get.snackbar(appname, "Bạn đã thêm khoản thu thành công");
      } else {
        clean();
        Get.snackbar(
            appname, "Ví chỉ có thể chứa tối đa 1 tỷ, vui lòng thêm lại");
      }
    }, failure: (err) async {
      Get.snackbar(appname, err.toString());
    });
  }

  //Hàm để sửa khoản thu
  void serviceUpdatePay(int pay, String moneyOld) async {
    isLoading(true);
    await ServiceCallPatch.patch({
      "pay_id": pay.toString(),
      "user_id": splashVM.userModel.value.id.toString(),
      "category_details_id": categoryDetailsId.value.toString(),
      "account_id": accountId.value.toString(),
      "p_type": 2.toString(),
      "p_money": moneyAccount.value.text,
      "p_explanation": descriptionAccount.value.text,
      "p_date": dateController.value.text,
      "money_old": moneyOld.toString()
    }, SVKey.svUpdatePlay, isToken: true, withSuccess: (resObj) async {
      if (resObj[KKey.status] == 1) {
        clean();
        Get.snackbar(appname, "Bạn đã cập nhật khoản chi thành công");
      } else {
        Get.snackbar(
            appname, "Ví chỉ có thể chứa tối đa 1 tỷ, vui lòng sửa lại");
      }
    }, failure: (err) async {
      Get.snackbar(appname, err.toString());
    });
  }

  //Hàm để xoá khoản thu
  void serviceDeletePay(int pay) async {
    isLoading(true);
    await ServiceCallDelete.delete({
      "pay_id": pay.toString(),
      "user_id": splashVM.userModel.value.id.toString(),
      "category_details_id": categoryDetailsId.value.toString(),
      "account_id": accountId.value.toString()
    }, SVKey.svDeletePlay, isToken: true, withSuccess: (resObj) async {
      if (resObj[KKey.status] == 1) {
        clean();
        Get.snackbar(appname, "Bạn đã xóa khoản chi thành công");
      }
    }, failure: (err) async {
      Get.snackbar(appname, err.toString());
    });
  }

  //Hàm để xoá toàn bộ dữ liệu user nhập
  void clean() {
    categoryIcon.value = '';
    categoryTitle.value = '';
    categoryDetailsId.value = 0;
    isLoading(false);
    accountIcon.value = 0;
    accountTitle.value = '';
    accountId.value = 0;
    dateController.value.text = '';
    moneyAccount.value.text = '';
    descriptionAccount.value.text = '';
  }
}
