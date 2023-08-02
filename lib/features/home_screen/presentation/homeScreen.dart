import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:social_media/features/app_users/presentations/screens/app_users.dart';
import 'package:social_media/features/chat_page/presentation/screens/chat_list/chat_page.dart';
import 'package:social_media/features/chats_tab/presentations/widgets/chat_list.dart';
import 'package:social_media/features/help/presentations/screens/help.dart';
import 'package:social_media/features/home_screen/presentation/drawermenu.dart';
import 'package:social_media/features/menu_tab/presentations/screens/menu.dart';
import 'package:social_media/features/notifications/presentations/screens/notifications.dart';
import 'package:social_media/features/profile/presentation/screens/profile_page.dart';
import 'package:social_media/features/settings/sreens/presentations/settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late bool open = false;
  int selectindex = 0;
  static List<StatefulWidget> pages = [
    const UserMenu(),
    Chats(),
    const NotificationsScreen(),
    const Settings(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: DrawerMenu(
      //   drawerItems: [
      //     GroupDrawerItem(tittle: '', hasDivider: true, children: [
      //       DrawerItem(
      //           text: 'Home',
      //           icon: Iconsax.home_1,
      //           voidCallback: () {
      //             _switchTap(0);
      //           }),
      //       DrawerItem(
      //           text: 'Chats',
      //           icon: Iconsax.message,
      //           voidCallback: () {
      //             _switchTap(1);
      //           }),
      //       DrawerItem(
      //           text: 'Profile',
      //           icon: Iconsax.profile_add,
      //           voidCallback: () {
      //             _switchTap(2);
      //           }),
      //       DrawerItem(
      //           text: 'Community',
      //           icon: Iconsax.people,
      //           voidCallback: () {
      //             _switchTap(3);
      //           }),
      //       DrawerItem(
      //           text: 'Notifications',
      //           icon: Iconsax.notification,
      //           voidCallback: () {
      //             _switchTap(4);
      //           }),
      //       DrawerItem(
      //           text: 'Settings',
      //           icon: Iconsax.setting_2,
      //           voidCallback: () {
      //             _switchTap(5);
      //           }),
      //     ]),
      //     DrawerItem(text: 'Share', icon: Icons.share, voidCallback: () {}),
      //     DrawerItem(text: 'LogOut', icon: Iconsax.logout, voidCallback: () {
      //       FirebaseAuth.instance.signOut();
      //     }),
      //   ],
      // ),
      bottomNavigationBar: BottomNavigationBar(
        // elevation: 0,
        onTap: (index) {
          _switchTap(index);
        },
        currentIndex: selectindex,
        backgroundColor:
            Theme.of(context).colorScheme.onBackground.withOpacity(0.3),
        unselectedItemColor: Theme.of(context).colorScheme.secondary,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        items: const [
          BottomNavigationBarItem(icon: Icon(Iconsax.home), label: 'Menu'),
          BottomNavigationBarItem(icon: Icon(Iconsax.message), label: 'Chats'),
          BottomNavigationBarItem(
              icon: Icon(Iconsax.notification), label: 'Notifications'),
          BottomNavigationBarItem(
              icon: Icon(Iconsax.setting_2), label: 'Setting')
        ],
      ),

      // body: ,
      body: IndexedStack(index: selectindex, children: pages),
    );
  }

  _switchTap(int index) {
    setState(() {
      selectindex = index;
    });
  }
}
