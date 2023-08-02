import 'package:flutter/material.dart';

class SettingsItems extends StatefulWidget {
  IconData icon;
  VoidCallback voidCallback;
  Widget? widget;
  final String text,subtitle;


  SettingsItems(
      {Key? key,
        required this.voidCallback,
        this.widget,
        required this.text,
        required this.icon, required this.subtitle,})
      : super(key: key);

  @override
  State<SettingsItems> createState() => _SettingsItemsState();
}

class _SettingsItemsState extends State<SettingsItems> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.voidCallback,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
        child: Row(
          children: [
            Icon(
              widget.icon,
              size: 25,
              color:Theme.of(context).colorScheme.onBackground,
            ),
            const SizedBox(width: 10,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.text,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color:Theme.of(context).colorScheme.onBackground,
                  ),
                ),
                Text(
                  widget.subtitle,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color:Colors.grey,
                  ),
                ),
              ],
            ),
            const Spacer(),
            widget.widget??  Icon(Icons.arrow_forward_ios,
              size: 15,
              color:Theme.of(context).colorScheme.onBackground,
            )
          ],
        ),
      ),
    );
  }
}
