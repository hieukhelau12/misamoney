import 'package:misamoneykeeper_flutter/common/validator.dart';
import 'package:misamoneykeeper_flutter/view/auth/signup.dart';
import 'package:misamoneykeeper_flutter/utility/export.dart';
import 'package:misamoneykeeper_flutter/controller/login_view_model.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final authVM = Get.put(LoginViewModel());
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
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
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
                const SizedBox(height: 30),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
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
                      const SizedBox(height: 10),
                      //Ô nhập mật khẩu
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
                      const SizedBox(height: 10),
                      // Nút Login
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  authVM.serviceCallLogin();
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
                                'Đăng nhập'.toUpperCase(),
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                      //Nút đăng ký
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                              onPressed: () {
                                Get.to(() => const SignUpView());
                              },
                              child: "Đăng ký"
                                  .text
                                  .size(16)
                                  .fontFamily(sansBold)
                                  .color(Colors.blue)
                                  .make())
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
