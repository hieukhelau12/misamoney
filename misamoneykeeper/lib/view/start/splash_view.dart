import 'package:misamoneykeeper_flutter/controller/splash_view_model.dart';
import 'package:misamoneykeeper_flutter/utility/export.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final splashVM = Get.put(SplashViewModel());
  @override
  void initState() {
    startApp();
    super.initState();
  }

  void startApp() {
    Future.delayed(const Duration(seconds: 1), () {
      splashVM.loadView();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              //Hiện thị logo
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  icLogo,
                  width: 80,
                  fit: BoxFit.cover,
                ),
              ),
              10.heightBox,
              //Hiện thị text
              "Sổ Thu Chi MiSa"
                  .text
                  .size(16)
                  .fontFamily(sansBold)
                  .color(Colors.black.withOpacity(0.8))
                  .make()
            ]),
      ),
    );
  }
}
