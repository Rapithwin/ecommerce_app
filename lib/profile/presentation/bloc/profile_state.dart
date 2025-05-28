part of 'profile_cubit.dart';

enum ProfileStatus { initial, loading, success, failure }

extension ProfileStatusX on ProfileStatus {
  bool get isInitial => this == ProfileStatus.initial;
  bool get isLoading => this == ProfileStatus.loading;
  bool get isSuccess => this == ProfileStatus.success;
  bool get isFailure => this == ProfileStatus.failure;
}

final class ProfileState extends Equatable {
  final ProfileStatus status;
  final UserModel? userData;
  final String? error;

  const ProfileState({
    required this.status,
    this.userData,
    this.error,
  });

  ProfileState copyWith({
    ProfileStatus? status,
    UserModel? userData,
    String? error,
  }) {
    return ProfileState(
      status: status ?? this.status,
      userData: userData ?? this.userData,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [status, userData, error];
}
