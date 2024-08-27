import 'package:misamoneykeeper_flutter/utility/export.dart';

class CustomButton extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  final Color? color1;
  final String? title;
  final Color textColor;
  final double size;
  final double radius;
  final VoidCallback onPress;
  final String? icon;
  const CustomButton(
      {super.key,
      required this.width,
      required this.height,
      required this.color,
      this.color1,
      required this.title,
      required this.textColor,
      required this.size,
      required this.radius,
      required this.onPress,
      this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          
          borderRadius: BorderRadius.circular(radius),
          gradient: LinearGradient(
            colors: [color, color1 ?? color],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: ElevatedButton(
          
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: Colors.transparent,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(radius)),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          ),
          onPressed: onPress,
          child: Stack(
            children: [
              Center(
                  child: AutoSizeText(
                title!,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: size, color: textColor, fontFamily: sansBold),
                minFontSize: size,
              )),
              icon != null
                  ? Positioned(
                      top: 0,
                      left: 10,
                      bottom: 0,
                      child: Image.asset(
                        icon!,
                        width: 20,
                      ))
                  : const SizedBox.shrink(),
            ],
          ),
        ).box.size(width, height).make());
  }
}
