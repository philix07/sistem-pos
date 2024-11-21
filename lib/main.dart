import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kerja_praktek/firebase_options.dart';
import 'package:iconly/iconly.dart';
import 'package:kerja_praktek/frontend/blocs/auth/auth_bloc.dart';
import 'package:kerja_praktek/frontend/blocs/history/history_bloc.dart';
import 'package:kerja_praktek/frontend/blocs/checkout/checkout_bloc.dart';
import 'package:kerja_praktek/frontend/blocs/order/order_bloc.dart';
import 'package:kerja_praktek/frontend/blocs/report/report_bloc.dart';
import 'package:kerja_praktek/frontend/common/components/app_button.dart';
import 'package:kerja_praktek/frontend/common/components/app_dialog.dart';
import 'package:kerja_praktek/frontend/common/components/app_scaffold.dart';
import 'package:kerja_praktek/frontend/common/components/spaces.dart';
import 'package:kerja_praktek/frontend/common/style/app_colors.dart';
import 'package:kerja_praktek/frontend/common/style/app_style.dart';
import 'package:kerja_praktek/frontend/presentation/setting/setting_page.dart';
import 'package:kerja_praktek/frontend/blocs/product/product_bloc.dart';
import 'package:kerja_praktek/frontend/presentation/setting/bloc/app_user_bloc.dart';
import 'package:kerja_praktek/frontend/presentation/auth/auth_page.dart';
import 'package:kerja_praktek/frontend/presentation/payment/payment_page.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ProductBloc()),
        BlocProvider(create: (_) => CheckOutBloc()),
        BlocProvider(create: (_) => OrderBloc()),
        BlocProvider(create: (_) => HistoryBloc()),
        BlocProvider(create: (_) => ReportBloc()),
        BlocProvider(create: (_) => AuthBloc()),
        BlocProvider(create: (_) => AppUserBloc()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AuthManagerPage(),
        title: "Kerja Praktek",
      ),
    );
  }
}

class AuthManagerPage extends StatefulWidget {
  const AuthManagerPage({super.key});

  @override
  State<AuthManagerPage> createState() => _AuthManagerPageState();
}

class _AuthManagerPageState extends State<AuthManagerPage> {
  @override
  void initState() {
    context.read<AuthBloc>().add(AuthInitial());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthLoggedOut) {
          return const AuthPage();
        } else if (state is AuthLoggedIn) {
          return const DashboardPage();
        } else if (state is AuthNewUser) {
          return AppScaffold(
            child: Container(
              padding: const EdgeInsets.all(20.0),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/icons/information.svg',
                    width: 90,
                    height: 90,
                    colorFilter: const ColorFilter.mode(
                      AppColor.primary,
                      BlendMode.srcIn,
                    ),
                  ),
                  const SpaceHeight(20.0),
                  Text(
                    'Welcome new user, Please wait for the owner to verify your status',
                    textAlign: TextAlign.center,
                    style: AppTextStyle.blue(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SpaceHeight(20.0),
                  AppButton(
                    title: 'Log Out',
                    isActive: true,
                    onTap: () {
                      context.read<AuthBloc>().add(AuthLogOut());
                    },
                  )
                ],
              ),
            ),
          );
        } else if (state is AuthLoading) {
          return const AppScaffold(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is AuthError) {
          Future.delayed(
            const Duration(milliseconds: 100),
            () {
              AppDialog.show(
                context,
                iconPath: 'assets/icons/error.svg',
                message: state.message,
                customOnBack: true,
                onBack: () {
                  Navigator.pop(context);
                  context.read<AuthBloc>().add(AuthLogOut());
                },
              );
            },
          );
        }

        return AppScaffold(
          child: Container(
            alignment: Alignment.center,
            child: const CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  void initState() {
    context.read<ProductBloc>().add(FetchAll());
    super.initState();
  }

  int _index = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const PaymentPage(),
    const HistoryPage(),
    const SettingPage(),
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
              icon: IconlyLight.setting,
              label: "Setting",
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
