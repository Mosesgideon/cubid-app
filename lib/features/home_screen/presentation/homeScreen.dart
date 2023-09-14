import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:social_media/features/chat_page/presentation/screens/chat_list/chat_page.dart';
import 'package:social_media/features/menu_tab/presentations/screens/menu.dart';
import 'package:social_media/features/notifications/presentations/screens/notifications.dart';
import 'package:social_media/features/settings/sreens/presentations/settings_screen.dart';
import 'package:social_media/features/video_tab/presentations/screens/videos.dart';

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
   const Videos(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          _switchTap(index);
        },
        currentIndex: selectindex,
        unselectedItemColor: Theme.of(context).colorScheme.secondary,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        elevation: 0,
        backgroundColor: Colors.grey,

        items:  const [
          BottomNavigationBarItem(icon: Icon(Iconsax.home), label: 'Menu'),
            BottomNavigationBarItem(icon: Stack(clipBehavior: Clip.none,
                children: [
                  Icon(Iconsax.message, size: 25),
                  Positioned(
                      bottom: 17,
                      left: 18,
                      child: CircleAvatar(
                        radius: 5,
                        backgroundColor: Colors.red,
                      )),
                ]),
           label: 'Chats'),
          BottomNavigationBarItem(
              icon: Icon(Iconsax.video), label: 'Videos'),
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
