import 'dart:developer';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:the_quran/core/utils/auth_service.dart';
import 'package:the_quran/core/utils/consts.dart';
import 'package:the_quran/features/auth/model/user_details.dart';
import 'package:the_quran/features/auth/model/user_model.dart';
import 'package:the_quran/features/dashboard/controller/database_helper.dart';
import 'package:the_quran/features/dashboard/controller/firebase_data.dart';

part 'auth_controller_event.dart';
part 'auth_controller_state.dart';

class AuthControllerBloc
    extends Bloc<AuthControllerEvent, AuthControllerState> {
  final AuthService authService = AuthService();
  final Function onSignSuccess;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  AuthControllerBloc({this.onSignSuccess = _defaultOnSignSuccess})
      : super(AuthControllerInitialState()) {
    on<AuthControllerEvent>((event, emit) {});

    on<SignUp>((event, emit) async {
      if (formKey.currentState!.validate()) {
        emit(const AuthControllerLoadingState(isLoading: true));
        try {
          final user = await authService.signUp(event.email, event.password);
          if (user != null) {
            await Consts.auth.currentUser!.updateDisplayName(event.name);
            var userDetails = UserDetails(
              userId: FirebaseRepo().fetch()!.uid,
              userFullName: event.name,
              favouriteReciters: List.empty(),
            );
            DatabaseHelper.instance.insertUserDetails(userDetails);
            Reference ref = FirebaseStorage.instance
                .ref()
                .child('User_Images')
                .child("Def");
            final byteData = await rootBundle.load('assets/images/DORR.png');
            final file = File('${(await getTemporaryDirectory()).path}/test');
            await file.writeAsBytes(byteData.buffer
                .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
            await ref.putFile(file);
            String imageURL = await ref.getDownloadURL();

            await Consts.auth.currentUser!.updatePhotoURL(imageURL);

            emit(const AuthControllerFeedbackState("Signed up successfully"));
            onSignSuccess();
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
            onSignSuccess();
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

  static void _defaultOnSignSuccess() {}
}
