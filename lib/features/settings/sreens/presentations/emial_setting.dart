import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:social_media/features/settings/sreens/widgets/settins_items.dart';

class EmailSetting extends StatefulWidget {
  const EmailSetting({Key? key}) : super(key: key);

  @override
  State<EmailSetting> createState() => _EmailSettingState();
}

class _EmailSettingState extends State<EmailSetting> {
  late bool restricted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            SettingsItems(
              voidCallback: () {},
              subtitle: 'prevent email access',
              text: 'Hide Email',
              icon: Iconsax.message,
              widget: Switch(
                thumbColor: MaterialStateColor.resolveWith(
                    (states) => Theme.of(context).colorScheme.onBackground),
                trackColor: MaterialStateColor.resolveWith(
                    (states) => Theme.of(context).colorScheme.primary),
                // value: isDark,
                onChanged: (val) async {
                  setState(() {
                    restricted = !restricted;
                  });
                  // context.read<ThemeCubit>().setTheme(isDark);
                },
                value: restricted,
              ),
            ),
            SettingsItems(
              voidCallback: () {},
              subtitle: 'add new email address',
              text: 'Change Email',
              icon: Iconsax.message,
            ),
            SettingsItems(
              voidCallback: () {},
              subtitle: 'add another email address',
              text: 'Additional Email',
              icon: Iconsax.message,
            ),
          ],
        ),
      ),
    );
  }
}
