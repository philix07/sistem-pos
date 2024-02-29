import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kerja_praktek/frontend/blocs/auth/auth_bloc.dart';
import 'package:kerja_praktek/frontend/common/components/app_button.dart';
import 'package:kerja_praktek/frontend/common/components/app_scaffold.dart';
import 'package:kerja_praktek/frontend/common/components/spaces.dart';
import 'package:kerja_praktek/frontend/common/style/app_colors.dart';
import 'package:kerja_praktek/frontend/common/style/app_style.dart';
import 'package:kerja_praktek/frontend/common/utils/form_validator.dart';
import 'package:kerja_praktek/frontend/presentation/auth/widgets/auth_text_field.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                  Text(
                    'Create Account',
                    style: AppTextStyle.blue(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Create new account',
                    style: AppTextStyle.gray(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SpaceHeight(20.0),
                  AuthTextField(
                    title: 'EMAIL',
                    iconPath: 'assets/icons/email.svg',
                    inputFormatters: AppFormValidator().acceptAll(),
                    validator: (value) {
                      return formValidator.validateEmail(value);
                    },
                    controller: emailController,
                  ),
                  AuthTextField(
                    title: 'PASSWORD',
                    iconPath: 'assets/icons/lock.svg',
                    inputFormatters: AppFormValidator().wordAndNumber(),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a password';
                      } else if (value.length < 8) {
                        return 'Password must be at least 8 characters';
                      }
                      return null;
                    },
                    controller: passwordController,
                    obscureText: true,
                  ),
                  const Divider(
                    thickness: 1,
                    color: AppColor.black,
                  ),
                  AuthTextField(
                    title: 'USERNAME',
                    iconPath: 'assets/icons/person.svg',
                    inputFormatters: AppFormValidator().textOnly(),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                    controller: usernameController,
                  ),
                  const SpaceHeight(20.0),
                  AppButton(
                    width: double.maxFinite,
                    title: "CREATE AN ACCOUNT",
                    isActive: true,
                    onTap: () async {
                      //TODO: Validate Input And Trigger Login Event
                      if (formValidator.formState.currentState!.validate()) {
                        context.read<AuthBloc>().add(AuthRegister(
                              email: emailController.text,
                              password: passwordController.text,
                              username: usernameController.text,
                            ));

                        Navigator.pop(context);
                      }
                    },
                  ),
                  const SpaceHeight(20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account? ",
                        style: AppTextStyle.black(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "login",
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
