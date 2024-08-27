import 'package:misamoneykeeper_flutter/utility/export.dart';

class ButtomWidget extends StatelessWidget {
  final int color;
  final String image;
  final double scaleImage;
  final String text;
  final VoidCallback onPressed;
  const ButtomWidget({
    super.key,
    required this.color,
    required this.image,
    required this.scaleImage,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        animationDuration: Duration.zero,
        splashFactory: NoSplash.splashFactory,
      ).copyWith(
        overlayColor: const MaterialStatePropertyAll(Colors.transparent),
      ),
      child: Column(
        children: [
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Color(color),
                borderRadius: BorderRadius.circular(10),
              ),
              child: ClipRRect(
                child: Image.asset(
                  image,
                  scale: scaleImage,
                ),
              ),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12, color: Colors.black),
          )
        ],
      ),
    );
  }
}
