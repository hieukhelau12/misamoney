import 'package:flutter/gestures.dart';
import 'package:misamoneykeeper_flutter/common/validator.dart';
import 'package:misamoneykeeper_flutter/controller/sign_up_view_model.dart';
import 'package:misamoneykeeper_flutter/utility/export.dart';
import 'package:misamoneykeeper_flutter/view/auth/login_view.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final authVM = Get.put(SignUpVM());
  final _formKey = GlobalKey<FormState>();

  //Hàm check mật khẩu có đúng định dạng không
  bool validatePassword(String password) {
    // Biểu thức chính quy kiểm tra mật khẩu
    RegExp passwordRegex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$');

    // Kiểm tra xem mật khẩu có khớp với biểu thức chính quy hay không
    return passwordRegex.hasMatch(password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  icLogo,
                  width: 60,
                  fit: BoxFit.cover,
                ),
              ),
              10.heightBox,
              const Text(
                'Sổ Thu Chi MISA',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              const SizedBox(height: 15),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //Ô nhập thông tin họ và tên đệm
                        Expanded(
                          flex: 3,
                          child: TextFormField(
                            controller: authVM.txtTenDem.value,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Vui lòng nhập họ và tên đệm';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: 'Họ và tên đệm',
                              contentPadding: const EdgeInsets.all(10),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                                borderSide: const BorderSide(),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        //Ô nhập thông tin tên
                        Expanded(
                          flex: 2,
                          child: TextFormField(
                            controller: authVM.txtTen.value,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Vui lòng nhập tên';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: 'Tên',
                              contentPadding: const EdgeInsets.all(10),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                                borderSide: const BorderSide(),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    //Ô nhập thông tin email
                    TextFormField(
                      controller: authVM.txtEmail.value,
                      validator: EmailValidator.validate,
                      decoration: InputDecoration(
                        hintText: 'Email',
                        contentPadding: const EdgeInsets.all(10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: const BorderSide(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    //Ô nhập thông tin số điện thoại
                    TextFormField(
                      controller: authVM.txtSDT.value,
                      validator: PhoneNumberValidator.validate,
                      decoration: InputDecoration(
                        hintText: 'Số điện thoại',
                        contentPadding: const EdgeInsets.all(10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: const BorderSide(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    //Ô nhập thông tin mật khẩu
                    Obx(
                      () => TextFormField(
                        controller: authVM.txtPassword.value,
                        obscureText: !authVM.isShowPasswordLogin.value,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Vui lòng nhập mật khẩu';
                          } else if (!validatePassword(value)) {
                            return 'Mật khẩu phải có ít nhất 8 kí tự bao gồm ký tự chữ hoa, chữ thường, chữ số';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: 'Mật khẩu',
                          errorMaxLines: 3,
                          suffixIcon: IconButton(
                            onPressed: () {
                              authVM.showPassword();
                            },
                            icon: Icon(authVM.isShowPasswordLogin.value
                                ? Icons.visibility
                                : Icons.visibility_off),
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                          ),
                          contentPadding: const EdgeInsets.all(10),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: const BorderSide(),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    //Ô nhập thông tin xác nhận mật khẩu
                    Obx(
                      () => TextFormField(
                        controller: authVM.txtConfirmPass.value,
                        obscureText: !authVM.isShowConfirmPassLogin.value,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Vui lòng nhập xác nhận mật khẩu';
                          } else if (value != authVM.txtPassword.value.text) {
                            return 'Mật khẩu xác nhận không khớp';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: 'Xác nhận mật khẩu',
                          suffixIcon: IconButton(
                            onPressed: () {
                              authVM.showConfirmPass();
                            },
                            icon: Icon(authVM.isShowConfirmPassLogin.value
                                ? Icons.visibility
                                : Icons.visibility_off),
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                          ),
                          contentPadding: const EdgeInsets.all(10),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: const BorderSide(),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),
                    Row(
                      children: [
                        //Nút đăng ký
                        Expanded(
                          flex: 1,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                authVM.serviceCallSignUp();
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              splashFactory: NoSplash.splashFactory,
                              elevation: 0,
                              shadowColor: Colors.transparent,
                            ).copyWith(
                              elevation: const MaterialStatePropertyAll(0),
                            ),
                            child: Text(
                              'Đăng Ký'.toUpperCase(),
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    RichText(
                      text: TextSpan(
                        text: 'Bạn đã có tài khoản? ',
                        style: const TextStyle(color: Colors.black),
                        children: [
                          //Nút đăng nhập ngay khi đã có tài khoản
                          TextSpan(
                            text: 'Đăng nhập ngay',
                            style: const TextStyle(color: Colors.blue),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginView()));
                              },
                          ),
                        ],
                      ),
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
