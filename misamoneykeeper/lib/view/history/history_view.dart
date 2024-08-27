import 'package:misamoneykeeper_flutter/controller/history_view_model.dart';
import 'package:misamoneykeeper_flutter/controller/pay_view_model.dart';
import 'package:misamoneykeeper_flutter/server/globs.dart';
import 'package:misamoneykeeper_flutter/server/loading_indicator.dart';
import 'package:misamoneykeeper_flutter/utility/export.dart';
import 'package:misamoneykeeper_flutter/view/add/add_view.dart';
import 'package:misamoneykeeper_flutter/view/history/history_month.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({super.key});

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  var historyVM = Get.put(HistoryViewModel());
  DateTime now = DateTime.now();
  final payVM = Get.put(PayViewModel());

  //Hàm reload lại trang
  Future<void> delayedFunction() async {
    await Future.delayed(const Duration(milliseconds: 200));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          backgroundColor: Colors.blue,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back)),
          title: const Text(
            "Lịch Sử Ghi Chép",
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
            child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: SizedBox(
                    width: double.infinity,
                    child: Column(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              Get.to(() => const HistoryMonth(),
                                  transition: Transition.rightToLeft);
                            },
                            child: Obx(
                              () => (historyVM.isMonth.value == false
                                      ? "Tháng này"
                                      : historyVM.month.value == now.month
                                          ? "Tháng này"
                                          : "Tháng ${historyVM.month.value}")
                                  .text
                                  .size(16)
                                  .fontFamily(sansBold)
                                  .color(Colors.blue)
                                  .make(),
                            ),
                          ),
                          5.widthBox,
                          const Icon(
                            Icons.navigate_next,
                            color: Colors.blue,
                          )
                        ],
                      ).box.height(50).white.make(),
                      //Hiện thị lịch sử theo tháng
                      Obx(
                        () => FutureBuilder(
                            future: historyVM.isMonth.value == false
                                ? historyVM.serviceCallRecnetNote(now.month)
                                : historyVM.serviceCallRecnetNote(
                                    historyVM.month.value),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(child: loadingIndicator());
                              } else if (snapshot.hasError) {
                                return Container(
                                  color: Colors.amber,
                                );
                              } else if (snapshot.hasData &&
                                  snapshot.data!.isNotEmpty) {
                                var data = snapshot.data!;
                                var pay = 0;
                                var collect = 0;
                                for (var i = 0; i < data.length; i++) {
                                  if (data[i].pMoneyType == 1) {
                                    pay += data[i].pMoneyPay!;
                                  } else {
                                    collect += data[i].pMoneyCollect!;
                                  }
                                }
                                return Column(
                                  children: [
                                    // Tổng thu chi
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: context.screenWidth * 0.45,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              "Tổng Thu"
                                                  .text
                                                  .size(16)
                                                  .fontFamily(sansBold)
                                                  .color(Colors.black)
                                                  .make(),
                                              5.heightBox,
                                              (formatCurrency(collect))
                                                  .text
                                                  .size(16)
                                                  .color(Colors.green)
                                                  .fontFamily(sansBold)
                                                  .make()
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: context.screenWidth * 0.45,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              "Tổng Chi"
                                                  .text
                                                  .size(16)
                                                  .fontFamily(sansBold)
                                                  .color(Colors.black)
                                                  .make(),
                                              5.heightBox,
                                              (formatCurrency(pay))
                                                  .text
                                                  .size(16)
                                                  .color(Colors.red)
                                                  .fontFamily(sansBold)
                                                  .make()
                                            ],
                                          ),
                                        )
                                            .box
                                            .withDecoration(const BoxDecoration(
                                                border: Border(
                                                    left: BorderSide(
                                                        width: 1,
                                                        color: Color.fromARGB(
                                                            115,
                                                            222,
                                                            220,
                                                            220)))))
                                            .make()
                                      ],
                                    )
                                        .box
                                        .white
                                        .padding(const EdgeInsets.all(10))
                                        .margin(const EdgeInsets.symmetric(
                                            vertical: 10))
                                        .make(),
                                    //List ngày có lịch sử
                                    ListView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: data.length,
                                      itemBuilder: (context, index) {
                                        return Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 10),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10),
                                                    child:
                                                        "Ngày ${data[index].pDate}"
                                                            .text
                                                            .size(14)
                                                            .fontFamily(
                                                                sansBold)
                                                            .color(
                                                                Colors.black54)
                                                            .make(),
                                                  ),
                                                  Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      data[index].pMoneyPay != 0
                                                          ? (formatCurrency(data[
                                                                      index]
                                                                  .pMoneyPay))
                                                              .text
                                                              .size(14)
                                                              .color(Colors.red)
                                                              .fontFamily(
                                                                  sansBold)
                                                              .make()
                                                          : const SizedBox
                                                              .shrink(),
                                                      5.heightBox,
                                                      data[index].pMoneyCollect !=
                                                              0
                                                          ? (formatCurrency(data[
                                                                      index]
                                                                  .pMoneyCollect))
                                                              .text
                                                              .size(14)
                                                              .color(
                                                                  Colors.green)
                                                              .fontFamily(
                                                                  sansBold)
                                                              .make()
                                                          : const SizedBox
                                                              .shrink()
                                                    ],
                                                  )
                                                ],
                                              )
                                                  .box
                                                  .withDecoration(
                                                      const BoxDecoration(
                                                          border: Border(
                                                              bottom: BorderSide(
                                                                  width: 1,
                                                                  color: Color
                                                                      .fromARGB(
                                                                          115,
                                                                          222,
                                                                          220,
                                                                          220)),
                                                              left: BorderSide(
                                                                  width: 3,
                                                                  color: Colors
                                                                      .blue))))
                                                  .padding(const EdgeInsets
                                                      .symmetric(vertical: 5))
                                                  .make(),
                                            ),
                                            10.heightBox,
                                            //List các thu chi thêm trong ngày
                                            ListView.builder(
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              padding: const EdgeInsets.only(
                                                  left: 20,
                                                  right: 10,
                                                  bottom: 5),
                                              itemCount:
                                                  data[index].category!.length,
                                              itemBuilder: (context, index1) {
                                                return Row(
                                                  children: [
                                                    CircleAvatar(
                                                        backgroundColor:
                                                            const Color
                                                                .fromARGB(255,
                                                                229, 229, 229),
                                                        child: Image.network(
                                                          "${SVKey.mainUrl}${data[index].category![index1].cadImage!}",
                                                          width: 30,
                                                        )),
                                                    5.widthBox,
                                                    "${data[index].category![index1].categoryName}"
                                                        .text
                                                        .size(14)
                                                        .fontFamily(sansRegular)
                                                        .color(Colors.black87)
                                                        .make(),
                                                    const Spacer(),
                                                    Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        formatCurrency(
                                                                data[index]
                                                                    .category![
                                                                        index1]
                                                                    .pMoney)
                                                            .text
                                                            .size(14)
                                                            .color(data[index]
                                                                        .category![
                                                                            index1]
                                                                        .pType ==
                                                                    1
                                                                ? Colors.red
                                                                : Colors.green)
                                                            .fontFamily(
                                                                sansRegular)
                                                            .make(),
                                                        5.heightBox,
                                                        Row(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            const Icon(
                                                              Icons.abc,
                                                              weight: 10,
                                                              color: Colors
                                                                  .black54,
                                                            ),
                                                            2.widthBox,
                                                            "${data[index].category![index1].acName}"
                                                                .text
                                                                .size(12)
                                                                .color(Colors
                                                                    .black54)
                                                                .fontFamily(
                                                                    sansRegular)
                                                                .make()
                                                          ],
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                )
                                                    .box
                                                    .margin(const EdgeInsets
                                                        .symmetric(vertical: 4))
                                                    .make()
                                                    .onTap(() async {
                                                  //Khi ấn vào từng thu chi thì sẽ hiện ra bảng sửa thông tin
                                                  await Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          AddView(
                                                        isCheck: true,
                                                        payId: data[index]
                                                            .category![index1]
                                                            .payId,
                                                        categoryIcon:
                                                            SVKey.mainUrl +
                                                                data[index]
                                                                    .category![
                                                                        index1]
                                                                    .cadImage!,
                                                        categoryTitle: data[
                                                                index]
                                                            .category![index1]
                                                            .categoryName,
                                                        categoryDetailsId: data[
                                                                index]
                                                            .category![index1]
                                                            .categoryDetailsId,
                                                        accountIcon: data[index]
                                                            .category![index1]
                                                            .acType,
                                                        accountTitle: data[
                                                                index]
                                                            .category![index1]
                                                            .acName,
                                                        accountId: data[index]
                                                            .category![index1]
                                                            .accountId,
                                                        dateController: data[
                                                                index]
                                                            .category![index1]
                                                            .pDate,
                                                        moneyAccount: data[
                                                                index]
                                                            .category![index1]
                                                            .pMoney!
                                                            .toString(),
                                                        descriptionAccount:
                                                            data[index]
                                                                .category![
                                                                    index1]
                                                                .pExplanation,
                                                      ),
                                                    ),
                                                  ).then((value) {
                                                    delayedFunction();
                                                  });
                                                });
                                              },
                                            )
                                          ],
                                        )
                                            .box
                                            .white
                                            .margin(const EdgeInsets.only(
                                                bottom: 5))
                                            .make();
                                      },
                                    )
                                  ],
                                );
                              } else {
                                return Container(
                                  margin: const EdgeInsets.only(top: 50),
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          imgCoinBackGr,
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        const Text(
                                          'Không có ghi chép nào cả',
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                      ]),
                                );
                              }
                            }),
                      )
                    ])))));
  }
}
