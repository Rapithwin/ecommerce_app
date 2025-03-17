part of 'theme_cubit.dart';

enum ThemeMode { dark, light, system }

class ThemeState extends Equatable {
  const ThemeState({this.themeMode = ThemeMode.system});

  final ThemeMode themeMode;
  @override
  List<Object> get props => [themeMode];
}
