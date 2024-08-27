import 'package:misamoneykeeper_flutter/utility/export.dart';

class CategoryCell extends StatelessWidget {
  final String icon;
  final String title;
  final VoidCallback onPressed;
  const CategoryCell(
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
          Image.network(
            icon,
            width: 35,
            height: 35,
            fit: BoxFit.cover,
          ),
          Flexible(
              fit: FlexFit.loose,
              child: title.text
                  .size(15)
                  .fontFamily(sansBold)
                  .color(Colors.black87)
                  .make())
        ]).box.roundedSM.make().onTap(onPressed);
  }
}
