part of 'auth_controller_bloc.dart';

@immutable
abstract class AuthControllerEvent {
  const AuthControllerEvent();

  List<Object> get props => [];
}

class SignUp extends AuthControllerEvent {
  final String email;
  final String name;
  final String password;

  const SignUp(this.email, this.password, this.name);

  @override
  List<Object> get props => [email, password];
}

class Login extends AuthControllerEvent {
  final String email;
  final String password;

  const Login(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}

class ForgetPass extends AuthControllerEvent {
  final String email;

  const ForgetPass(this.email);

  @override
  List<Object> get props => [email];
}

class SignOut extends AuthControllerEvent {}
