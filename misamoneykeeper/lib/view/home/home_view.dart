import 'package:intl/intl.dart';
import 'package:misamoneykeeper_flutter/common/chart_data.dart';
import 'package:misamoneykeeper_flutter/controller/home_view_model.dart';
import 'package:misamoneykeeper_flutter/controller/splash_view_model.dart';
import 'package:misamoneykeeper_flutter/model/account_model.dart';
import 'package:misamoneykeeper_flutter/model/charts_data.dart';
import 'package:misamoneykeeper_flutter/model/home_status_model.dart';
import 'package:misamoneykeeper_flutter/model/recnet_note_home.dart';
import 'package:misamoneykeeper_flutter/server/globs.dart';
import 'package:misamoneykeeper_flutter/server/loading_indicator.dart';
import 'package:misamoneykeeper_flutter/utility/export.dart';
import 'package:misamoneykeeper_flutter/view/add/add_view.dart';
import 'package:misamoneykeeper_flutter/view/history/history_view.dart';
import 'package:misamoneykeeper_flutter/view/home/home_account.dart';
import 'package:misamoneykeeper_flutter/view/pay_collect_status/status_main.dart';
import 'package:rxdart/rxdart.dart' as rxdart;
import 'package:syncfusion_flutter_charts/charts.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final splashVM = Get.find<SplashViewModel>();
  late HomeViewModel homeViewModel;

  //Hàm để khởi tạo trạng thái ban đầu của widget
  @override
  void initState() {
    super.initState();
    homeViewModel = Get.put(HomeViewModel());
  }

  //Hàm để giải phóng tài nguyên mà một đối tượng đã sử dụng
  @override
  void dispose() {
    Get.delete<HomeViewModel>();
    super.dispose();
  }

  //Hàm reload lại trang
  Future<void> delayedFunction() async {
    await Future.delayed(const Duration(milliseconds: 200));
    setState(() {
      homeViewModel = Get.put(HomeViewModel());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: StreamBuilder<List<List>?>(
        stream: rxdart.CombineLatestStream.combine3(
            homeViewModel.streamAccount.stream,
            homeViewModel.streamHomeStatus.stream,
            homeViewModel.streamRecnetNoteHome.stream,
            (account, status, recnetNoteHome) {
          return [account, status, recnetNoteHome];
        }),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: loadingIndicator());
          } else if (snapshot.hasError) {
            return Container(
              color: Colors.amber,
            );
          } else if (snapshot.hasData) {
            //Lưu các dữ liệu từ server trả về
            List<AccountModel>? account =
                snapshot.data?[0] as List<AccountModel>?;
            List<HomeStatusModel>? status =
                snapshot.data?[1] as List<HomeStatusModel>?;
            List<RecnetNoteHome>? recnetNoteHome =
                snapshot.data?[2] as List<RecnetNoteHome>?;
            int sum = 0;
            if (account!.isEmpty) {
              sum = 0;
            } else {
              for (var element in account) {
                sum += element.acMoney!;
              }
            }

            var money = formatCurrency(sum);

            // Tạo mảng dữ liệu chart data
            final List<ChartData> chartData =
                status![0].category!.map((category) {
              return ChartData(category.caName!, category.sumMoney!.toDouble(),
                  getRandomColor());
            }).toList();

            return SafeArea(
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    Container(
                      height: 180,
                      color: Colors.blue,
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              40.heightBox,
                              //Hiện thị chào tên user
                              Row(
                                children: [
                                  20.widthBox,
                                  Text(
                                    'Xin chào, ${splashVM.userModel.value.lastName}',
                                    style: const TextStyle(
                                      fontSize: 24,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              20.heightBox,
                              //Hiện thị tổng số dư của user
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: ElevatedButton(
                                  onPressed: () {
                                    Get.to(() => const HomeAccount(),
                                        transition: Transition.rightToLeft);
                                  },
                                  style: TextButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    splashFactory: NoSplash.splashFactory,
                                    elevation: 0,
                                    shadowColor: Colors.transparent,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 10),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Tổng Số Dư : ',
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.grey),
                                          ),
                                          Text(
                                            money,
                                            style: const TextStyle(
                                              fontSize: 20,
                                              color: Colors.indigo,
                                            ),
                                          )
                                        ],
                                      ),
                                      const Spacer(),
                                      const Icon(
                                        Icons.arrow_forward,
                                        color: Colors.grey,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    10.heightBox,
                    // Tình hình thu chi
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Tình hình thu chi',
                            style: TextStyle(fontSize: 18.0),
                          ),
                          10.heightBox,
                          status[0].sum != null && status[0].sum!.isNotEmpty
                              ? SizedBox(
                                  height: 150,
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Container(
                                        color:
                                            status[0].sum![0].pMoneyCollect! >
                                                    status[0].sum![0].pMoneyPay!
                                                ? Colors.green
                                                : Colors.red,
                                        width: 30,
                                      ),
                                      10.widthBox,
                                      Container(
                                        color:
                                            status[0].sum![0].pMoneyCollect! >
                                                    status[0].sum![0].pMoneyPay!
                                                ? Colors.red
                                                : Colors.green,
                                        width: 30,
                                        height: 80,
                                      ),
                                      30.widthBox,
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Container(
                                                  width: 15,
                                                  height: 15,
                                                  decoration:
                                                      const BoxDecoration(
                                                          color: Colors.green,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          15))),
                                                ),
                                                5.widthBox,
                                                "Thu"
                                                    .text
                                                    .size(14)
                                                    .fontFamily(sansRegular)
                                                    .color(Colors.black)
                                                    .make(),
                                                const Spacer(),
                                                formatCurrency(status[0]
                                                        .sum![0]
                                                        .pMoneyCollect!)
                                                    .text
                                                    .size(14)
                                                    .fontFamily(sansBold)
                                                    .color(Colors.green)
                                                    .make(),
                                              ],
                                            ),
                                            20.heightBox,
                                            Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Container(
                                                  width: 15,
                                                  height: 15,
                                                  decoration:
                                                      const BoxDecoration(
                                                          color: Colors.red,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          15))),
                                                ),
                                                5.widthBox,
                                                "Chi"
                                                    .text
                                                    .size(16)
                                                    .fontFamily(sansRegular)
                                                    .color(Colors.black)
                                                    .make(),
                                                const Spacer(),
                                                formatCurrency(status[0]
                                                        .sum![0]
                                                        .pMoneyPay!)
                                                    .text
                                                    .size(14)
                                                    .fontFamily(sansBold)
                                                    .color(Colors.red)
                                                    .make(),
                                              ],
                                            ),
                                            10.heightBox,
                                            const Divider(
                                              color: Colors.black12,
                                              height: 1,
                                              indent: 20,
                                              thickness: 2,
                                            ),
                                            10.heightBox,
                                            Align(
                                              alignment: Alignment.centerRight,
                                              child: formatCurrency((status[0]
                                                          .sum![0]
                                                          .pMoneyCollect! -
                                                      status[0]
                                                          .sum![0]
                                                          .pMoneyPay!))
                                                  .text
                                                  .size(14)
                                                  .fontFamily(sansBold)
                                                  .color(Colors.black)
                                                  .make(),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ))
                              : const Center(
                                  child: Column(
                                  children: [
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      'Không có dữ liệu',
                                      style: TextStyle(
                                          fontSize: 14.0,
                                          color: Colors.black12),
                                    ),
                                  ],
                                )),
                          30.heightBox,
                          const Divider(
                            color: Colors.black12,
                            height: 1,
                            thickness: 2,
                          ),
                          10.heightBox,
                          "Biểu đồ thu chi"
                              .text
                              .size(18)
                              .fontFamily(sansBold)
                              .color(Colors.black)
                              .make(),
                          //Biều đồ hình tròn diễn đạt thu chi
                          chartData.isNotEmpty
                              ? SfCircularChart(
                                  series: <CircularSeries>[
                                    DoughnutSeries<ChartData, String>(
                                      dataSource: chartData,
                                      pointColorMapper: (ChartData data, _) =>
                                          data.color,
                                      xValueMapper: (ChartData data, _) =>
                                          data.x,
                                      yValueMapper: (ChartData data, _) =>
                                          data.y,
                                    ),
                                  ],
                                  legend: Legend(
                                    isVisible: true,
                                    position: LegendPosition.right,
                                    legendItemBuilder: (legendText, series,
                                        point, seriesIndex) {
                                      final ChartData data =
                                          chartData[seriesIndex];
                                      return Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Container(
                                            width: 15,
                                            height: 15,
                                            decoration: BoxDecoration(
                                                color: data.color,
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(15))),
                                          ),
                                          5.widthBox,
                                          data.x.text
                                              .size(14)
                                              .fontFamily(sansRegular)
                                              .color(Colors.black)
                                              .make(),
                                          5.widthBox,
                                          "(${formatCurrency(data.y.toInt())})"
                                              .text
                                              .size(14)
                                              .fontFamily(sansRegular)
                                              .color(Colors.black)
                                              .make(),
                                        ],
                                      );
                                    },
                                  ),
                                )
                              : const Center(
                                  child: Column(
                                  children: [
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      'Không có dữ liệu',
                                      style: TextStyle(
                                          fontSize: 14.0,
                                          color: Colors.black12),
                                    ),
                                  ],
                                )),
                          //Xem chi tiết các thu chi
                          Align(
                            alignment: Alignment.bottomRight,
                            child: TextButton(
                              onPressed: () {
                                Get.delete<HomeViewModel>();
                                Get.to(() => const StatusMain(),
                                        transition: Transition.rightToLeft)
                                    ?.then((value) {
                                  delayedFunction();
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.blue,
                                backgroundColor: Colors.white,
                              ),
                              child: const Text('Xem chi tiết >'),
                            ),
                          )
                        ],
                      ),
                    ),
                    10.heightBox,
                    // Ghi chép gần đây
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Ghi chép gần đây',
                            style: TextStyle(fontSize: 18.0),
                          ),
                          recnetNoteHome!.isNotEmpty
                              ? ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 5),
                                  itemCount: recnetNoteHome.length,
                                  itemBuilder: (context, index) {
                                    final formatter = DateFormat('dd/MM/yyyy');
                                    DateTime date = DateTime.parse(
                                        recnetNoteHome[index].pDate!);
                                    String dateString = formatter.format(date);
                                    return Row(
                                      children: [
                                        CircleAvatar(
                                            backgroundColor:
                                                const Color.fromARGB(
                                                    255, 229, 229, 229),
                                            child: Image.network(
                                              "${SVKey.mainUrl}${recnetNoteHome[index].cadImage}",
                                              width: 30,
                                            )),
                                        10.widthBox,
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            "${recnetNoteHome[index].categoryName}"
                                                .text
                                                .size(16)
                                                .fontFamily(sansBold)
                                                .color(Colors.black87)
                                                .make(),
                                            4.heightBox,
                                            dateString.text
                                                .size(12)
                                                .fontFamily(sansItalic)
                                                .color(Colors.black87)
                                                .make(),
                                          ],
                                        ),
                                        const Spacer(),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            formatCurrency(recnetNoteHome[index]
                                                    .pMoney)
                                                .text
                                                .size(16)
                                                .color(recnetNoteHome[index]
                                                            .pType ==
                                                        1
                                                    ? Colors.red
                                                    : Colors.green)
                                                .fontFamily(sansBold)
                                                .make(),
                                            5.heightBox,
                                            Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                const Icon(
                                                  Icons.abc,
                                                  weight: 10,
                                                  color: Colors.black54,
                                                ),
                                                2.widthBox,
                                                "${recnetNoteHome[index].acName}"
                                                    .text
                                                    .size(12)
                                                    .color(Colors.black54)
                                                    .fontFamily(sansRegular)
                                                    .make()
                                              ],
                                            )
                                          ],
                                        )
                                      ],
                                    )
                                        .box
                                        .margin(const EdgeInsets.symmetric(
                                            vertical: 4))
                                        .make()
                                        .onTap(() {
                                      Get.delete<HomeViewModel>();
                                      Get.to(
                                              () => AddView(
                                                    isCheck: true,
                                                    payId: recnetNoteHome[index]
                                                        .payId,
                                                    pType: recnetNoteHome[index]
                                                        .pType,
                                                    categoryIcon: SVKey
                                                            .mainUrl +
                                                        recnetNoteHome[index]
                                                            .cadImage!,
                                                    categoryTitle:
                                                        recnetNoteHome[index]
                                                            .categoryName,
                                                    categoryDetailsId:
                                                        recnetNoteHome[index]
                                                            .categoryDetailsId,
                                                    accountIcon:
                                                        recnetNoteHome[index]
                                                            .acType,
                                                    accountTitle:
                                                        recnetNoteHome[index]
                                                            .acName,
                                                    accountId:
                                                        recnetNoteHome[index]
                                                            .accountId,
                                                    dateController:
                                                        recnetNoteHome[index]
                                                            .pDate,
                                                    moneyAccount:
                                                        recnetNoteHome[index]
                                                            .pMoney!
                                                            .toString(),
                                                    descriptionAccount:
                                                        recnetNoteHome[index]
                                                            .pExplanation,
                                                  ),
                                              transition:
                                                  Transition.rightToLeft)
                                          ?.then((value) {
                                        delayedFunction();
                                      });
                                    });
                                  },
                                )
                              : const Center(
                                  child: Column(
                                  children: [
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      'Không có dữ liệu',
                                      style: TextStyle(
                                          fontSize: 14.0,
                                          color: Colors.black12),
                                    ),
                                  ],
                                )),
                          10.heightBox,
                          //Xem lịch sử thu chi gần đây chi tiết
                          Align(
                            alignment: Alignment.bottomRight,
                            child: TextButton(
                              onPressed: () {
                                Get.delete<HomeViewModel>();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const HistoryView())).then((value) {
                                  delayedFunction();
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.blue,
                                backgroundColor: Colors.white,
                              ),
                              child: const Text('Lịch sử ghi chép >'),
                            ),
                          )
                        ],
                      ),
                    ),
                    30.heightBox
                  ],
                ),
              ),
            );
          } else {
            return Container(
              color: const Color.fromARGB(255, 63, 52, 18),
            );
          }
        },
      ),
    );
  }
}
