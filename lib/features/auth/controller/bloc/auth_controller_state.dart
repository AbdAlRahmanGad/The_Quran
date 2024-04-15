part of 'auth_controller_bloc.dart';

@immutable
abstract class AuthControllerState {
  const AuthControllerState();

  List<Object> get props => [];
}

class AuthControllerInitialState extends AuthControllerState {}

class AuthControllerLoadingState extends AuthControllerState {
  final bool isLoading;

  const AuthControllerLoadingState({required this.isLoading});
}

class AuthControllerSuccessState extends AuthControllerState {
  final UserModel user;

  const AuthControllerSuccessState(this.user);
  @override
  List<Object> get props => [user];
}

class AuthControllerFailureState extends AuthControllerState {
  final String errorMessage;

  const AuthControllerFailureState(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

class AuthControllerFeedbackState extends AuthControllerState {
  final String feedbackMessage;

  const AuthControllerFeedbackState(this.feedbackMessage);

  @override
  List<Object> get props => [feedbackMessage];
}
