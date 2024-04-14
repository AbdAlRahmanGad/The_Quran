import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:the_quran/core/utils/auth_service.dart';
import 'package:the_quran/features/auth/model/user_model.dart';

part 'auth_controller_event.dart';
part 'auth_controller_state.dart';

class AuthControllerBloc
    extends Bloc<AuthControllerEvent, AuthControllerState> {
  final AuthService authService = AuthService();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  AuthControllerBloc() : super(AuthControllerInitialState()) {
    on<AuthControllerEvent>((event, emit) {});

    on<SignUp>((event, emit) async {
      if (formKey.currentState!.validate()) {
        emit(const AuthControllerLoadingState(isLoading: true));
        try {
          final UserModel? user =
              await authService.signUp(event.email, event.password);
          if (user != null) {
            emit(const AuthControllerFeedbackState("Signed up successfully"));
          } else {
            emit(const AuthControllerFailureState('create user failed'));
          }
        } on FirebaseException catch (e) {
          emit(AuthControllerFailureState(e.message ?? "Unknown error"));
        }
      }
    });

    on<Login>((event, emit) async {
      if (formKey.currentState!.validate()) {
        emit(const AuthControllerLoadingState(isLoading: true));

        try {
          final UserModel? user =
              await authService.login(event.email, event.password);
          if (user != null) {
            emit(AuthControllerSuccessState(user));
          } else {
            emit(const AuthControllerFailureState('create user failed'));
          }
        } on FirebaseException catch (e) {
          emit(AuthControllerFailureState(e.message ?? "Unknown error"));
        }
      }
    });

    on<SignOut>((event, emit) async {
      emit(const AuthControllerLoadingState(isLoading: true));
      try {
        authService.signOut();
      } on FirebaseException catch (e) {
        emit(AuthControllerFailureState(e.message ?? "Unknown error"));
      }
    });

    on<ForgetPass>((event, emit) async {
      if (formKey.currentState!.validate()) {
        emit(const AuthControllerLoadingState(isLoading: true));
        try {
          authService.resetPassword(event.email);
          emit(const AuthControllerFeedbackState("Email sent successfully"));
        } on FirebaseException catch (e) {
          log(e.toString());
          emit(AuthControllerFailureState(e.message ?? "Unknown error"));
        }
      }
    });
  }
}
