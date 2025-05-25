// Events
abstract class AuthEvent {}

class AppStarted extends AuthEvent {}

class LoggedIn extends AuthEvent {
  final String token;
  LoggedIn(this.token);
}

class LoggedOut extends AuthEvent {}

// States
abstract class AuthState {}

class AuthInitial extends AuthState {}

class Authenticated extends AuthState {}

class Unauthenticated extends AuthState {}
