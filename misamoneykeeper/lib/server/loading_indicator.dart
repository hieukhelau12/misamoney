import 'package:misamoneykeeper_flutter/utility/export.dart';

Widget loadingIndicator() {
  return const CircularProgressIndicator(
    valueColor: AlwaysStoppedAnimation(Colors.black54),
  );
}
