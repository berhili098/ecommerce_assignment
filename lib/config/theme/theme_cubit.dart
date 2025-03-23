import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.light);
  bool get isDark => state == ThemeMode.dark;

  void changeTheme() {
    emit(isDark ? ThemeMode.light : ThemeMode.dark);
  }
}
