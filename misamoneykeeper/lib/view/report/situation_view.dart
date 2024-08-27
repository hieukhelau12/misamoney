import 'package:misamoneykeeper_flutter/controller/spending_view_model.dart';
import 'package:misamoneykeeper_flutter/model/spending_money.dart';
import 'package:misamoneykeeper_flutter/server/loading_indicator.dart';
import 'package:misamoneykeeper_flutter/utility/export.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SituationView extends StatefulWidget {
  const SituationView({super.key});

  @override
  State<SituationView> createState() => _SituationViewState();
}

class _SituationViewState extends State<SituationView>
    with TickerProviderStateMixin {
  late SpendingVM spendingVM;
  late List<SpendingMoney> data = [];
  late TooltipBehavior _tooltip;
  bool hasZeroValue = false;
  DateTime _selectedYear = DateTime.now();
  bool isListViewVisible = false;

  //Hàm hiện thị bottom bar chọn năm
  selectYear(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Chọn năm"),
            content: SizedBox(
              height: 300,
              width: 300,
              child: YearPicker(
                  firstDate: DateTime(DateTime.now().year - 20),
                  lastDate: DateTime(DateTime.now().year + 50),
                  currentDate: _selectedYear,
                  selectedDate: _selectedYear,
                  onChanged: (DateTime dateTime) {
                    setState(() {
                      _selectedYear = dateTime;
                      spendingVM.txtYear = dateTime.year.toString();
                    });
                    fetchDataFromServer();
                    Navigator.pop(context);
                  }),
            ),
          );
        });
  }

  //Hàm để ẩn/hiện list tổng chi của các tháng
  void toggleListViewVisibility() {
    setState(() {
      isListViewVisible = !isListViewVisible;
    });
  }

  List<SpendingMoney> newData = [];
  List<SpendingMoney> positiveMonths = [];
  double maxValue = 40;
  double interval = 20;
  int totalSum = 0;
  int totalMoney = 0;
  int maxMoney = 0;
  double average = 0;

  //Hàm lấy dữ liệu từ server và tính toán
  Future<void> fetchDataFromServer() async {
    List<SpendingMoney> newData = await spendingVM.serviceCallList();
    if (newData.any((element) => element.pSum != 0)) {
      //Biến lưu các tháng có tổng chi lớn hơn 0
      positiveMonths = newData.where((element) => element.pSum! > 0).toList();
      //Biến lưu tổng tiền chi của các tháng có số tiền chi lớn hơn 0
      totalMoney = positiveMonths.fold(
          0, (previousValue, element) => previousValue + (element.pSum ?? 0));
      //Biến lưu số tiền chi trung bình
      average =
          positiveMonths.isNotEmpty ? totalMoney / positiveMonths.length : 0;
      //Biến lưu số tiền chi lớn nhất
      maxMoney = newData
          .map((e) => e.pSum!)
          .reduce((value, element) => value > element ? value : element);
      maxValue = maxMoney / 1000;
      interval = maxValue / 4;
      interval = interval <= 10.0 ? 1.0 : (interval ~/ 10) * 10.0;
      setState(() {});
    } else {
      setState(() {
        maxValue = 40;
        interval = 10;
        average = 0;
        totalMoney = 0;
      });
    }
  }

  @override
  void initState() {
    spendingVM = Get.put(SpendingVM());
    fetchDataFromServer();
    _tooltip = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<SpendingVM>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        toolbarHeight: 0,
        elevation: 0,
      ),
      body: FutureBuilder<List<SpendingMoney>>(
        // Gọi hàm fetchData() để nhận dữ liệu
        future: spendingVM.serviceCallList(),
        builder: (context, snapshot) {
          // Kiểm tra trạng thái của Future
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Nếu Future đang chờ dữ liệu, hiển thị một tiêu đề loading
            return Center(child: loadingIndicator());
          } else if (snapshot.hasError) {
            // Nếu có lỗi xảy ra trong quá trình lấy dữ liệu, hiển thị một thông báo lỗi
            return Text('Error: ${snapshot.error}');
          } else {
            // Nếu dữ liệu đã sẵn có, hiển thị dữ liệu lên giao diện
            final List<SpendingMoney> data = snapshot.data!;
            // Đây là nơi bạn có thể sử dụng dữ liệu để hiển thị trên giao diện

            hasZeroValue = data.any((element) => element.pSum != 0);
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    color: Colors.white,
                    child: ElevatedButton(
                      onPressed: () {
                        //Hiện thị chọn năm
                        selectYear(context);
                      },
                      style: TextButton.styleFrom(
                          padding: const EdgeInsets.all(0),
                          elevation: 0,
                          splashFactory: NoSplash.splashFactory,
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.calendar_month,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Năm ${spendingVM.txtYear}',
                            style: const TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(
                    height: 1,
                    thickness: 1,
                  ),
                  Container(
                    color: Colors.white,
                    height: 400,
                    width: 400,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          child: Text(
                            '(Đơn vị: Nghìn)',
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Stack(
                          alignment: AlignmentDirectional.center,
                          children: [
                            //Hiện thị biểu đồ
                            SfCartesianChart(
                              primaryXAxis: CategoryAxis(
                                majorGridLines: const MajorGridLines(width: 0),
                              ),
                              primaryYAxis: NumericAxis(
                                  minimum: 0,
                                  maximum: maxValue,
                                  interval: interval),
                              enableAxisAnimation: true,
                              tooltipBehavior: _tooltip,
                              enableSideBySideSeriesPlacement: false,
                              series: <CartesianSeries<SpendingMoney, String>>[
                                ColumnSeries<SpendingMoney, String>(
                                    dataSource: data,
                                    xValueMapper: (SpendingMoney data, _) =>
                                        data.pMonth.toString(),
                                    yValueMapper: (SpendingMoney data, _) =>
                                        (data.pSum)! / 1000,
                                    color: const Color.fromARGB(
                                        255, 34, 167, 255)),
                              ],
                            ),
                            if (!hasZeroValue)
                              const Center(
                                child: Text(
                                  'Không có dữ liệu!',
                                  style: TextStyle(fontSize: 17),
                                ),
                              )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Tổng chi tiêu',
                                style: TextStyle(color: Colors.grey),
                              ),
                              Text(
                                formatCurrency(totalMoney),
                                style: TextStyle(color: Colors.grey[700]),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Trung bình chi/tháng',
                                style: TextStyle(color: Colors.grey),
                              ),
                              Text(
                                formatCurrency(average.toInt()),
                                style: TextStyle(color: Colors.grey[700]),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  //Hiện thị nút xem chi tiết
                  Container(
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            toggleListViewVisibility();
                          },
                          style: TextButton.styleFrom(
                              padding: const EdgeInsets.all(0),
                              elevation: 0,
                              splashFactory: NoSplash.splashFactory,
                              backgroundColor: Colors.transparent,
                              foregroundColor: Colors.black54,
                              shadowColor: Colors.transparent),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Xem chi tiết',
                                  style: TextStyle(fontSize: 15),
                                ),
                                Icon(
                                  Icons.keyboard_arrow_down,
                                )
                              ],
                            ),
                          ),
                        ),
                        const Divider(
                          height: 1,
                          thickness: 1,
                        ),
                        //Hiện thị list hiện thị các tháng có chi tiêu
                        Visibility(
                          visible: isListViewVisible,
                          child: ListView.separated(
                            itemCount: positiveMonths.length,
                            shrinkWrap: true,
                            separatorBuilder: (context, index) {
                              return const Divider(
                                height: 1,
                                thickness: 1,
                              );
                            },
                            itemBuilder: (context, index) {
                              return ListTile(
                                  title: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 20,
                                    backgroundColor: Colors.red[400],
                                    child: Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: ClipOval(
                                        child: Text(
                                          'T${positiveMonths[index].pMonth}',
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text('Tháng ${positiveMonths[index].pMonth}'),
                                  const Spacer(),
                                  Text(
                                    formatCurrency(positiveMonths[index].pSum),
                                    style: TextStyle(color: Colors.red[400]),
                                  )
                                ],
                              ));
                            },
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
