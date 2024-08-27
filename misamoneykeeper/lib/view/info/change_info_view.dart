import 'package:intl/intl.dart';
import 'package:misamoneykeeper_flutter/controller/splash_view_model.dart';
import 'package:misamoneykeeper_flutter/controller/user_profile_view_model.dart';
import 'package:misamoneykeeper_flutter/model/user_profile.dart';
import 'package:misamoneykeeper_flutter/utility/common_widgets.dart';
import 'package:misamoneykeeper_flutter/utility/export.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as datatTimePicker;

class ChangeInfoView extends StatefulWidget {
  const ChangeInfoView({super.key});

  @override
  State<ChangeInfoView> createState() => _ChangeInfoViewState();
}

class _ChangeInfoViewState extends State<ChangeInfoView> {
  late UserProfileVM userProfileVM;
  final splashVM = Get.find<SplashViewModel>();
  final _formKey = GlobalKey<FormState>();
  DateFormat inputFormat = DateFormat('yyyy-MM-dd');
  DateFormat outputFormat = DateFormat('dd/MM/yyyy');

  //Hàm lấy dữ liệu từ server và gán vào các ô nhập thông tin
  Future<void> fetchDataFromServer() async {
    List<UserProfile> data = await userProfileVM.serviceCallList();
    for (var item in data) {
      userProfileVM.txtFirstName.value.text = item.firstName!;
      userProfileVM.txtLastName.value.text = item.lastName!;
      userProfileVM.txtPhone.value.text = splashVM.userModel.value.mobile!;
      userProfileVM.txtEmail.value.text = item.email!;
      userProfileVM.txtUserDetailId.value = item.userDetailsId!;
      if (item.uGender!.toString() == "") {
        userProfileVM.selectedGender.value = "";
      } else {
        userProfileVM.selectedGender.value = item.uGender!.toString();
      }

      userProfileVM.txtAddress.value.text = item.uAddress!;
      userProfileVM.txtJob.value.text = item.uJob!;

      DateTime date = inputFormat.parse(item.uBirthday!);

      String formattedDate = outputFormat.format(date);
      userProfileVM.txtBirthView.value.text = formattedDate;
      userProfileVM.txtBirthSV.value = formattedDate;
      setState(() {});
    }
  }

  //Hàm để khởi tạo trạng thái ban đầu của widget
  @override
  void initState() {
    userProfileVM = Get.put(UserProfileVM());
    fetchDataFromServer();
    super.initState();
  }

  //Hàm để giải phóng tài nguyên mà một đối tượng đã sử dụng
  @override
  void dispose() {
    Get.delete<UserProfileVM>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,
          ),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
      ),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    radius: 35,
                    backgroundColor: Colors.grey[200],
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: ClipOval(
                        child: Image.asset(
                          imgGoogle,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    //Hiện thị các ô nhập thông tin của user
                    textFormField(
                        titleText: 'Họ và Tên Đệm',
                        controller: userProfileVM.txtFirstName.value,
                        enabled: true),
                    textFormField(
                        titleText: 'Tên',
                        controller: userProfileVM.txtLastName.value,
                        enabled: true),
                    textFormField(
                        titleText: 'Số điện thoại',
                        controller: userProfileVM.txtPhone.value,
                        enabled: false),
                    textFormField(
                        titleText: 'Email',
                        controller: userProfileVM.txtEmail.value,
                        enabled: false),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Ngày sinh',
                          style: TextStyle(
                            fontFamily: sansRegular,
                            fontWeight: FontWeight.w300,
                            color: Colors.grey[600],
                          ),
                        ),
                        TextFormField(
                          controller: userProfileVM.txtBirthView.value,
                          keyboardType: TextInputType.none,
                          onTap: () {
                            datatTimePicker.DatePicker.showDatePicker(
                              context,
                              showTitleActions: true,
                              minTime: DateTime(1900, 1, 1),
                              maxTime: DateTime.now(),
                              theme: const datatTimePicker.DatePickerTheme(
                                containerHeight: 150.0,
                              ),
                              onChanged: (date) {
                                userProfileVM.txtBirthView.value.text =
                                    '${date.day.padLeft(2, '0')}/${date.month.padLeft(2, '0')}/${date.year}';
                                String formattedDate =
                                    DateFormat('yyyy-MM-dd').format(date);
                                userProfileVM.txtBirthSV.value = formattedDate;
                                setState(() {});
                              },
                              currentTime: DateTime.now(),
                              locale: datatTimePicker.LocaleType.vi,
                            );
                          },
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value == "01/01/1990") {
                              return 'Vui lòng nhập ngày sinh';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                        const Divider(
                          height: 0.5,
                          thickness: 1.5,
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                    //Ô chọn giới tính
                    Row(
                      children: [
                        Obx(() => Radio(
                              value: '1',
                              groupValue: userProfileVM.selectedGender.value,
                              onChanged: (value) {
                                userProfileVM
                                    .setSelectedGender(value.toString());
                              },
                            )),
                        const Text('Nam'),
                        const SizedBox(width: 10),
                        Obx(() => Radio(
                              value: '2',
                              groupValue: userProfileVM.selectedGender.value,
                              onChanged: (value) {
                                userProfileVM
                                    .setSelectedGender(value.toString());
                              },
                            )),
                        const Text('Nữ'),
                      ],
                    ),
                    const Divider(
                      height: 0.5,
                      thickness: 1.5,
                    ),
                    const SizedBox(height: 10),
                    textFormField(
                        titleText: 'Địa chỉ',
                        controller: userProfileVM.txtAddress.value,
                        enabled: true),
                    textFormField(
                        titleText: 'Nghề nghiệp',
                        controller: userProfileVM.txtJob.value,
                        enabled: true),
                    const SizedBox(
                      height: 10,
                    ),
                    //Nút cập nhật thông tin đã sửa
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                userProfileVM.serviceCallChangeProfile();
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              splashFactory: NoSplash.splashFactory,
                              elevation: 0,
                              shadowColor: Colors.transparent,
                            ).copyWith(
                              elevation: const MaterialStatePropertyAll(0),
                            ),
                            child: const Text(
                              'Cập nhật',
                              style: TextStyle(fontSize: 17),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
