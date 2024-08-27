import 'package:misamoneykeeper_flutter/common/custom_button.dart';
import 'package:misamoneykeeper_flutter/controller/account_delete_view_model.dart';
import 'package:misamoneykeeper_flutter/controller/account_view_model.dart';
import 'package:misamoneykeeper_flutter/utility/export.dart';

class ExitDialog extends StatefulWidget {
  final int accountId;
  const ExitDialog({super.key, required this.accountId});

  @override
  State<ExitDialog> createState() => _ExitDialogState();
}

class _ExitDialogState extends State<ExitDialog> {
  late AccountDeleteViewModel accountDeleteViewModel;
  late AccountViewModel accountViewModel;
  @override
  void initState() {
    super.initState();
    accountDeleteViewModel = Get.put(AccountDeleteViewModel());
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          "Xóa Tài Khoản?"
              .text
              .size(22)
              .color(Colors.red)
              .fontFamily(sansBold)
              .make(),
          15.heightBox,
          const Text(
            "Bạn có chắc chắn muốn xóa Tài Khoản này?",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 16, fontFamily: sansRegular, color: Colors.black),
          ),
          20.heightBox,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomButton(
                  // Thoát
                  color: const Color.fromARGB(255, 241, 90, 56),
                  onPress: () {
                    accountDeleteViewModel.idAccount.value =
                        widget.accountId.toString();

                    accountDeleteViewModel.serviceCallAccountDelete();
                    Navigator.pop(context);
                  },
                  title: "Đồng Ý",
                  textColor: Colors.white,
                  width: 100,
                  height: 40,
                  radius: 10,
                  size: 16),
              CustomButton(
                  // Hủy thoát
                  color: Colors.red,
                  onPress: () {
                    Get.back();
                  },
                  title: "Hủy",
                  textColor: Colors.white,
                  width: 100,
                  height: 40,
                  radius: 10,
                  size: 16),
            ],
          )
        ],
      ).box.white.padding(const EdgeInsets.all(20)).roundedSM.make(),
    );
  }
}
