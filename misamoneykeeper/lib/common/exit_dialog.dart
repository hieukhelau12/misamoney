import 'package:flutter/services.dart';
import 'package:misamoneykeeper_flutter/utility/export.dart';

class ExitConfirmationDialog extends StatelessWidget {
  const ExitConfirmationDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Xác nhận'),
      content: const Text('Bạn có chắc muốn thoát ứng dụng không?'),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          style: TextButton.styleFrom(backgroundColor: Colors.blue),
          child: const Text(
            'Không',
            style: TextStyle(color: Colors.white),
          ),
        ),
        TextButton(
          onPressed: () => SystemNavigator.pop(),
          child: const Text('Có'),
        ),
      ],
    );
  }
}
