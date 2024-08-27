import 'package:misamoneykeeper_flutter/utility/export.dart';

class ReportCell extends StatelessWidget {
  final String icon;
  final String title;
  final VoidCallback onPressed;
  const ReportCell(
      {super.key,
      required this.icon,
      required this.title,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            icon,
            width: 35,
            fit: BoxFit.cover,
          ),
          20.heightBox,
          title.text.size(16).fontFamily(sansBold).color(Colors.black87).make()
        ]).box.white.roundedSM.shadowSm.make().onTap(onPressed);
  }
}
