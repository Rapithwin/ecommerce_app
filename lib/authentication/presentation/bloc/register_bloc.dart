import 'package:e_commerce_data/auth_data/models/models.dart';
import 'package:equatable/equatable.dart';

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
