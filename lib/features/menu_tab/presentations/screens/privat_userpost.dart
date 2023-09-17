import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:social_media/features/menu_tab/presentations/widgets/post_widgets.dart';

class UserPost extends StatefulWidget {
  const UserPost({Key? key}) : super(key: key);

  @override
  State<UserPost> createState() => _UserPostState();
}

class _UserPostState extends State<UserPost> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
                CupertinoPageRoute(builder: (index) => const PostWidget()));
          },
          child: Column(
            children: [
              Container(
                height: 100,
                width: 70,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Iconsax.add,color: Colors.white,size: 25,)
              ),
               Text("Post",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color: Theme.of(context).colorScheme.onBackground),),
            ],
          ),
        ),
      ],
    );
  }
}
