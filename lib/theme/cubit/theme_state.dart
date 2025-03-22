part of 'theme_cubit.dart';

/// State of [ThemeCubit] which uses the [ThemeMode] enum.
class ThemeState extends Equatable {
  const ThemeState({this.themeMode = ThemeMode.system});

  final ThemeMode themeMode;
  @override
  List<Object> get props => [themeMode];
}
