import 'package:misamoneykeeper_flutter/controller/home_account_view_model.dart';
import 'package:misamoneykeeper_flutter/server/loading_indicator.dart';
import 'package:misamoneykeeper_flutter/utility/export.dart';
import 'package:misamoneykeeper_flutter/view/add/add_view.dart';

class HomeAccount extends StatefulWidget {
  const HomeAccount({super.key});

  @override
  State<HomeAccount> createState() => _HomeAccountState();
}

var homeAccountVM = Get.put(HomeAccountViewModel());

class _HomeAccountState extends State<HomeAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: "Tài Khoản".text.size(18).white.fontFamily(sansBold).make(),
          centerTitle: true,
        ),
        body: FutureBuilder(
          future: homeAccountVM.serviceCallHomeAccount(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: loadingIndicator());
            } else if (snapshot.hasError) {
              return Container(
                color: Colors.amber,
              );
            } else if (snapshot.hasData) {
              var data = snapshot.data!;
              return data.isNotEmpty
                  //Hiện thị list tài khoản của user
                  ? ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      itemCount: data.length,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 5),
                      separatorBuilder: (context, index) {
                        return const Divider(
                          height: 1,
                          thickness: 1,
                          color: Colors.black26,
                        );
                      },
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              padding: const EdgeInsets.all(8),
                              decoration: const BoxDecoration(
                                  color: Colors.amber, shape: BoxShape.circle),
                              child: data[index].acType == 1
                                  ? const Icon(
                                      Icons.account_balance_wallet,
                                      size: 25,
                                      color: Colors.white,
                                    )
                                  : data[index].acType == 3
                                      ? const Icon(
                                          Icons.two_wheeler,
                                          size: 25,
                                          color: Colors.white,
                                        )
                                      : const Icon(
                                          Icons.account_balance,
                                          size: 25,
                                          color: Colors.white,
                                        ),
                            ),
                            15.widthBox,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ("${data[index].acName}")
                                    .text
                                    .size(16)
                                    .color(Colors.black45)
                                    .fontFamily(sansBold)
                                    .make(),
                                3.heightBox,
                                formatCurrency(data[index].acMoney)
                                    .text
                                    .size(14)
                                    .fontFamily(sansRegular)
                                    .color(Colors.blue[200])
                                    .make(),
                              ],
                            ),
                            const Spacer(),
                            IconButton(
                                onPressed: () {
                                  Get.to(
                                      () => AddView(
                                            isCheck: false,
                                            accountIcon: data[index].acType,
                                            accountTitle: data[index].acName,
                                            accountId: data[index].accountId,
                                          ),
                                      transition: Transition.rightToLeft);
                                },
                                icon: const Icon(Icons.navigate_next))
                          ],
                        )
                            .box
                            .padding(const EdgeInsets.symmetric(vertical: 5))
                            .margin(const EdgeInsets.symmetric(vertical: 5))
                            .make()
                            .onTap(() {});
                      },
                    )
                  : Center(
                      child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(imgCoinBackGr),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Không có tài khoản nào!!',
                          style:
                              TextStyle(fontSize: 15, color: Colors.grey[500]),
                        ),
                      ],
                    ));
            } else {
              return Container(
                color: const Color.fromARGB(255, 223, 199, 128),
              );
            }
          },
        ));
  }
}
