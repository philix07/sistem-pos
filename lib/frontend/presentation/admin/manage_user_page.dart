import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kerja_praktek/frontend/blocs/auth/auth_bloc.dart';
import 'package:kerja_praktek/frontend/common/components/app_dialog.dart';
import 'package:kerja_praktek/frontend/common/components/app_scaffold.dart';
import 'package:kerja_praktek/frontend/presentation/admin/widget/user_card.dart';

class ManageUserPage extends StatefulWidget {
  const ManageUserPage({super.key});

  @override
  State<ManageUserPage> createState() => _ManageUserPageState();
}

class _ManageUserPageState extends State<ManageUserPage> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(AuthFetchAllData());
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      padding: const EdgeInsets.all(10.0),
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthError) {
            Future.delayed(
              const Duration(milliseconds: 100),
              () => AppDialog.show(
                context,
                iconPath: 'assets/icons/error.svg',
                message: state.message,
              ),
            );
          } else if (state is AuthLoading) {
            const Expanded(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (state is AuthUserDataFetched) {
            return ListView.builder(
              itemCount: state.users.length,
              itemBuilder: (context, index) => UserCard(
                user: state.users[index],
              ),
            );
          }

          print('current manage user page state $state');
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
