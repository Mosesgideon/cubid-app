import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class Styles {
  static TextStyle h1() {
    return const TextStyle(
        fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white);
  }

  static friendsBox() {
    return const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15), topRight: Radius.circular(15)));
  }

  static searchTextFieldStyle() {
    return InputDecoration(
      border: InputBorder.none,
      // fillColor: Colors.black,
      hintText: 'search',
      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      suffixIcon: IconButton(
          onPressed: () {}, icon: const Icon(Iconsax.search_normal_1)),
    );
  }

  static searchField({Function(String)? onChange}) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: TextField(
        onChanged: onChange,
        decoration: Styles.searchTextFieldStyle(),
      ),
      decoration: Styles.messageFieldCardStyle(),
    );
  }

  static Widget circleProfile(
      {onTap,
      required Widget? widget,
      required String text,
      required BuildContext context}) {
    bool isonline = false;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(clipBehavior: Clip.hardEdge,
                children: [
              Positioned(
               bottom: -4,
                  left: 45,
                  child: Text(
                ".",
                style: TextStyle(
                    color: isonline ? Colors.green : Colors.green,
                    fontWeight: FontWeight.w600,
                    fontSize: 50),
              )),
              Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Theme.of(context).colorScheme.primary,width: 2)),
                child: widget,
              ),
            ]),
            SizedBox(
                width: 50,
                child: Center(
                    child: Text(
                  text,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      height: 1.5,
                      fontSize: 12,
                      color: Theme.of(context).colorScheme.onBackground),
                  overflow: TextOverflow.ellipsis,
                )))
          ],
        ),
      ),
    );
  }

  static messageFieldCardStyle() {
    return BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.indigo),
        borderRadius: BorderRadius.circular(10));
  }
}
