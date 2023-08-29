import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class MenuBottomItem extends StatefulWidget {
  // final QueryDocumentSnapshot snapshot;
  const MenuBottomItem({
    Key? key,
    // required this.snapshot
  }) : super(key: key);

  @override
  State<MenuBottomItem> createState() => _MenuBottomItemState();
}

class _MenuBottomItemState extends State<MenuBottomItem> {
  bool islike = false;
  bool isLoading = false;

  @override
  void initState() {
    // super.initState();
    islike = islike;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      height: 45,
      width: MediaQuery.of(context).size.width * .9,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50.0),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            color: Colors.white.withOpacity(0.2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    Row(
                      children: [
                        InkWell(
                          onTap: () {},
                          child: const Icon(Iconsax.like_1,
                              ),
                        ),
                        const SizedBox(width: 8.0),
                        InkWell(onTap: () {}, child: Text('30'))
                      ],
                    ),
                    // const SizedBox(width: 20.0),
                    // TextButton(
                    //   onPressed: () {},
                    //   child: Row(
                    //     children: [
                    //       SvgPicture.asset('assets/svg/message-icon.svg'),
                    //       const SizedBox(width: 5.0),
                    //       Text('30')
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.favorite,
                        size: 24)),

                IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.share,
                        size: 24)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
