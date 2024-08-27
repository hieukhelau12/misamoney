import 'package:misamoneykeeper_flutter/controller/splash_view_model.dart';
import 'package:misamoneykeeper_flutter/model/user_profile.dart';
import 'package:misamoneykeeper_flutter/server/globs.dart';
import 'package:misamoneykeeper_flutter/server/service_call.dart';
import 'package:misamoneykeeper_flutter/utility/export.dart';

class UserProfileVM extends GetxController {
  //Các biến cần thiết để lưu thông tin
  final splashVM = Get.find<SplashViewModel>();
  final txtFirstName = TextEditingController().obs;
  final txtLastName = TextEditingController().obs;
  final txtPhone = TextEditingController().obs;
  final txtEmail = TextEditingController().obs;
  final txtBirthView = TextEditingController().obs;
  final txtAddress = TextEditingController().obs;
  final txtJob = TextEditingController().obs;
  var txtBirthSV = ''.obs;
  final txtUserDetailId = 0.obs;
  final selectedGender = 'Nam'.obs;

  //Hàm để lấy ra thông tin của user
  Future<List<UserProfile>> serviceCallList() async {
    List<UserProfile> data = [];
    await ServiceCall.post({
      "user_id": splashVM.userModel.value.id.toString(),
    }, SVKey.svUserProfile, isToken: true, withSuccess: (resObj) async {
      if (resObj[KKey.status] == 1) {
        data = (resObj[KKey.payload] as List? ?? []).map((oObj) {
          return UserProfile.fromJson(oObj);
        }).toList();
      }
    }, failure: (err) async {
      Get.snackbar(appname, err.toString());
    });
    return data;
  }

  //Hàm để sửa thông tin của user
  void serviceCallChangeProfile() async {
    await ServiceCall.post({
      "user_id": splashVM.userModel.value.id.toString(),
      "user_details_id": txtUserDetailId.value.toString(),
      "mobile": txtPhone.value.text,
      "first_name": txtFirstName.value.text,
      "last_name": txtLastName.value.text,
      "u_gender": selectedGender.value.toString(),
      "u_birthday": txtBirthSV.value,
      "u_address": txtAddress.value.text,
      "u_job": txtJob.value.text
    }, SVKey.svUpdateUserProfile, isToken: true, withSuccess: (resObj) async {
      if (resObj[KKey.status] == 1) {
        Get.snackbar(
            appname, "Chúc mừng, bạn đã cập nhật thông tin thành công");
        Globs.udRemove(Globs.userPayload);
        // Lưu mới
        var payload = resObj[KKey.payload] as Map? ?? {};

        Globs.udSet(payload, Globs.userPayload);
        Get.find<SplashViewModel>().setData();
      }
    }, failure: (err) async {
      Get.snackbar(appname, err.toString());
    });
  }

  //Hàm để đổi giới tính
  void setSelectedGender(String gender) {
    selectedGender.value = gender;
  }
}
