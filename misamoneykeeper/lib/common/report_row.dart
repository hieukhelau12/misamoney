import 'package:misamoneykeeper_flutter/utility/export.dart';

class ReportRow extends StatelessWidget {
  final String title;
  final int money;
  const ReportRow({super.key, required this.title, required this.money});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        title.text.size(16).color(Colors.black).fontFamily(sansBold).make(),
        formatCurrency(money)
            .text
            .size(16)
            .color(Colors.black)
            .fontFamily(sansBold)
            .make(),
      ],
    )
        .box
        .white
        .padding(const EdgeInsets.symmetric(horizontal: 15, vertical: 10))
        .make();
  }
}
