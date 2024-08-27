import 'package:misamoneykeeper_flutter/controller/change_pass_view_model.dart';
import 'package:misamoneykeeper_flutter/utility/export.dart';

class ChangePasswordView extends StatefulWidget {
  const ChangePasswordView({super.key});

  @override
  State<ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  late ChangePassVM changePassVM;
  final formKey = GlobalKey<FormState>();

  //Hàm check mật khẩu có đủ điều kiện không
  bool validatePassword(String password) {
    // Biểu thức chính quy kiểm tra mật khẩu
    RegExp passwordRegex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$');

    // Kiểm tra xem mật khẩu có khớp với biểu thức chính quy hay không
    return passwordRegex.hasMatch(password);
  }

  //Hàm để khởi tạo trạng thái ban đầu của widget
  @override
  void initState() {
    changePassVM = Get.put(ChangePassVM());
    super.initState();
  }

  //Hàm để giải phóng tài nguyên mà một đối tượng đã sử dụng
  @override
  void dispose() {
    Get.delete<ChangePassVM>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          elevation: 0,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back)),
          title: const Text(
            "Đổi Mật Khẩu",
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  //Ô nhập mật khẩu cũ
                  TextFormField(
                    controller: changePassVM.txtPassOld.value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng nhập mật khẩu cũ';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Mật khẩu cũ',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: const BorderSide(),
                      ),
                      prefixIcon: const Icon(Icons.lock),
                    ),
                  ),
                  const SizedBox(height: 10),
                  //Ô nhập mật khẩu mới
                  TextFormField(
                    controller: changePassVM.txtPassNew.value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng nhập mật khẩu mới';
                      } else if (value == changePassVM.txtPassOld.value.text) {
                        return 'Vui lòng nhập mật khẩu mới khác mật khẩu cũ';
                      } else if (!validatePassword(value)) {
                        return 'Mật khẩu phải có ít nhất 8 kí tự bao gồm ký tự chữ hoa, chữ thường, chữ số';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Mật khẩu mới',
                      errorMaxLines: 3,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: const BorderSide(),
                      ),
                      prefixIcon: const Icon(Icons.lock),
                    ),
                  ),
                  const SizedBox(height: 10),
                  //Ô nhập xác nhận mật khẩu
                  TextFormField(
                    controller: changePassVM.txtPassConfirm.value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng xác nhận mật khẩu';
                      } else if (value != changePassVM.txtPassNew.value.text) {
                        return 'Mật khẩu xác nhận không khớp';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Xác nhận mật khẩu',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: const BorderSide(),
                      ),
                      prefixIcon: const Icon(Icons.lock),
                    ),
                  ),
                  const SizedBox(height: 10),
                  //Nút lưu đổi mật khẩu
                  SizedBox(
                      width: 300,
                      child: ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            changePassVM.serviceCallChangePass();
                            if (changePassVM.isSuccess.value == true) {
                              Navigator.pop(context);
                            }
                          }
                        },
                        child: const Text('LƯU'),
                      )),
                ],
              ),
            ),
          ),
        ));
  }
}
