import 'package:misamoneykeeper_flutter/utility/export.dart';
import 'package:misamoneykeeper_flutter/view/pay_collect_status/status_collect.dart';
import 'package:misamoneykeeper_flutter/view/pay_collect_status/status_pay.dart';

class StatusMain extends StatefulWidget {
  const StatusMain({super.key});

  @override
  State<StatusMain> createState() => _StatusMainState();
}

class _StatusMainState extends State<StatusMain> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: "Tình hình thu chi"
              .text
              .size(18)
              .fontFamily(sansBold)
              .white
              .make(),
          centerTitle: true,
          bottom: const TabBar(indicatorColor: Colors.white, tabs: [
            Tab(
              child: Text(
                "Chi",
                style: TextStyle(
                    color: Colors.white, fontSize: 16, fontFamily: sansBold),
              ),
            ),
            Tab(
              child: Text(
                "Thu",
                style: TextStyle(
                    color: Colors.white, fontSize: 16, fontFamily: sansBold),
              ),
            )
          ]),
        ),
        //Hiện thị 2 trang tình hình thu và tình hình chi
        body: const TabBarView(children: [StatusPay(), StatusCollect()]),
      ),
    );
  }
}
