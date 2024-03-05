import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kerja_praktek/frontend/blocs/auth/auth_bloc.dart';
import 'package:kerja_praktek/frontend/common/components/app_button.dart';
import 'package:kerja_praktek/frontend/common/components/app_dialog.dart';
import 'package:kerja_praktek/frontend/common/components/spaces.dart';
import 'package:kerja_praktek/frontend/common/style/app_colors.dart';
import 'package:kerja_praktek/frontend/common/style/app_style.dart';
import 'package:kerja_praktek/frontend/presentation/admin/widget/text_description.dart';
import 'package:kerja_praktek/models/user.dart';

class UserCard extends StatelessWidget {
  const UserCard({super.key, required this.user});

  final AppUser user;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      margin: const EdgeInsets.fromLTRB(5, 0, 5, 10),
      width: double.maxFinite,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(12.0)),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 1),
            blurRadius: 6.0,
            blurStyle: BlurStyle.outer,
            color: AppColor.black.withOpacity(0.2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            flex: 7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextDescripton(
                  title: 'Name',
                  subtitle: user.name,
                  fontSize: 12.0,
                  gap: 3.0,
                ),
                const SpaceHeight(5.0),
                TextDescripton(
                  title: 'Role',
                  subtitle: user.role.value,
                  fontSize: 12.0,
                  gap: 3.0,
                ),
                const SpaceHeight(5.0),
                TextDescripton(
                  title: 'Email',
                  subtitle: user.email,
                  fontSize: 12.0,
                  gap: 3.0,
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => EditUserRoleDialog(user: user),
                );
              },
              child: SvgPicture.asset(
                'assets/icons/repair-tool.svg',
                colorFilter: const ColorFilter.mode(
                  AppColor.primary,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class EditUserRoleDialog extends StatefulWidget {
  const EditUserRoleDialog({super.key, required this.user});

  final AppUser user;

  @override
  State<EditUserRoleDialog> createState() => _EditUserRoleDialogState();
}

class _EditUserRoleDialogState extends State<EditUserRoleDialog> {
  ValueNotifier currentIndex = ValueNotifier(0);
  UserRole role = UserRole.none;

  void onButtonTap(int index) {
    setState(() {
      currentIndex.value = index;

      if (index == 0) {
        role = UserRole.none;
      } else if (index == 1) {
        role = UserRole.cashier;
      } else if (index == 2) {
        role = UserRole.supervisor;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var user = widget.user;

    return AlertDialog(
      content: ValueListenableBuilder(
        valueListenable: currentIndex,
        builder: (context, value, _) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Edit ${user.name}'s Role",
              style: AppTextStyle.blue(
                  fontSize: 16.0, fontWeight: FontWeight.w700),
            ),
            const SpaceHeight(15.0),
            AppButton(
              title: 'None',
              isActive: currentIndex.value == 0,
              withIcon: true,
              iconPath: 'assets/icons/error.svg',
              isRow: true,
              width: 160.0,
              height: 60.0,
              onTap: () => onButtonTap(0),
            ),
            const SpaceHeight(10.0),
            AppButton(
              title: 'Cashier',
              isActive: currentIndex.value == 1,
              withIcon: true,
              iconPath: 'assets/icons/cashier.svg',
              isRow: true,
              width: 160.0,
              height: 60.0,
              onTap: () => onButtonTap(1),
            ),
            const SpaceHeight(10.0),
            AppButton(
              title: 'Supervisor',
              isActive: currentIndex.value == 2,
              withIcon: true,
              iconPath: 'assets/icons/person.svg',
              isRow: true,
              width: 160.0,
              height: 60.0,
              onTap: () => onButtonTap(2),
            ),
            const SpaceHeight(20.0),
            BlocListener<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthLoggedIn) {
                  Future.delayed(
                    const Duration(milliseconds: 100),
                    () => AppDialog.show(
                      context,
                      contentColor: AppColor.primary,
                      iconPath: 'assets/icons/information.svg',
                      message: 'User Role Successfully Updated',
                    ),
                  );
                } else if (state is AuthError) {
                  Future.delayed(
                    const Duration(milliseconds: 100),
                    () => AppDialog.show(
                      context,
                      contentColor: AppColor.primary,
                      iconPath: 'assets/icons/information.svg',
                      message: state.message,
                    ),
                  );
                }
              },
              child: AppButton(
                title: 'Save',
                onTap: () {
                  context
                      .read<AuthBloc>()
                      .add(AuthUpdateUserRole(uid: user.uid, role: role));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
