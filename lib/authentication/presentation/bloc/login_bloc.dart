import 'dart:async';
import 'package:e_commerce/authentication/presentation/bloc/auth_bloc.dart';
import 'package:e_commerce_data/auth_data/models/models.dart';
import 'package:e_commerce_repository/ecommerce_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Events
sealed class LoginEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginSubmitted extends LoginEvent {
  LoginSubmitted(this.userData);

  final UserModel userData;

  @override
  List<Object> get props => [userData];
}

// States
sealed class LoginState extends Equatable {
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

// Bloc
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository _authRepository;
  final AuthBloc _authBloc;

  LoginBloc(this._authRepository, this._authBloc) : super(LoginInitial()) {
    on<LoginSubmitted>(_onLoginSubmitted);
  }

  FutureOr<void> _onLoginSubmitted(event, emit) async {
    emit(LoginLoading());
    try {
      final loginData = await _authRepository.loginUser(event.userData);
      if (loginData.isSuccess == true && loginData.data != null) {
        _authBloc.add(LoggedIn(loginData.data!.token));
        emit(LoginSuccess());
      } else {
        emit(LoginFailure(loginData.error ?? "Unkown error"));
      }
    } catch (e) {
      emit(LoginFailure("Login failed: ${e.toString()}"));
    }
  }
}
