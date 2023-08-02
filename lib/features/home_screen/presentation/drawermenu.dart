import 'package:flutter/material.dart';
import 'package:social_media/features/home_screen/widgets/drawerprofile.dart';


class DrawerMenu extends StatefulWidget {
  const DrawerMenu({Key? key, required this.drawerItems}) : super(key: key);
  final List<Widget> drawerItems;

  @override
  State<DrawerMenu> createState() => _DrawerMenuState();
}



class _DrawerMenuState extends State<DrawerMenu> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: Theme
            .of(context)
            .scaffoldBackgroundColor
            .withOpacity(0.9),
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: [
            const SizedBox(
              height: 40,
            ),
            const SideDrawerMenuDisplay(),

            ...widget.drawerItems,
          ],
        ),
      ),
    );
  }





}

class DrawerItem extends StatelessWidget {
  const DrawerItem({Key? key,
    required this.text,
    required this.icon,
    required this.voidCallback})
      : super(key: key);
  final String text;
  final IconData icon;
  final VoidCallback voidCallback;

  @override
  Widget build(BuildContext context) {
    final color = Theme
        .of(context)
        .colorScheme
        .onBackground;
    return ListTile(
      leading: Icon(
        icon,
        color: color,
      ),
      title: Text(
        text,
        style: TextStyle(
            color: color,
            fontWeight: FontWeight.w500,
            fontSize: 15
        ),
      ),
      onTap: () {
        Navigator.pop(context);
        voidCallback();
      },
    );
  }
}

class GroupDrawerItem extends StatefulWidget {
  const GroupDrawerItem({Key? key,
    required this.tittle,
    required this.hasDivider,
    required this.children})
      : super(key: key);

  final String tittle;
  final bool hasDivider;
  final List<DrawerItem> children;

  @override
  State<GroupDrawerItem> createState() => _GroupDrawerItemState();
}

class _GroupDrawerItemState extends State<GroupDrawerItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 18,
        ),
        Text(
          widget.tittle,
          style: TextStyle(color: Theme
              .of(context)
              .colorScheme
              .onBackground),
        ),
        ...widget.children,
        const SizedBox(height: 20,),
        widget.hasDivider
            ? Divider(
            color: Theme
                .of(context)
                .colorScheme
                .onBackground
                .withOpacity(0.5)
        )
            : const SizedBox.shrink(),
      ],
    );
  }
}
