import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_state.dart';

/// Cubit for managing [ThemeState].
class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(const ThemeState()) {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final themeIndex = prefs.getInt('theme') ?? 2; // Default: system theme
    emit(ThemeState(themeMode: _getThemeMode(themeIndex)));
  }

  Future<void> setTheme(ThemeMode themeMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('theme', themeMode.index);
    emit(ThemeState(themeMode: _getThemeMode(themeMode.index)));
  }

  ThemeMode _getThemeMode(int index) {
    switch (index) {
      case 0:
        return ThemeMode.system;
      case 1:
        return ThemeMode.light;
      case 2:
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }
}
