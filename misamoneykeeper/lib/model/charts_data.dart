import 'package:misamoneykeeper_flutter/utility/export.dart';
import 'dart:math';

class ChartsData {
  final String x;
  final int y;
  final Color color;

  ChartsData(this.x, this.y, this.color);
}

Color getRandomColor() {
  Random random = Random();
  List<Color> colors = [
    Colors.red,
    Colors.pink,
    Colors.purple,
    Colors.deepPurple,
    Colors.indigo,
    Colors.blue,
    Colors.lightBlue,
    Colors.cyan,
    Colors.teal,
    Colors.green,
    Colors.lightGreen,
    Colors.lime,
    Colors.yellow,
    Colors.amber,
    Colors.orange,
    Colors.deepOrange,
    Colors.brown,
    Colors.grey,
    Colors.blueGrey,
  ];
  return colors[random.nextInt(colors.length)];
}
