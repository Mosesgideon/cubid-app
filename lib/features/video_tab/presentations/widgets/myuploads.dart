import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:social_media/app_constants/theme/app_colors.dart';

class Uploads extends StatefulWidget {
  const Uploads({Key? key}) : super(key: key);

  @override
  State<Uploads> createState() => _UploadsState();
}

class _UploadsState extends State<Uploads> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(

          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
            color: darkGrey,),
          height: 450,
          width: double.infinity,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              const Center(
                child: Icon(
                  Iconsax.play,
                  color: Colors.red,
                  size: 30,
                ),
              ),
              const Positioned(
                right: -2,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 70,horizontal: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Iconsax.like_tag,
                        color: Colors.red,
                        size: 30,
                      ),
                      SizedBox(height: 50,),

                      Icon(
                        Icons.favorite_outline,
                        color: Colors.red,
                        size: 30,
                      ),
                      SizedBox(height: 50,),
                      Icon(
                        Iconsax.message,
                        color: Colors.red,
                        size: 30,
                      ),

                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: -2,
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 25,
                      child: Icon(Iconsax.profile_add),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "poster",
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.onBackground,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                        Text("2mins ago",
                            style: TextStyle(
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                                fontSize: 10)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
