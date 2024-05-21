import 'dart:developer';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_quran/core/utils/consts.dart';
import 'package:the_quran/core/utils/validation.dart';
import 'package:the_quran/features/auth/controller/bloc/auth_controller_bloc.dart';
import 'package:the_quran/features/auth/view/components/app_text_form_field.dart';
import 'package:the_quran/features/auth/view/components/gradient_background.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
      ),
      body: BlocProvider(
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
                      "Forgot Password",
                      style: Consts.titleLarge,
                    ),
                    SizedBox(height: 6),
                    Text("Forgot Password", style: Consts.bodySmall),
                  ],
                ),
                const SizedBox(height: 20),
                Form(
                  key: bloc.formKey,
                  child: AppTextFormField(
                    controller: bloc.emailController,
                    labelText: "Email",
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: Validator().validateMail,
                  ),
                ),
                const SizedBox(height: 20),
                FilledButton(
                  onPressed: () async {
                    if (bloc.emailController.text.isNotEmpty) {
                      bloc.add(ForgetPass(bloc.emailController.text.trim()));
                    }
                  },
                  child: const Text('Reset Password'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
