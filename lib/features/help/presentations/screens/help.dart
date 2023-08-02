import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:social_media/features/help/presentations/screens/feedback.dart';
import 'package:social_media/features/settings/sreens/widgets/report_issue.dart';
import 'package:social_media/features/settings/sreens/widgets/settins_items.dart';

class UserHelp extends StatefulWidget {
  const UserHelp({
    Key? key,
  }) : super(key: key);

  @override
  State<UserHelp> createState() => _UserHelpState();
}

class _UserHelpState extends State<UserHelp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "Customer Support and help",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(
                  "Issues/Feedback",
                  style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                      fontSize: 14),
                ),
              ),
              SettingsItems(
                icon: Icons.info_outline,
                text: 'Report an issue',
                voidCallback: () {
                  Navigator.of(context).push(CupertinoPageRoute(
                      builder: (index) => const ReportIssue()));
                },
                subtitle: 'Any problem ?',
              ),
              SettingsItems(
                voidCallback: () {
                  Navigator.of(context).push(CupertinoPageRoute(
                      builder: (BuildContext context) => FeedBack()));
                },
                text: "Send Feedback",
                icon: Icons.tag_faces_outlined,
                subtitle: 'Send us a message',
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                child: Divider(
                  color: Colors.grey,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Text(
                  "Customer Support Contacts",
                  style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                      fontSize: 14),
                ),
              ),
              SettingsItems(
                voidCallback: () {},
                text: "02-9802738",
                icon: Iconsax.call,
                subtitle: 'phone call',
              ),
              SettingsItems(
                voidCallback: () {},
                text: "chattApp@email.com",
                icon: Iconsax.message,
                subtitle: 'send us an email',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
