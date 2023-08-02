part of 'theme_cubit.dart';

abstract class ThemeState extends Equatable {
  const ThemeState();
}

class ThemeInitial extends ThemeState {
  @override
  List<Object> get props => [];
}

class ThemeChangedState extends ThemeState {
  bool isDark;

  ThemeChangedState(this.isDark);

  @override
  List<Object?> get props => [isDark];
}
