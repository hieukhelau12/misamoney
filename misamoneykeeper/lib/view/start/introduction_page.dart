import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:misamoneykeeper_flutter/common/exit_dialog.dart';
import 'package:misamoneykeeper_flutter/view/auth/login_view.dart';
import 'package:misamoneykeeper_flutter/view/auth/signup.dart';

class IntroductionPage extends StatefulWidget {
  const IntroductionPage({super.key});

  @override
  State<IntroductionPage> createState() => _IntroductionPageState();
}

class _IntroductionPageState extends State<IntroductionPage> {
  List<Map<String, String>> listData = [
    {
      "image": 'assets/images/image_1.png',
      "description":
          "Chào mừng đến với Sổ Thu Chi MISA. Trải nghiệm niềm vui quản lý tài chính bằng việc đăng ký trong lần đầu sử dụng"
    },
    {
      "image": 'assets/images/image_2.png',
      "description": "Kiểm soát thu chi, nhắm thẳng mục tiêu về tài chính"
    },
    {
      "image": 'assets/images/image_3.png',
      "description":
          "Hưởng thụ cuộc sống thoải mái, tự do tài chính với người thân, bạn bè"
    }
  ];

  Color? getColor(Set<MaterialState> states) {
    if (states.contains(MaterialState.pressed)) {
      return Colors.grey;
    }
    return Colors.blue;
  }

  @override
  void initState() {
    super.initState();
  }

  Future<bool> _onWillPop(BuildContext context) async {
    bool? exitResult = await showDialog(
      context: context,
      builder: (context) => const ExitConfirmationDialog(),
    );
    return exitResult ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  //Hiện thị phần giới thiệu (slide)
                  Expanded(
                    flex: 3,
                    child: PageView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: listData.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            //Hiện thị ảnh
                            Expanded(
                              flex: 4,
                              child: Image.asset(
                                listData[index]['image']!,
                              ),
                            ),
                            //Hiện thị thông tin tương ứng
                            Expanded(
                              flex: 1,
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Text(
                                  listData[index]['description']!,
                                  style: const TextStyle(
                                    fontSize: 18,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  //Hiện thị nút ấn đăng ký
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Get.to(() => const SignUpView());
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 63, 164, 247),
                            foregroundColor: Colors.white,
                            splashFactory: NoSplash.splashFactory,
                            elevation: 0,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32),
                            ),
                            padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
                          ).copyWith(
                              elevation: const MaterialStatePropertyAll(0)),
                          child: Text(
                            "Đăng ký tài khoản mới".toUpperCase(),
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                        //Hiện thị nút ấn đăng nhập
                        TextButton(
                          onPressed: () {
                            Get.to(() => const LoginView());
                          },
                          style: ButtonStyle(
                            animationDuration: Duration.zero,
                            foregroundColor: MaterialStateProperty.resolveWith(
                              getColor,
                            ),
                            splashFactory: NoSplash.splashFactory,
                          ).copyWith(
                            overlayColor: const MaterialStatePropertyAll(
                                Colors.transparent),
                          ),
                          child: Text(
                            'Đăng nhập'.toUpperCase(),
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
