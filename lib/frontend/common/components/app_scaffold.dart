import 'package:flutter/material.dart';
import 'package:kerja_praktek/frontend/common/style/app_colors.dart';
import 'package:kerja_praktek/frontend/common/style/app_style.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({
    super.key,
    required this.child,
    this.bottomNavigationBar,
    this.bottom,
    this.appBarTitle,
    this.floatingActionButton,
    this.withAppBar = false,
    this.padding = const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
  });

  final Widget child;
  final bool withAppBar;
  final EdgeInsets padding;
  final Widget? bottomNavigationBar;
  final PreferredSizeWidget? bottom;
  final String? appBarTitle;
  final Widget? floatingActionButton;

  @override
  Widget build(BuildContext context) {
    return withAppBar
        ? Scaffold(
            appBar: AppBar(
              backgroundColor: AppColor.white,
              title: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  appBarTitle!,
                  style: AppTextStyle.black(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              toolbarHeight: MediaQuery.of(context).size.height / 30,
              centerTitle: true,
              bottom: bottom,
            ),
            bottomNavigationBar: bottomNavigationBar,
            body: SafeArea(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                padding: padding,
                child: child,
              ),
            ),
            floatingActionButton: floatingActionButton,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
          )
        : Scaffold(
            bottomNavigationBar: bottomNavigationBar,
            body: SafeArea(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                padding: padding,
                child: child,
              ),
            ),
            floatingActionButton: floatingActionButton,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
          );
  }
}
