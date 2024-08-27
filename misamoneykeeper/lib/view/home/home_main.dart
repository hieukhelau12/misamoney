import 'package:misamoneykeeper_flutter/common/exit_dialog.dart';
import 'package:misamoneykeeper_flutter/utility/export.dart';
import 'package:misamoneykeeper_flutter/view/account/account_view.dart';
import 'package:misamoneykeeper_flutter/view/add/add_view.dart';
import 'package:misamoneykeeper_flutter/view/home/home_view.dart';
import 'package:misamoneykeeper_flutter/view/other/other_page.dart';
import 'package:misamoneykeeper_flutter/view/report/report_view.dart';

class HomeMain extends StatefulWidget {
  const HomeMain({super.key});

  @override
  State<HomeMain> createState() => _HomeMainState();
}

class _HomeMainState extends State<HomeMain> {
  int _selectedIndex = 0;

  //List các màn hình của bottombar
  final List<Widget> _widgetOptions = <Widget>[
    const HomeView(),
    const AccountView(),
    const AddView(),
    const ReportView(),
    const OtherPage(),
  ];

  //Hàm đổi index
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Map<int, GlobalKey<NavigatorState>> navigatorKeys = {
    0: GlobalKey<NavigatorState>(),
    1: GlobalKey<NavigatorState>(),
    2: GlobalKey<NavigatorState>(),
    3: GlobalKey<NavigatorState>(),
  };

  //Hàm để lấy ra từ mảng
  buildNavigator() {
    return Navigator(
      key: navigatorKeys[_selectedIndex],
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
            builder: (_) => _widgetOptions.elementAt(_selectedIndex));
      },
    );
  }

  //Hàm để khi ấn nút back thì sẽ hiện hỏi xác nhận thoát
  Future<bool> _onWillPop(BuildContext context) async {
    bool? exitResult = await showDialog(
      context: context,
      builder: (context) => const ExitConfirmationDialog(),
    );
    return exitResult ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child: Scaffold(
        //Hiện thị các màn của bottombar
        body: buildNavigator(),
        //BottomBar
        bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          shape: const CircularNotchedRectangle(),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //Các nút của bottombar
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.home,
                    color: Colors.grey[700],
                  ),
                  onPressed: () {
                    _onItemTapped(0);
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.account_balance_wallet,
                    color: Colors.grey[700],
                  ),
                  onPressed: () {
                    _onItemTapped(1);
                  },
                ),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey[700],
                  ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      _onItemTapped(2);
                    },
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.bar_chart,
                    color: Colors.grey[700],
                  ),
                  onPressed: () {
                    _onItemTapped(3);
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.dashboard,
                    color: Colors.grey[700],
                  ),
                  onPressed: () {
                    _onItemTapped(4);
                  },
                ),
              ],
            ),
          ),
        ),
        // floatingActionButton: FloatingActionButton(
        //   backgroundColor: Colors.blue,
        //   onPressed: () {
        //     _onItemTapped(4);
        //   },
        //   mini: true,
        //   child: const Icon(Icons.add),
        // ),
        // floatingActionButtonLocation:
        //     FloatingActionButtonLocation.miniCenterDocked,
      ),
    );
  }
}
