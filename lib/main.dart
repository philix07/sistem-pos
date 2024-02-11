import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:kerja_praktek/firebase_options.dart';
import 'package:iconly/iconly.dart';
import 'package:kerja_praktek/frontend/common/components/app_scaffold.dart';
import 'package:kerja_praktek/frontend/common/style/app_colors.dart';
import 'package:kerja_praktek/frontend/presentation/admin/admin_page.dart';
import 'package:kerja_praktek/frontend/presentation/cart/cart_page.dart';
import 'package:kerja_praktek/frontend/presentation/history/history_page.dart';
import 'package:kerja_praktek/frontend/presentation/home/homepage.dart';
import 'package:kerja_praktek/frontend/presentation/home/widgets/bottom_nav_item.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: DashboardPage(),
      // home: AuthPage(),
    );
  }
}

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _index = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const CartPage(),
    const HistoryPage(),
    const AdminPage(),
  ];

  void swapPages(int index) {
    setState(() {
      _index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(30),
          ),
          color: AppColor.white,
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, -2),
              blurRadius: 30.0,
              blurStyle: BlurStyle.outer,
              spreadRadius: 0,
              color: AppColor.black.withOpacity(0.2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            NavItem(
              icon: IconlyLight.home,
              label: "Home",
              isActive: _index == 0,
              onTap: () => swapPages(0),
            ),
            NavItem(
              icon: IconlyLight.buy,
              label: "Payment",
              isActive: _index == 1,
              onTap: () => swapPages(1),
            ),
            NavItem(
              icon: IconlyLight.paper,
              label: "History",
              isActive: _index == 2,
              onTap: () => swapPages(2),
            ),
            NavItem(
              icon: IconlyLight.profile,
              label: "Admin",
              isActive: _index == 3,
              onTap: () => swapPages(3),
            ),
          ],
        ),
      ),
      child: _pages[_index],
    );
  }
}
