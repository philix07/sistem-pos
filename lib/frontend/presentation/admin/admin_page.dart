import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kerja_praktek/frontend/blocs/auth/auth_bloc.dart';
import 'package:kerja_praktek/frontend/common/components/app_button.dart';
import 'package:kerja_praktek/frontend/common/components/app_dialog.dart';
import 'package:kerja_praktek/frontend/common/components/app_scaffold.dart';
import 'package:kerja_praktek/frontend/common/components/spaces.dart';
import 'package:kerja_praktek/frontend/presentation/admin/manage_product_page.dart';
import 'package:kerja_praktek/frontend/presentation/admin/manage_user_page.dart';
import 'package:kerja_praktek/frontend/presentation/admin/widget/text_description.dart';
import 'package:kerja_praktek/models/user.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthLoading) {
            const Expanded(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (state is AuthLoggedIn) {
            var userRole = state.user.role;

            bool canManageUserRole(UserRole role) {
              if (role == UserRole.owner) {
                return true;
              }
              return false;
            }

            bool canManageProduct(UserRole role) {
              if (role == UserRole.none || role == UserRole.cashier) {
                return false;
              }
              return true;
            }

            bool canManagePrinter(UserRole role) {
              if (role == UserRole.none || role == UserRole.cashier) {
                return false;
              }
              return true;
            }

            bool canManageReport(UserRole role) {
              if (role == UserRole.owner) {
                return true;
              }
              return false;
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SpaceHeight(10.0),
                TextDescripton(title: "NAME", subtitle: state.user.name),
                const SpaceHeight(30.0),
                TextDescripton(title: "YOUR ROLE", subtitle: userRole.value),
                const SpaceHeight(30.0),
                Expanded(child: Container()),
                canManageUserRole(userRole)
                    ? AppIconButton(
                        title: "Manage User Roles",
                        width: double.infinity,
                        isSvg: true,
                        svgHeight: 30,
                        svgWidth: 30,
                        iconPath: 'assets/icons/person.svg',
                        isBlue: true,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ManageUserPage(),
                            ),
                          );
                        },
                      )
                    : const SizedBox(),
                const SpaceHeight(10.0),
                canManageProduct(userRole)
                    ? AppIconButton(
                        title: "Manage Product",
                        width: double.infinity,
                        isSvg: true,
                        iconPath: 'assets/icons/all_categories.svg',
                        isBlue: true,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ManageProductPage(),
                            ),
                          );
                        },
                      )
                    : const SizedBox(),
                const SpaceHeight(10.0),
                canManagePrinter(userRole)
                    ? AppIconButton(
                        title: "Manage Printer",
                        width: double.infinity,
                        isSvg: true,
                        iconPath: 'assets/icons/print.svg',
                        isBlue: true,
                        onTap: () {},
                      )
                    : const SizedBox(),
                const SpaceHeight(10.0),
                canManageReport(userRole)
                    ? AppIconButton(
                        title: "Manage Report",
                        width: double.infinity,
                        isSvg: true,
                        iconPath: 'assets/icons/financial_report.svg',
                        isBlue: true,
                        onTap: () {},
                      )
                    : const SizedBox(),
                const SpaceHeight(10.0),
                AppIconButton(
                  title: "Logout",
                  width: double.infinity,
                  isSvg: true,
                  iconPath: 'assets/icons/logout.svg',
                  isBlue: false,
                  onTap: () {
                    AppDialog.showConfirmationDialog(
                      context,
                      iconPath: 'assets/icons/information.svg',
                      message: 'Are you sure you want to log out?',
                      onConfirmation: () {
                        context.read<AuthBloc>().add(AuthLogOut());
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
                const SpaceHeight(10.0),
              ],
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
