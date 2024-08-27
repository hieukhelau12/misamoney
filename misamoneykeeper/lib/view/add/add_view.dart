import 'package:misamoneykeeper_flutter/utility/export.dart';
import 'package:misamoneykeeper_flutter/view/add/pay_collect.dart';
import 'package:misamoneykeeper_flutter/view/add/pay_pay.dart';
import 'package:misamoneykeeper_flutter/view/history/history_view.dart';

class AddView extends StatefulWidget {
  final bool? isCheck;
  final int? payId;
  final int? pType;
  final String? categoryIcon;
  final String? categoryTitle;
  final int? categoryDetailsId;
  final int? accountIcon;
  final String? accountTitle;
  final int? accountId;
  final String? dateController;
  final String? moneyAccount;
  final String? descriptionAccount;

  const AddView(
      {super.key,
      this.isCheck,
      this.payId,
      this.categoryIcon,
      this.categoryTitle,
      this.categoryDetailsId,
      this.accountIcon,
      this.accountTitle,
      this.accountId,
      this.dateController,
      this.moneyAccount,
      this.descriptionAccount,
      this.pType});

  @override
  AddViewState createState() => AddViewState();
}

class AddViewState extends State<AddView> {
  bool showTextField = false;
  final TextEditingController date = TextEditingController();
  int position = 0;
  String pop = "Thêm chi tiết";
  var title = 'Chi tiền'.obs;
  @override
  void initState() {
    super.initState();
    if (widget.pType != null) {
      position = widget.pType! - 1;
    } else {
      position = 0;
    }

    setState(() {});
  }

  void changePosition(int index) {
    setState(() {
      position = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          actions: [
            //Hiện thị lịch sử
            IconButton(
                icon: const Icon(
                  Icons.history,
                  color: Colors.white,
                  size: 25,
                ),
                onPressed: () {
                  Get.to(() => const HistoryView(),
                      transition: Transition.zoom);
                }),
          ],
          elevation: 0,
          title: InkWell(
            onTap: () {
              final left = context.screenWidth * 0.3;
              final top = context.screenHeight * 0.11;

              //Hiện thị menu để chọn giữa thu và chi
              showMenu(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                context: context,
                position: RelativeRect.fromLTRB(left, top, left, 0.0),
                items: List.generate(
                  textListAdd.length,
                  (index) => PopupMenuItem(
                    value: index + 1,
                    child: Row(children: [
                      Image.asset(
                        iconListReport[index],
                        width: 15,
                        color: Colors.black.withOpacity(0.5),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        textListAdd[index],
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black.withOpacity(0.5),
                            fontFamily: sansRegular),
                      ),
                      index == position
                          ? Row(
                              children: [
                                const SizedBox(
                                  width: 10,
                                ),
                                Icon(
                                  Icons.check_sharp,
                                  weight: 15,
                                  color: Colors.red.withOpacity(0.5),
                                )
                              ],
                            )
                          : const SizedBox.shrink()
                    ]),
                  ),
                ),
              ).then((value) {
                switch (value) {
                  case 1:
                    changePosition(0);
                    break;
                  case 2:
                    changePosition(1);
                    break;
                }
              });
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                textAdd[position]
                    .text
                    .size(18)
                    .fontFamily(sansBold)
                    .white
                    .make(),
                const SizedBox(width: 5),
                Image.asset(
                  icArrowDown,
                  width: 12,
                  color: Colors.white,
                ),
              ],
            )
                .box
                .height(35)
                .padding(const EdgeInsets.symmetric(horizontal: 15))
                .withDecoration(
                  BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white.withOpacity(0.3),
                  ),
                )
                .make(),
          ),
          centerTitle: true,
        ),
        //Thay đổi màn hình thu và chi dựa trên việc chọn ở tabbar
        body: IndexedStack(
          index: position,
          children: [
            PayPay(
              isCheck: widget.isCheck,
              payId: widget.payId,
              categoryIcon: widget.categoryIcon,
              categoryTitle: widget.categoryTitle,
              categoryDetailsId: widget.categoryDetailsId,
              accountIcon: widget.accountIcon,
              accountTitle: widget.accountTitle,
              accountId: widget.accountId,
              dateController: widget.dateController,
              moneyAccount: widget.moneyAccount,
              descriptionAccount: widget.descriptionAccount,
            ),
            PayCollect(
              isCheck: widget.isCheck,
              payId: widget.payId,
              categoryIcon: widget.categoryIcon,
              categoryTitle: widget.categoryTitle,
              categoryDetailsId: widget.categoryDetailsId,
              accountIcon: widget.accountIcon,
              accountTitle: widget.accountTitle,
              accountId: widget.accountId,
              dateController: widget.dateController,
              moneyAccount: widget.moneyAccount,
              descriptionAccount: widget.descriptionAccount,
            )
          ],
        ));
  }
}
