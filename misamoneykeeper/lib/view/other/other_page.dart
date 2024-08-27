import 'dart:async';
import 'package:misamoneykeeper_flutter/common/buttom_widget.dart';
import 'package:misamoneykeeper_flutter/controller/splash_view_model.dart';
import 'package:misamoneykeeper_flutter/utility/Colors.dart';
import 'package:misamoneykeeper_flutter/utility/export.dart';
import 'package:misamoneykeeper_flutter/view/info/information_view.dart';
import 'package:misamoneykeeper_flutter/view/report/report_details.dart';
import 'package:misamoneykeeper_flutter/view/split_money/split_money_view.dart';

class OtherPage extends StatefulWidget {
  const OtherPage({super.key});

  @override
  State<OtherPage> createState() => _OtherPageState();
}

class _OtherPageState extends State<OtherPage> {
  final splashVM = Get.find<SplashViewModel>();

  //Hàm reload lại trang
  Future<void> delayedFunction() async {
    await Future.delayed(const Duration(milliseconds: 100));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Container(
                color: Colors.white,
                padding: const EdgeInsets.all(10),
                //Khi nhấn vào sẽ ra trang thông tin của user
                child: TextButton(
                  onPressed: () {
                    Get.to(() => const InformationView());
                  },
                  style: TextButton.styleFrom(
                          animationDuration: Duration.zero,
                          splashFactory: NoSplash.splashFactory,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 10))
                      .copyWith(
                    overlayColor:
                        const MaterialStatePropertyAll(Colors.transparent),
                  ),
                  //Hiện thị ảnh và tên và email của user
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.grey,
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: ClipOval(
                            child: Image.asset(imgSaveMoney),
                          ),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${splashVM.userModel.value.firstName} '
                            '${splashVM.userModel.value.lastName}',
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          Text(
                            '${splashVM.userModel.value.email}',
                            style: const TextStyle(
                                fontSize: 15, color: Colors.black),
                          ),
                        ],
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                      child: Text(
                        'Tính năng',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                    //Hiện thị cách mục của tính năng
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 5),
                      child: GridView(
                        primary: false,
                        padding: const EdgeInsets.all(3),
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          crossAxisCount: 4,
                        ),
                        children: [
                          ButtomWidget(
                            color: RED,
                            image: imgInvoice,
                            scaleImage: 1.0,
                            text: tinhhinhthuchi,
                            onPressed: () {
                              Get.to(() => const ReportDetails(
                                    idx: 1,
                                  ));
                            },
                          ),
                          ButtomWidget(
                            color: AQUA,
                            image: imgShopping,
                            scaleImage: 1.3,
                            text: phantichchitieu,
                            onPressed: () {
                              Get.to(() => const ReportDetails(
                                    idx: 2,
                                  ));
                            },
                          ),
                          ButtomWidget(
                            color: ORANGE,
                            image: imgCalendar,
                            scaleImage: 0.8,
                            text: phantichthu,
                            onPressed: () {
                              Get.to(() => const ReportDetails(
                                    idx: 3,
                                  ));
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Container(
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                      child: Text(
                        'Tiện ích',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                    //Hiện thị các mục của tiện ích
                    GridView(
                      primary: false,
                      padding: const EdgeInsets.all(5),
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        crossAxisCount: 4,
                      ),
                      children: [
                        ButtomWidget(
                          color: LIGHT_BLUE,
                          image: imgMoneyBag,
                          scaleImage: 1,
                          text: splitmoney,
                          onPressed: () {
                            Get.to(() => const SplitMoneyView());
                          },
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
