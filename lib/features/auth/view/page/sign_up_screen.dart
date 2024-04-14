import 'dart:developer';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_quran/core/utils/validation.dart';
import 'package:the_quran/features/auth/controller/bloc/auth_controller_bloc.dart';
import 'package:the_quran/features/auth/view/page/home_page.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
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
              } else if (state is AuthControllerFeedbackState) {
                log("success");
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.success,
                    animType: AnimType.rightSlide,
                    title: 'Error',
                    desc: state.feedbackMessage,
                    btnCancelOnPress: () {},
                    btnOkOnPress: () {},
                  ).show();
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
                        validator: Validator().validateMail),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: bloc.passwordController,
                      decoration: const InputDecoration(labelText: 'Password'),
                      obscureText: true,
                      validator: Validator().validatePass,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        if (bloc.emailController.text.isNotEmpty &&
                            bloc.passwordController.text.isNotEmpty) {
                          bloc.add(SignUp(bloc.emailController.text.trim(),
                              bloc.passwordController.text.trim()));
                        }
                      },
                      child: const Text('Sign Up'),
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
