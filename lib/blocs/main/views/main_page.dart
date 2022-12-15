import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:supply_chain/blocs/company/views/company_page.dart';
import 'package:supply_chain/blocs/home/views/home_page.dart';
import 'package:supply_chain/blocs/product/views/product_page.dart';
import 'package:supply_chain/blocs/transfer/views/transfer_page.dart';
import 'package:supply_chain/blocs/user/views/user_page.dart';
import 'package:supply_chain/z_views_demo_old/widgets/animated_index_stack.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const MainPage());
  }

  @override
  Widget build(BuildContext context) {
    return const _MainView();
  }
}

class _MainView extends StatefulWidget {
  const _MainView({Key? key}) : super(key: key);

  @override
  State<_MainView> createState() => _MainViewState();
}

class _MainViewState extends State<_MainView> {
  int _currentIndex = 0;
  final Duration duration = const Duration(milliseconds: 500);

  List<Widget> childs = [
    const HomePage(),
    const CompanyPage(),
    const ProductPage(),
    const TransferPage(),
    const UserPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: AnimatedIndexedStack(
              index: _currentIndex, duration: duration, children: childs)),
      bottomNavigationBar: Card(
        elevation: 1,
        margin: EdgeInsets.zero,
        color: Colors.white,
        child: SalomonBottomBar(
          currentIndex: _currentIndex,
          onTap: (i) => setState(() => _currentIndex = i),
          items: [
            /// Home
            SalomonBottomBarItem(
              icon: const Icon(Icons.home_outlined),
              title: const Text("Trang chủ"),
              selectedColor: Colors.red,
            ),

            /// Công ty
            SalomonBottomBarItem(
              icon: const Icon(Icons.business),
              title: const Text("Công ty"),
              selectedColor: Colors.orange,
            ),

            /// Sản phẩm
            SalomonBottomBarItem(
              icon: const Icon(Icons.auto_awesome_motion_outlined),
              title: const Text("Hàng hóa"),
              selectedColor: Colors.blueGrey,
            ),

            /// Vận chuyển
            SalomonBottomBarItem(
              icon: const Icon(Icons.transform_outlined),
              title: const Text("Giao dịch"),
              selectedColor: Colors.cyan,
            ),

            /// Tài khoản
            SalomonBottomBarItem(
              icon: const Icon(Icons.account_circle_outlined),
              title: const Text("Tài khoản"),
              selectedColor: Colors.green,
            ),
          ],
        ),
      ),
    );
  }
}
