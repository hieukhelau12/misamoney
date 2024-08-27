import 'package:misamoneykeeper_flutter/controller/history_view_model.dart';
import 'package:misamoneykeeper_flutter/utility/export.dart';

class HistoryMonth extends StatelessWidget {
  const HistoryMonth({super.key});

  @override
  Widget build(BuildContext context) {
    var historyVM = Get.find<HistoryViewModel>();
    return Scaffold(
      appBar: AppBar(
        title: "Chọn Tháng"
            .text
            .size(18)
            .fontFamily(sansBold)
            .color(Colors.white)
            .make(),
      ),
      //List ra cách tháng để chọn
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        itemCount: 12,
        separatorBuilder: (context, index) {
          return const Divider(
            color: Colors.white60,
            height: 1,
          );
        },
        itemBuilder: (context, index) {
          return ListTile(
            leading: "Tháng ${index + 1} "
                .text
                .size(16)
                .fontFamily(sansBold)
                .color(Colors.black)
                .make(),
            trailing: const Icon(Icons.chevron_right, size: 25),
            onTap: () {
              switch (index) {
                case 0:
                  historyVM.month.value = 1;
                  break;
                case 1:
                  historyVM.month.value = 2;
                  break;
                case 2:
                  historyVM.month.value = 3;
                  break;
                case 3:
                  historyVM.month.value = 4;
                  break;
                case 4:
                  historyVM.month.value = 5;
                  break;
                case 5:
                  historyVM.month.value = 6;
                  break;
                case 6:
                  historyVM.month.value = 7;
                  break;
                case 7:
                  historyVM.month.value = 8;
                  break;
                case 8:
                  historyVM.month.value = 9;
                  break;
                case 9:
                  historyVM.month.value = 10;
                  break;
                case 10:
                  historyVM.month.value = 11;
                  break;
                case 11:
                  historyVM.month.value = 12;
                  break;
              }
              historyVM.isMonth(true);
              Get.back();
            },
          );
        },
      ),
    );
  }
}
