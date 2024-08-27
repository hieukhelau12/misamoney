import 'package:misamoneykeeper_flutter/controller/pay_account_view_model.dart';
import 'package:misamoneykeeper_flutter/controller/collect_view_model.dart';
import 'package:misamoneykeeper_flutter/controller/pay_view_model.dart';
import 'package:misamoneykeeper_flutter/model/account_model.dart';
import 'package:misamoneykeeper_flutter/server/loading_indicator.dart';
import 'package:misamoneykeeper_flutter/utility/export.dart';

class PayAccountDetails extends StatelessWidget {
  final int type;
  const PayAccountDetails({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    var payAccount = Get.put(PayAccountViewModel());
    final payVM = Get.find<PayViewModel>();
    final payVM1 = Get.find<CollectViewModel>();
    return Scaffold(
      appBar: AppBar(
        title: "Chọn tài khoản".text.size(18).white.fontFamily(sansBold).make(),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: payAccount.serviceCallAccount(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: loadingIndicator());
          } else if (snapshot.hasError) {
            return Container(
              color: Colors.amber,
            );
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            var data = snapshot.data!;
            List<AccountModel> listData = [];
            for (var element in data) {
              if (element.acType! == 1 || element.acType! == 2) {
                listData.add(element);
              }
            }
            //Hiện thị danh sách tài sản trừ tài sản cố định
            return ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemCount: listData.length,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                        child: data[index].acType! == 1
                            ? const Icon(
                                Icons.account_balance_wallet,
                                size: 25,
                                color: Colors.white,
                              )
                            : const Icon(
                                Icons.account_balance,
                                size: 25,
                                color: Colors.white,
                              )),
                    15.widthBox,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ("${listData[index].acName}")
                            .text
                            .size(16)
                            .color(Colors.black45)
                            .fontFamily(sansBold)
                            .make(),
                        3.heightBox,
                        formatCurrency(listData[index].acMoney)
                            .text
                            .size(14)
                            .fontFamily(sansRegular)
                            .color(Colors.blue[200])
                            .make(),
                      ],
                    ),
                    const Spacer(),
                    listData[index].accountId == payVM.accountId.value
                        ? const Icon(
                            Icons.check_box_rounded,
                            color: Colors.blue,
                          )
                        : const SizedBox.shrink(),
                  ],
                )
                    .box
                    .padding(const EdgeInsets.symmetric(vertical: 5))
                    .margin(const EdgeInsets.symmetric(vertical: 5))
                    .make()
                    .onTap(() {
                  if (type == 1) {
                    payVM.accountIcon.value = listData[index].acType!;
                    payVM.accountTitle.value = listData[index].acName!;
                    payVM.accountId.value = listData[index].accountId!;
                  } else {
                    payVM1.accountIcon.value = listData[index].acType!;
                    payVM1.accountTitle.value = listData[index].acName!;
                    payVM1.accountId.value = listData[index].accountId!;
                  }

                  Get.back();
                });
              },
            );
          } else {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(imgCoinBackGr),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  'Không có tài khoản nào!!',
                  style: TextStyle(fontSize: 15, color: Colors.grey[500]),
                ),
              ],
            ));
          }
        },
      ),
    );
  }
}
