import 'package:e_commerce_data/auth_data/models/models.dart';
import 'package:e_commerce_repository/ecommerce_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this._authRepository) : super(ProfileState());
  final AuthRepository _authRepository;

  Future<void> fetchUserDetails(String token) async {
    emit(state.copyWith(status: ProfileStatus.loading));

    try {
      final userData = await _authRepository.getUser(token);
      emit(state.copyWith(userData: userData, status: ProfileStatus.success));
    } catch (e) {
      emit(
        state.copyWith(
          status: ProfileStatus.failure,
          error: e.toString(),
        ),
      );
    }
  }

  void clearUserData() {
    emit(ProfileState());
  }
}
