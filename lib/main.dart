import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:social_media/app_constants/theme/app_theme.dart';
import 'package:social_media/app_constants/theme/theme_cubit/theme_cubit.dart';
import 'package:social_media/features/home_screen/presentation/homeScreen.dart';
import 'package:social_media/features/onboarding_screen/screens/splash_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/helpers/api_helper.dart';
import 'package:social_media/services/push_notification_services.dart';

import 'features/authentication/presentation/screens/verify_email_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await PushNotificationService.inititialize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({
    super.key,
  });

  bool isDark = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThemeCubit()..getTheme(),
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          if (state is ThemeChangedState) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: state.isDark ? AppTheme.darkTheme : AppTheme.lightTheme,
              home: Scaffold(
                  body: StreamBuilder<User?>(
                      stream: FirebaseAuth.instance.authStateChanges(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return const VerifyEmailScreen();
                        }
                        return const SplashScreen();
                      })),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
