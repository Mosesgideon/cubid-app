import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:social_media/app_constants/theme/theme_cubit/theme_cubit.dart';
import 'package:social_media/features/about/about.dart';
import 'package:social_media/features/help/presentations/screens/help.dart';
import 'package:social_media/features/notifications/presentations/screens/notifications.dart';
import 'package:social_media/features/profile/presentation/screens/profile_page.dart';
import 'package:social_media/features/settings/sreens/presentations/account_setting.dart';
import 'package:social_media/features/settings/sreens/presentations/emial_setting.dart';
import 'package:social_media/features/settings/sreens/presentations/faq.dart';
import 'package:social_media/features/settings/sreens/widgets/settins_items.dart';

class Settings extends StatefulWidget {
  const Settings({
    Key? key,
  }) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  // var _darkEnabled = true;
  bool isDark = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            "Settings",
            style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
                fontSize: 18,
                fontWeight: FontWeight.w500),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Icon(
              Iconsax.setting_2,
              color: Theme.of(context).colorScheme.onBackground,
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SettingsItems(
                  subtitle: 'Account',
                  voidCallback: () {
                    Navigator.of(context).push(CupertinoPageRoute(
                        builder: (index) => const Profile()));
                  },
                  text: 'Account',
                  icon: Iconsax.profile_add,
                ),
                SettingsItems(
                  subtitle: 'set email restrictions',
                  voidCallback: () {
                    Navigator.of(context).push(
                        CupertinoPageRoute(builder: (index) => EmailSetting()));
                  },
                  text: 'Email Setting',
                  icon: Iconsax.message,
                ),
                SettingsItems(
                  subtitle: 'check for notifications',
                  voidCallback: () {
                    Navigator.of(context).push(CupertinoPageRoute(
                        builder: (index) => const NotificationsScreen()));
                  },
                  text: 'Notifications',
                  icon: Iconsax.notification,
                ),
                SettingsItems(
                  voidCallback: () {},
                  subtitle: 'Toggle for dark mood',
                  text: 'Dark Mood',
                  icon: Iconsax.moon,
                  widget: Switch(
                      thumbColor: MaterialStateColor.resolveWith((states) =>
                          Theme.of(context).colorScheme.onBackground),
                      trackColor: MaterialStateColor.resolveWith(
                          (states) => Theme.of(context).colorScheme.primary),
                      value: isDark,
                      onChanged: (val) async {
                        setState(() {
                          isDark = !isDark;
                        });
                        context.read<ThemeCubit>().setTheme(isDark);
                      }),
                ),
                SettingsItems(
                  subtitle: 'more to know about the app ',
                  voidCallback: () {
                    Navigator.of(context).push(CupertinoPageRoute(
                        builder: (index) => const AboutPage()));
                  },
                  text: 'About Cubid Chat App',
                  icon: Iconsax.info_circle,
                ),
                SettingsItems(
                  subtitle: 'freequently asked questions ',
                  voidCallback: () {
                    Navigator.of(context).push(
                        CupertinoPageRoute(builder: (index) => const FAQ()));
                  },
                  text: 'FAQ',
                  icon: Iconsax.message_question,
                ),
                SettingsItems(
                  subtitle: 'need any help ',
                  voidCallback: () {
                    Navigator.of(context).push(CupertinoPageRoute(
                        builder: (index) => const UserHelp()));
                  },
                  text: 'Help and Support',
                  icon: Iconsax.message_question,
                ),
              ],
            ),
          ))
        ],
      ),
    );
  }
}

_Settings(
  String heading,
  subheading,
  IconData icon,
  VoidCallback voidCallback,
) {
  return GestureDetector(
    onTap: voidCallback,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Icon(icon, color: Colors.black54),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    heading,
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                  Text(
                    subheading,
                    style: const TextStyle(color: Colors.black54),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          const Divider(),
        ],
      ),
    ),
  );
}
