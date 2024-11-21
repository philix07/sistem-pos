import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kerja_praktek/frontend/blocs/auth/auth_bloc.dart';
import 'package:kerja_praktek/frontend/common/components/app_button.dart';
import 'package:kerja_praktek/frontend/common/components/app_scaffold.dart';
import 'package:kerja_praktek/frontend/common/components/spaces.dart';
import 'package:kerja_praktek/frontend/common/style/app_style.dart';
import 'package:kerja_praktek/frontend/common/utils/form_validator.dart';
import 'package:kerja_praktek/frontend/presentation/auth/sign_up_page.dart';
import 'package:kerja_praktek/frontend/presentation/auth/widgets/auth_text_field.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final formValidator = AppFormValidator();

    return AppScaffold(
      padding: const EdgeInsets.all(0),
      child: Form(
        key: formValidator.formState,
        child: Stack(
          children: [
            // Background Container
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fitHeight,
                  image: AssetImage('assets/images/light-blue-3.jpg'),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const CircleAvatar(
                    radius: 55.0,
                    backgroundImage: AssetImage('assets/images/logo_apk_2.png'),
                  ),
                  const SpaceHeight(20.0),
                  AuthTextField(
                    title: 'EMAIL',
                    iconPath: 'assets/icons/email.svg',
                    inputFormatters: AppFormValidator().acceptAll(),
                    validator: (val) {
                      return formValidator.validateEmail(val);
                    },
                    controller: emailController,
                  ),
                  AuthTextField(
                    title: 'PASSWORD',
                    iconPath: 'assets/icons/lock.svg',
                    inputFormatters: AppFormValidator().wordAndNumber(),
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'Please enter a password';
                      }
                      return null;
                    },
                    controller: passwordController,
                    obscureText: true,
                  ),
                  InkWell(
                    onTap: () {
                      //TODO: Forgot Password Page
                    },
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(0, 0, 10.0, 20.0),
                      width: double.maxFinite,
                      child: Text(
                        "Forgot Password ?",
                        textAlign: TextAlign.end,
                        style: AppTextStyle.blue(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                  ),
                  AppButton(
                    width: double.maxFinite,
                    title: "LOGIN",
                    isActive: true,
                    onTap: () {
                      //TODO: Validate Input And Trigger Login Event
                      if (formValidator.formState.currentState!.validate()) {
                        context.read<AuthBloc>().add(AuthLogin(
                              email: emailController.text,
                              password: passwordController.text,
                            ));
                      }
                    },
                  ),
                  const SpaceHeight(20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account? ",
                        style: AppTextStyle.black(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignUpPage(),
                            ),
                          );
                        },
                        child: Text(
                          "create a new account",
                          style: AppTextStyle.blue(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
