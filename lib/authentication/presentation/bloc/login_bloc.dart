import 'package:equatable/equatable.dart';

// Events
abstract class LoginEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginSubmitted extends LoginEvent {
  LoginSubmitted(this.email, this.password);

  final String email;
  final String password;

  @override
  List<Object> get props => [email, password];
}

// States
abstract class LoginState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginFailure extends LoginState {
  final String error;
  LoginFailure(this.error);

  @override
  List<Object?> get props => [error];
}
