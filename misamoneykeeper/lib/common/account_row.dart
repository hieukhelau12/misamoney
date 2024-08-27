// ignore_for_file: unused_local_variable

import 'package:misamoneykeeper_flutter/common/delete_dialog.dart';
import 'package:misamoneykeeper_flutter/common/report_row.dart';
import 'package:misamoneykeeper_flutter/controller/account_view_model.dart';
import 'package:misamoneykeeper_flutter/model/account_model.dart';
import 'package:misamoneykeeper_flutter/utility/export.dart';
import 'package:misamoneykeeper_flutter/view/account/account_update.dart';

class AccountRow extends StatefulWidget {
  final List<AccountModel> listData;
  final String title;
  const AccountRow({super.key, required this.listData, required this.title});

  @override
  State<AccountRow> createState() => _AccountRowState();
}

class _AccountRowState extends State<AccountRow> {
  late AccountViewModel accountViewModel;

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

  @override
  Widget build(BuildContext context) {
    int sum1 = 0;

    for (var item in widget.listData) {
      sum1 += item.acMoney!;
    }

    return Column(
      children: [
        ReportRow(
            title: "Có (${widget.listData.length} ${widget.title})",
            money: sum1),
        const Divider(
          height: 1,
          thickness: 1,
        ),
        //Hiện thị list các tài khoản
        ListView.separated(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          physics: const NeverScrollableScrollPhysics(),
          itemCount: widget.listData.length,
          separatorBuilder: (context, index) {
            return const Divider(
              height: 1,
              thickness: 1,
            );
          },
          itemBuilder: (context, index) {
            var menuKey = GlobalKey();
            return Row(
              children: [
                //Hiện thị icon của tài sản
                Container(
                  width: 40,
                  height: 40,
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                      color: Colors.amber, shape: BoxShape.circle),
                  child: widget.listData[index].acType == 3
                      ? const Icon(
                          Icons.two_wheeler,
                          size: 25,
                          color: Colors.white,
                        )
                      : widget.listData[index].acType == 1
                          ? const Icon(
                              Icons.account_balance_wallet,
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
                //Hiện thi  tên tài khoản và giá trị
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ("${widget.listData[index].acName}")
                          .text
                          .size(16)
                          .color(Colors.black)
                          .fontFamily(sansBold)
                          .make(),
                      3.heightBox,
                      formatCurrency(widget.listData[index].acMoney)
                          .text
                          .size(14)
                          .fontFamily(sansBold)
                          .color(Colors.black45)
                          .make(),
                    ],
                  ),
                ),
                //Hiện thị nút để hiện ra menu có sửa tài khoản và xoá
                IconButton(
                  key: menuKey,
                  onPressed: () {
                    final RenderBox overlay = Overlay.of(context)
                        .context
                        .findRenderObject() as RenderBox;
                    final RenderBox button =
                        menuKey.currentContext!.findRenderObject() as RenderBox;
                    final position =
                        button.localToGlobal(Offset.zero, ancestor: overlay);
                    showMenu(
                      context: context,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      position: RelativeRect.fromLTRB(
                          position.dx, position.dy + button.size.height, 0, 0),
                      items: [
                        const PopupMenuItem(
                          value: 1,
                          child: Text("Sửa Tài Khoản",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: sansBold,
                                  color: Colors.black)),
                        ),
                        const PopupMenuItem(
                          value: 2,
                          child: Text("Xóa Tài Khoản",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: sansBold,
                                  color: Colors.black)),
                        ),
                      ],
                      elevation: 8,
                    ).then((value) {
                      if (value == 1) {
                        Get.to(
                                () => AccountUpdate(
                                    accountModel: widget.listData[index]),
                                transition: Transition.rightToLeft)
                            ?.then((value) => delayedFunction());
                      } else if (value == 2) {
                        showDialog(
                            context: context,
                            builder: (context) => ExitDialog(
                                  accountId: widget.listData[index].accountId!,
                                )).then((value) => delayedFunction());
                      }
                    });
                  },
                  icon: const Icon(
                    Icons.more_vert,
                    size: 25,
                    color: Colors.black45,
                  ),
                )
              ],
            )
                .box
                .padding(const EdgeInsets.symmetric(vertical: 5))
                .margin(const EdgeInsets.symmetric(vertical: 5))
                .make()
                .onTap(() {});
          },
        ),
      ],
    );
  }
}
