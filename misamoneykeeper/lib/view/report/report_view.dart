import 'package:misamoneykeeper_flutter/common/report_cell.dart';
import 'package:misamoneykeeper_flutter/utility/export.dart';
import 'package:misamoneykeeper_flutter/view/report/report_details.dart';

class ReportView extends StatefulWidget {
  const ReportView({super.key});

  @override
  State<ReportView> createState() => _ReportViewState();
}

class _ReportViewState extends State<ReportView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        elevation: 0.5,
        centerTitle: true,
        title: "Báo Cáo".text.white.size(20).fontFamily(sansSemibold).make(),
      ),
      backgroundColor: const Color.fromARGB(255, 244, 242, 242),
      //Hiện thị danh sách các đề mục của báo cáo
      body: GridView.builder(
          padding: const EdgeInsets.all(15),
          physics: const BouncingScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              childAspectRatio: 1.5),
          itemCount: textLisReport.length,
          itemBuilder: ((context, index) {
            return ReportCell(
                icon: iconListReport[index],
                title: textLisReport[index],
                onPressed: () {
                  switch (index) {
                    case 0:
                      Get.to(() => const ReportDetails(idx: 0));
                    case 1:
                      Get.to(() => const ReportDetails(idx: 1));
                    case 2:
                      Get.to(() => const ReportDetails(idx: 2));
                    case 3:
                      Get.to(() => const ReportDetails(idx: 3));
                  }
                });
          })),
    );
  }
}
