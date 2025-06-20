// Events
import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

sealed class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AppStarted extends AuthEvent {}

class LoggedIn extends AuthEvent {
  final String token;
  LoggedIn(this.token);

  @override
  List<Object?> get props => [token];
}

class LoggedOut extends AuthEvent {}

// States
sealed class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class Authenticated extends AuthState {
  final String token;

  Authenticated({required this.token});
  @override
  List<Object?> get props => [token];
}

class Unauthenticated extends AuthState {}

// Bloc
class AuthBloc extends HydratedBloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AppStarted>(_onAppStarted);
    on<LoggedIn>(_onLoginRequested);
    on<LoggedOut>(_onLogoutRequested);
  }

  FutureOr<void> _onLogoutRequested(event, emit) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("jwt_token");
    emit(Unauthenticated());
  }

  FutureOr<void> _onLoginRequested(event, emit) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("jwt_token", event.token);
    emit(Authenticated(token: event.token));
  }

  FutureOr<void> _onAppStarted(event, emit) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("jwt_token");
    if (token != null && token.isNotEmpty && !JwtDecoder.isExpired(token)) {
      emit(Authenticated(token: token));
    } else {
      prefs.remove("jwt_token");
      emit(Unauthenticated());
    }
  }

  @override
  AuthState? fromJson(Map<String, dynamic> json) {
    if (json['token'] != null) {
      return Authenticated(token: json['token']);
    }
    return Unauthenticated();
  }

  @override
  Map<String, dynamic>? toJson(AuthState state) {
    if (state is Authenticated) {
      return {'token': state.token};
    }
    return null;
  }
}
