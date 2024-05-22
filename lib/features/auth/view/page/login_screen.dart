import 'dart:developer';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_quran/core/utils/consts.dart';
import 'package:the_quran/core/utils/validation.dart';
import 'package:the_quran/features/auth/controller/bloc/auth_controller_bloc.dart';
import 'package:the_quran/features/auth/view/components/app_text_form_field.dart';
import 'package:the_quran/features/auth/view/components/gradient_background.dart';
import 'package:the_quran/features/auth/view/page/forgot_password_screen.dart';
import 'package:the_quran/features/auth/view/page/sign_up_screen.dart';
import 'package:the_quran/features/dashboard/view/page/dashboard_page.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => AuthControllerBloc(
          onSignSuccess: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const DashboardPage()),
              (route) => false,
            );
          },
        ),
        child: BlocBuilder<AuthControllerBloc, AuthControllerState>(
          builder: (context, state) {
            if (state is AuthControllerLoadingState &&
                state.isLoading == true) {
              log("loading");
              return const Center(child: CircularProgressIndicator());
            } else if (state is AuthControllerSuccessState) {
              log("success");
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const DashboardPage()),
                  (route) => false,
                );
              });
            } else if (state is AuthControllerFailureState) {
              log("Failed");
              WidgetsBinding.instance.addPostFrameCallback((_) {
                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.error,
                  animType: AnimType.rightSlide,
                  title: 'Error',
                  desc: state.errorMessage,
                  btnCancelOnPress: () {},
                  btnOkOnPress: () {},
                ).show();
              });
            }
            AuthControllerBloc bloc = context.read<AuthControllerBloc>();
            return ListView(
              padding: EdgeInsets.zero,
              children: [
                const GradientBackground(
                  children: [
                    Text(
                      "Log In with your account",
                      style: Consts.titleLarge,
                    ),
                    SizedBox(height: 6),
                    Text("Log in with your account", style: Consts.bodySmall),
                  ],
                ),
                Form(
                  key: bloc.formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        AppTextFormField(
                          controller: bloc.emailController,
                          labelText: "Email",
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: Validator().validateMail,
                        ),
                        AppTextFormField(
                          autovalidateMode: AutovalidateMode.always,
                          obscureText: true,
                          controller: bloc.passwordController,
                          labelText: "Password",
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.visiblePassword,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const ForgotPasswordScreen()),
                            );
                          },
                          child: const Text("Forgot your password"),
                        ),
                        const SizedBox(height: 20),
                        FilledButton(
                          onPressed: () async {
                            if (bloc.emailController.text.isNotEmpty &&
                                bloc.passwordController.text.isNotEmpty) {
                              bloc.add(Login(
                                bloc.emailController.text.trim(),
                                bloc.passwordController.text.trim(),
                              ));
                            }
                          },
                          child: const Text("LogIn"),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: Consts.bodySmall.copyWith(color: Colors.black),
                    ),
                    const SizedBox(width: 4),
                    TextButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignUpScreen()),
                      ),
                      child: const Text("Register"),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
