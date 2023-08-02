import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:social_media/helpers/storage_helper.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeInitial());

  void getTheme() async {
    bool isDark = await StorageHelper.getBoolean('darkMode', false);
    emit(ThemeChangedState(isDark));
  }


  void setTheme(bool darkmode) async {
    await StorageHelper.setBoolean('darkMode', darkmode);
    getTheme();
  }
}
