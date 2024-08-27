import 'package:misamoneykeeper_flutter/common/account_row.dart';
import 'package:misamoneykeeper_flutter/common/report_row.dart';
import 'package:misamoneykeeper_flutter/controller/account_view_model.dart';
import 'package:misamoneykeeper_flutter/controller/current_financial_view_model.dart';
import 'package:misamoneykeeper_flutter/controller/splash_view_model.dart';
import 'package:misamoneykeeper_flutter/model/account_model.dart';
import 'package:misamoneykeeper_flutter/server/loading_indicator.dart';
import 'package:misamoneykeeper_flutter/utility/export.dart';

class CurrentFinancial extends StatefulWidget {
  const CurrentFinancial({super.key});

  @override
  State<CurrentFinancial> createState() => _CurrentFinancialState();
}

class _CurrentFinancialState extends State<CurrentFinancial> {
  final splashVM = Get.find<SplashViewModel>();
  late AccountViewModel accountViewModel;
  int sum = 0;
  int sum1 = 0;
  int sum2 = 0;
  List<AccountModel> listData = [];
  List<AccountModel> listType12 = [];

  //Hàm để khởi tạo trạng thái ban đầu của widget
  @override
  void initState() {
    super.initState();
    accountViewModel = Get.put(AccountViewModel());
  }

  //Hàm để giải phóng tài nguyên mà một đối tượng đã sử dụng
  @override
  void dispose() {
    Get.delete<CurrentFinancialViewModel>();
    super.dispose();
  }

  //Hàm update lại dữ liệu
  void updateData(List<AccountModel> data) {
    listData.clear();
    listType12.clear();
    sum = 0;
    sum1 = 0;
    sum2 = 0;
    for (var element in data) {
      sum += element.acMoney!;
      if (element.acType! == 3) {
        //Mảng lưu tài sản cố định
        listData.add(element);
      } else {
        //Mảng lưu tài sản lưu động
        listType12.add(element);
      }
    }
    for (var item in listData) {
      //Biến lưu tổng số tiền tài sản cố định
      sum1 += item.acMoney!;
    }
    for (var item in listType12) {
      //Biến lưu tổng số tiền tài sản lưu động
      sum2 += item.acMoney!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<AccountModel>?>(
      stream: accountViewModel.dataStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: loadingIndicator());
        } else if (snapshot.hasError) {
          return Container(
            color: Colors.amber,
          );
        } else if (snapshot.hasData) {
          var data = snapshot.data;

          updateData(data!);
          return SingleChildScrollView(
              child: Column(
            children: [
              ReportRow(title: 'Tổng tài sản:', money: sum),
              10.heightBox,
              Container(
                color: Colors.white,
                child: Column(
                  children: [
                    //Hiện thị tài sản lưu động
                    AccountRow(listData: listType12, title: 'tài sản lưu động'),
                    Container(
                      height: 10,
                      color: Colors.grey[300],
                    ),
                    //Hiện thị tài sản cố định
                    AccountRow(listData: listData, title: 'tài sản cố định')
                  ],
                ),
              ),
            ],
          ));
        } else {
          return Container(
            color: const Color.fromARGB(255, 63, 52, 18),
          );
        }
      },
    );
  }
}
