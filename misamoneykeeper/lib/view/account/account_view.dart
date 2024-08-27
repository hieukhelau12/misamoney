import 'package:misamoneykeeper_flutter/common/account_row.dart';
import 'package:misamoneykeeper_flutter/controller/account_view_model.dart';
import 'package:misamoneykeeper_flutter/controller/splash_view_model.dart';
import 'package:misamoneykeeper_flutter/model/account_model.dart';
import 'package:misamoneykeeper_flutter/server/loading_indicator.dart';
import 'package:misamoneykeeper_flutter/utility/export.dart';
import 'package:misamoneykeeper_flutter/view/account/account_add.dart';

class AccountView extends StatefulWidget {
  const AccountView({super.key});

  @override
  State<AccountView> createState() => _AccountViewState();
}

class _AccountViewState extends State<AccountView> {
  late AccountViewModel accountViewModel;
  final splashVM = Get.find<SplashViewModel>();
  int sum = 0;
  int sum1 = 0;
  int sum2 = 0;
  List<AccountModel> listData = [];
  List<AccountModel> listData1 = [];

  //Hàm để khởi tạo trạng thái ban đầu của widget
  @override
  void initState() {
    super.initState();
    accountViewModel = Get.put(AccountViewModel());
  }

  //Hàm reload lại trang
  Future<void> delayedFunction() async {
    await Future.delayed(const Duration(milliseconds: 600));
    setState(() {
      accountViewModel.serviceCallList();
    });
  }

  //Hàm để giải phóng tài nguyên mà một đối tượng đã sử dụng
  @override
  void dispose() {
    Get.delete<AccountViewModel>();
    super.dispose();
  }

  //Hàm update lại dữ liệu
  void updateData(List<AccountModel> data) {
    listData.clear();
    listData1.clear();
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
        listData1.add(element);
      }
    }
    for (var item in listData) {
      //Biến lưu tổng số tiền tài sản cố định
      sum1 += item.acMoney!;
    }
    for (var item in listData1) {
      //Biến lưu tổng số tiền tài sản lưu động
      sum2 += item.acMoney!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => const AccountAdd())!.then((value) => delayedFunction());
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text(
          'Tài sản',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: StreamBuilder<List<AccountModel>?>(
        stream: accountViewModel.dataStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: loadingIndicator());
          } else if (snapshot.hasError) {
            return Container(
              color: Colors.amber,
            );
          } else if (snapshot.hasData) {
            if (snapshot.data!.isEmpty) {
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
              )); // Hiển thị thông báo không có dữ liệu
            }
            var data = snapshot.data;

            updateData(data!);

            return SingleChildScrollView(
                child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    'Tổng tài sản: ${formatCurrency(sum)}',
                    style: const TextStyle(
                        fontSize: 17,
                        fontFamily: sansBold,
                        color: Colors.black),
                  ),
                ),
                10.heightBox,
                Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      //Hiện thị list tài sản lưu động
                      AccountRow(
                          listData: listData1, title: 'tài sản lưu động'),
                      if (listData.isNotEmpty)
                        //Hiện thị list tài sản cố định
                        AccountRow(listData: listData, title: 'tài sản cố định')
                    ],
                  ),
                )
              ],
            ));
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
