import 'dart:developer';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_quran/core/utils/validation.dart';
import 'package:the_quran/features/auth/controller/bloc/auth_controller_bloc.dart';
import 'package:the_quran/features/auth/view/page/forgot_password_screen.dart';
import 'package:the_quran/features/auth/view/page/home_page.dart';
import 'package:the_quran/features/auth/view/page/sign_up_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Log In'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocProvider(
          create: (context) => AuthControllerBloc(),
          child: BlocBuilder<AuthControllerBloc, AuthControllerState>(
            builder: (context, state) {
              if (state is AuthControllerLoadingState &&
                  state.isLoading == true) {
                log("loading");
                return const Center(child: CircularProgressIndicator());
              } else if (state is AuthControllerSuccessState) {
                log("success");
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                  );
                });
              } else if (state is AuthControllerFailureState) {
                log("Failded");
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
              return Form(
                key: bloc.formkey,
                child: Column(
                  children: [
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: bloc.emailController,
                      decoration: const InputDecoration(labelText: 'Email'),
                      validator: Validator().validateMail,
                    ),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: bloc.passwordController,
                      decoration: const InputDecoration(labelText: 'Password'),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        if (bloc.emailController.text.isNotEmpty &&
                            bloc.passwordController.text.isNotEmpty) {
                          bloc.add(Login(
                            bloc.emailController.text.trim(),
                            bloc.passwordController.text.trim(),
                          ));
                        }
                      },
                      child: const Text('Log In'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUpScreen()),
                        );
                      },
                      child: const Text('Don\'t have an account? Sign Up'),
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
                      child: const Text('Forgot Password?'),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
