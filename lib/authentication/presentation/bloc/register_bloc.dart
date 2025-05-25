import 'package:e_commerce_data/auth_data/models/models.dart';
import 'package:e_commerce_repository/ecommerce_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

sealed class RegisterEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class RegisterSubmitted extends RegisterEvent {
  RegisterSubmitted(this.userData);

  final UserModel userData;

  @override
  List<Object> get props => [userData];
}

// States
sealed class RegisterState extends Equatable {
  @override
  List<Object?> get props => [];
}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {}

class RegisterFailure extends RegisterState {
  final String error;
  RegisterFailure(this.error);

  @override
  List<Object?> get props => [error];
}

// Bloc
class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthRepository _authRepository;

  RegisterBloc(this._authRepository) : super(RegisterInitial()) {
    on<RegisterSubmitted>((event, emit) async {
      emit(RegisterLoading());
      try {
        final registerData = await _authRepository.registerUser(event.userData);
        if (registerData.isSuccess) {
          emit(RegisterSuccess());
        } else {
          emit(RegisterFailure(registerData.error ?? "Unkown register error"));
        }
      } catch (e) {
        emit(RegisterFailure("Register Failed ${e.toString()}"));
      }
    });
  }
}
