import 'package:intl/intl.dart';
import 'package:misamoneykeeper_flutter/common/chart_data.dart';
import 'package:misamoneykeeper_flutter/controller/status_collect_view_model.dart';
import 'package:misamoneykeeper_flutter/model/charts_data.dart';
import 'package:misamoneykeeper_flutter/server/globs.dart';
import 'package:misamoneykeeper_flutter/server/loading_indicator.dart';
import 'package:misamoneykeeper_flutter/utility/export.dart';
import 'package:misamoneykeeper_flutter/view/add/add_view.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class StatusCollect extends StatefulWidget {
  const StatusCollect({super.key});

  @override
  State<StatusCollect> createState() => _StatusCollectState();
}

var statusCollectVM = Get.put(StatusCollectViewModel());

class _StatusCollectState extends State<StatusCollect> {
  //Hàm reload lại trang
  Future<void> delayedFunction() async {
    await Future.delayed(const Duration(milliseconds: 200));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: statusCollectVM.serviceCallStatusCollect(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: loadingIndicator());
            } else if (snapshot.hasError) {
              return Container(
                color: Colors.amber,
              );
            } else if (snapshot.hasData) {
              var data = snapshot.data!;
              var isLoading = false.obs;
              var sum = 0;
              for (var element in data) {
                sum += element.sumMoney!;
              }
              var money = formatCurrency(sum);
              // Tạo mảng dữ liệu chart data
              final List<ChartData> chartData = data.map((collect) {
                return ChartData(collect.caName!, collect.sumMoney!.toDouble(),
                    getRandomColor());
              }).toList();
              return Column(
                children: [
                  10.heightBox,
                  SizedBox(
                    height: context.screenHeight * 0.25,
                    //Hiện thị biểu đồ tròn
                    child: SfCircularChart(
                      series: <CircularSeries>[
                        DoughnutSeries<ChartData, String>(
                          dataSource: chartData,
                          pointColorMapper: (ChartData data, _) => data.color,
                          xValueMapper: (ChartData data, _) => data.x,
                          yValueMapper: (ChartData data, _) => data.y,
                        ),
                      ],
                      legend: Legend(
                        isVisible: true,
                        position: LegendPosition.right,
                        legendItemBuilder:
                            (legendText, series, point, seriesIndex) {
                          final ChartData data = chartData[seriesIndex];
                          return Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 15,
                                height: 15,
                                decoration: BoxDecoration(
                                    color: data.color,
                                    borderRadius: const BorderRadius.all(
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
                    ),
                  ),
                  10.heightBox,
                  const Divider(
                    height: 1,
                    color: Colors.black12,
                    indent: 10,
                    endIndent: 10,
                    thickness: 1,
                  ),
                  10.heightBox,
                  //Hiện thị tổng thu
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      "Tổng Thu:"
                          .text
                          .size(16)
                          .color(Colors.black)
                          .fontFamily(sansBold)
                          .make(),
                      money.text
                          .size(16)
                          .color(Colors.green)
                          .fontFamily(sansBold)
                          .make(),
                    ],
                  )
                      .box
                      .color(Colors.white)
                      .padding(const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10))
                      .make(),
                  10.heightBox,
                  //Hiện thị list chi tiết các mục đã thu
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(left: 10),
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                  backgroundColor:
                                      const Color.fromARGB(255, 229, 229, 229),
                                  child: Image.network(
                                    "${SVKey.mainUrl}${data[0].categoryDetails![index].cadImage!}",
                                    width: 30,
                                  )),
                              10.widthBox,
                              "${data[0].categoryDetails![index].cadName}"
                                  .text
                                  .size(16)
                                  .fontFamily(sansBold)
                                  .color(Colors.black87)
                                  .make(),
                              const Spacer(),
                              formatCurrency(
                                      data[0].categoryDetails![index].sumMoney)
                                  .text
                                  .size(14)
                                  .color(Colors.green)
                                  .fontFamily(sansBold)
                                  .make(),
                              5.widthBox,
                              IconButton(
                                  onPressed: () {
                                    isLoading.value = !isLoading.value;
                                  },
                                  icon: const Icon(Icons.navigate_next))
                            ],
                          )
                              .box
                              .margin(const EdgeInsets.symmetric(vertical: 2))
                              .make(),
                          Obx(
                            () => isLoading.value == true
                                ? ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 20),
                                    itemCount: data[0]
                                        .categoryDetails![index]
                                        .pay!
                                        .length,
                                    itemBuilder: (context, index1) {
                                      final formatter =
                                          DateFormat('dd/MM/yyyy');
                                      DateTime date = DateTime.parse(data[0]
                                          .categoryDetails![index]
                                          .pay![index1]
                                          .pDate!);
                                      String dateString =
                                          formatter.format(date);
                                      return Row(
                                        children: [
                                          dateString.text
                                              .size(16)
                                              .fontFamily(sansRegular)
                                              .color(Colors.black87)
                                              .make(),
                                          const Spacer(),
                                          Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              formatCurrency(data[0]
                                                      .categoryDetails![index]
                                                      .pay![index1]
                                                      .pMoney)
                                                  .text
                                                  .size(14)
                                                  .color(Colors.black)
                                                  .fontFamily(sansRegular)
                                                  .make(),
                                              5.heightBox,
                                              const Icon(
                                                Icons.wallet,
                                                size: 20,
                                                color: Colors.black54,
                                              )
                                            ],
                                          )
                                        ],
                                      )
                                          .box
                                          .margin(const EdgeInsets.symmetric(
                                              vertical: 2))
                                          .make()
                                          //Khi nhấn vào từng mục thì sẽ hiện ra form để sửa thông tin
                                          .onTap(() {
                                        Get.to(
                                                () => AddView(
                                                      isCheck: true,
                                                      payId: data[0]
                                                          .categoryDetails![
                                                              index]
                                                          .pay![index1]
                                                          .payId,
                                                      pType: data[0]
                                                          .categoryDetails![
                                                              index]
                                                          .pay![index1]
                                                          .pType,
                                                      categoryIcon: SVKey
                                                              .mainUrl +
                                                          data[0]
                                                              .categoryDetails![
                                                                  index]
                                                              .pay![index1]
                                                              .cadImage!,
                                                      categoryTitle: data[0]
                                                          .categoryDetails![
                                                              index]
                                                          .pay![index1]
                                                          .categoryName,
                                                      categoryDetailsId: data[0]
                                                          .categoryDetails![
                                                              index]
                                                          .pay![index1]
                                                          .categoryDetailsId,
                                                      accountIcon: data[0]
                                                          .categoryDetails![
                                                              index]
                                                          .pay![index1]
                                                          .acType,
                                                      accountTitle: data[0]
                                                          .categoryDetails![
                                                              index]
                                                          .pay![index1]
                                                          .acName,
                                                      accountId: data[0]
                                                          .categoryDetails![
                                                              index]
                                                          .pay![index1]
                                                          .accountId,
                                                      dateController: data[0]
                                                          .categoryDetails![
                                                              index]
                                                          .pay![index1]
                                                          .pDate,
                                                      moneyAccount: data[0]
                                                          .categoryDetails![
                                                              index]
                                                          .pay![index1]
                                                          .pMoney!
                                                          .toString(),
                                                      descriptionAccount:
                                                          data[0]
                                                              .categoryDetails![
                                                                  index]
                                                              .pay![index1]
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
                                : const SizedBox.shrink(),
                          ),
                        ],
                      );
                    },
                  ),
                  10.heightBox,
                ],
              );
            } else {
              return Container(
                color: Colors.amber,
              );
            }
          },
        ),
      ),
    );
  }
}
