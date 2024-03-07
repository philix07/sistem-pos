import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kerja_praktek/data/repository/auth_repository.dart';
import 'package:kerja_praktek/frontend/blocs/auth/auth_bloc.dart';
import 'package:kerja_praktek/frontend/common/components/app_back_bar.dart';
import 'package:kerja_praktek/frontend/common/components/app_dialog.dart';
import 'package:kerja_praktek/frontend/common/components/app_scaffold.dart';
import 'package:kerja_praktek/frontend/common/components/spaces.dart';
import 'package:kerja_praktek/frontend/common/style/app_style.dart';
import 'package:kerja_praktek/frontend/presentation/setting/bloc/app_user_bloc.dart';
import 'package:kerja_praktek/frontend/presentation/setting/widget/user_card.dart';
import 'package:kerja_praktek/models/user.dart';

class ManageUserPage extends StatefulWidget {
  const ManageUserPage({super.key});

  @override
  State<ManageUserPage> createState() => _ManageUserPageState();
}

class _ManageUserPageState extends State<ManageUserPage> {
  @override
  void initState() {
    context.read<AppUserBloc>().add(AppUserFetchAllData());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      padding: const EdgeInsets.all(10.0),
      child: BlocBuilder<AppUserBloc, AppUserState>(
        builder: (context, state) {
          if (state is AppUserError) {
            Future.delayed(
              const Duration(milliseconds: 100),
              () => AppDialog.show(
                context,
                iconPath: 'assets/icons/error.svg',
                message: state.message,
              ),
            );
          } else if (state is AppUserLoading) {
            const Expanded(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (state is AppUserDataFetched) {
            return Column(
              children: [
                const AppBackBar(title: 'Manajemen Data Karyawan'),
                Expanded(
                  child: ListView.builder(
                    itemCount: state.users.length,
                    itemBuilder: (context, index) => UserCard(
                      user: state.users[index],
                    ),
                  ),
                ),
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
