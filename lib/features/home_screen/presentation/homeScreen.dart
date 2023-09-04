import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:social_media/features/chat_page/presentation/screens/chat_list/chat_page.dart';
import 'package:social_media/features/menu_tab/presentations/screens/menu.dart';
import 'package:social_media/features/notifications/presentations/screens/notifications.dart';
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
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      bottomNavigationBar: BottomNavigationBar(
        // elevation: 0,
        onTap: (index) {
          _switchTap(index);
        },
        currentIndex: selectindex,
        backgroundColor: Theme.of(context).colorScheme.onBackground.withOpacity(0.3),
        unselectedItemColor: Theme.of(context).colorScheme.secondary,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        elevation: 0,

        items:  [
          const BottomNavigationBarItem(icon: Icon(Iconsax.home), label: 'Menu'),
          const  BottomNavigationBarItem(icon: Icon(Iconsax.message), label: 'Chats'),
          BottomNavigationBarItem(
              icon: StreamBuilder<QuerySnapshot<dynamic>>(
                  stream: FirebaseFirestore.instance
                      .collection("notifications")
                      .snapshots(),
                builder: (context, snapshot) {
                  return Stack(
                    clipBehavior: Clip.none,
                    children: [
                      const Icon(Iconsax.notification),

                      Positioned(
                        top: -5,
                        right: -2,

                        child: CircleAvatar(
                          backgroundColor: Colors.red,
                          radius: 6,
                          child: Text(snapshot.data!.size.toString(),style: const TextStyle(fontSize: 8),),
                        ),
                      ),
                    ],
                  );
                }
              ), label: 'Notifications'),
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
