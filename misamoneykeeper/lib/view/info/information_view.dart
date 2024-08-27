import 'package:misamoneykeeper_flutter/controller/splash_view_model.dart';
import 'package:misamoneykeeper_flutter/utility/export.dart';
import 'package:misamoneykeeper_flutter/view/info/change_info_view.dart';
import 'package:misamoneykeeper_flutter/view/info/change_password_view.dart';

class InformationView extends StatefulWidget {
  const InformationView({super.key});

  @override
  InformationViewState createState() => InformationViewState();
}

class InformationViewState extends State<InformationView> {
  final splashVM = Get.find<SplashViewModel>();

  //Hàm reload lại trang
  Future<void> delayedFunction() async {
    await Future.delayed(const Duration(milliseconds: 100));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          //Hiện thị ảnh và tên và email của user
          child: Column(
            children: [
              const SizedBox(height: 20),
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(5), // Border radius
                  child: ClipOval(
                    child: Image.asset(imgUser),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                '${splashVM.userModel.value.firstName} '
                '${splashVM.userModel.value.lastName}',
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              const SizedBox(height: 10),
              Text('${splashVM.userModel.value.email}',
                  style: const TextStyle(fontSize: 15, color: Colors.black)),
              const SizedBox(height: 10),
              //Khi nhấn vào nút thì sẽ hiện thị ra trang thay đổi thông tin
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ChangeInfoView()),
                  ).then((value) {
                    delayedFunction();
                  });
                },
                style: TextButton.styleFrom(
                  elevation: 0,
                  side: const BorderSide(
                    color: Colors.grey,
                    width: 1,
                  ),
                  animationDuration: Duration.zero,
                  backgroundColor: Colors.white,
                  padding: const EdgeInsets.all(0),
                  splashFactory: NoSplash.splashFactory,
                ).copyWith(
                  overlayColor:
                      const MaterialStatePropertyAll(Colors.transparent),
                ),
                child: const Text(
                  'SỬA',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              const SizedBox(height: 50),
              //Khi nhấn vào nút thì sẽ hiện thị ra trang thay đổi mật khẩu mới
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ChangePasswordView()),
                  );
                },
                style: TextButton.styleFrom(
                  animationDuration: Duration.zero,
                  padding: const EdgeInsets.all(0),
                  splashFactory: NoSplash.splashFactory,
                ).copyWith(
                  overlayColor:
                      const MaterialStatePropertyAll(Colors.transparent),
                ),
                child: const Row(
                  children: [
                    Text(
                      'Đổi mật khẩu',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    Spacer(),
                    Icon(
                      Icons.navigate_next,
                      color: Colors.grey,
                    )
                  ],
                ),
              ),
              const Divider(
                thickness: 0.7,
                height: 0.4,
              ),
              //Khi nhấn vào nút thì sẽ đăng xuất
              TextButton(
                onPressed: () {
                  splashVM.logout();
                },
                style: TextButton.styleFrom(
                  animationDuration: Duration.zero,
                  padding: const EdgeInsets.all(0),
                  splashFactory: NoSplash.splashFactory,
                ).copyWith(
                  overlayColor:
                      const MaterialStatePropertyAll(Colors.transparent),
                ),
                child: const Row(
                  children: [
                    Text(
                      'Đăng xuất',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    Spacer(),
                    Icon(
                      Icons.navigate_next,
                      color: Colors.grey,
                    )
                  ],
                ),
              ),
              const Divider(
                thickness: 0.7,
                height: 0.4,
              )
            ],
          ),
        ),
      ),
    );
  }
}
