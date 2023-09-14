import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Iconsax.arrow_left,
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
        title: Text(
          "About",
          style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Version.....(beta version)",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.onBackground),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "Copyright(C)Interactive 2023.All rights reserved",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Terms And Conditions",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.onBackground),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "By using view chat, you agree to Cubid app terms and privacy",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Developer's email",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.onBackground),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "Mosesgideon072@gmail.com",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.onBackground),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Support",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.onBackground),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "Please leave question,bugs reports or comments on the forum,Alternatively you can reach us @programmersCity or 07042973460.",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
