// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:misamoneykeeper_flutter/utility/export.dart';
import 'package:misamoneykeeper_flutter/view/report/collect_analysis_view.dart';
import 'package:misamoneykeeper_flutter/view/report/current_financial.dart';
import 'package:misamoneykeeper_flutter/view/report/rap_view.dart';
import 'package:misamoneykeeper_flutter/view/report/situation_view.dart';

class ReportDetails extends StatefulWidget {
  final int idx;
  const ReportDetails({
    Key? key,
    required this.idx,
  }) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<ReportDetails> createState() => _ReportDetailsState(idx: idx);
}

class _ReportDetailsState extends State<ReportDetails> {
  int idx;
  _ReportDetailsState({required this.idx});
  void changePosition(int index) {
    setState(() {
      idx = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 201, 200, 200),
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: InkWell(
            onTap: () {
              final left = context.screenWidth / 4.3;
              final top = context.screenHeight * 0.12;
              final right = left;
              //Hiện thị menu chuyển đổi các mục báo cáo
              showMenu(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                context: context,
                position: RelativeRect.fromLTRB(left, top, right, 0.0),
                items: List.generate(
                  textLisReport.length,
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
                        textLisReport[index],
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black.withOpacity(0.5),
                            fontFamily: sansRegular),
                      ),
                      index == idx
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
                  case 3:
                    changePosition(2);
                    break;
                  case 4:
                    changePosition(3);
                    break;
                }
              });
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                textLisReport[idx]
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
        body: IndexedStack(
          index: idx,
          children: const [
            CurrentFinancial(),
            RapView(),
            SituationView(),
            CollectAnalysisView(),
          ],
        ));
  }
}
