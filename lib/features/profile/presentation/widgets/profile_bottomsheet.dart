

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
class ProfileBottomSheet extends StatefulWidget {
  const ProfileBottomSheet({Key? key}) : super(key: key);

  @override
  State<ProfileBottomSheet> createState() => _ProfileBottomSheetState();
}

class _ProfileBottomSheetState extends State<ProfileBottomSheet> {
  XFile?myfile;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      height: 150,
      decoration:   BoxDecoration(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20)),
        color:Theme.of(context).cardColor,),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: (){
                getImage(ImageSource.gallery);
                // ImagePicker picker=ImagePicker().pickImage(source: ImageSource.gallery)
              },
              child: Column(
                children:  [
                  Icon(
                    Iconsax.gallery,
                    size: 60,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                  Text("Gallery",style: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground,
                      fontSize: 20,
                      fontWeight:
                      FontWeight.w400),)
                ],
              ),
            ),

            GestureDetector(
              onTap: (){
                getImage(ImageSource.camera);
              },
              child: Column(
                children:  [
                  Icon(
                    Iconsax.camera,
                    size: 60,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                  Text(
                    "Camera",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onBackground,
                        fontSize: 20,
                        fontWeight:
                        FontWeight.w400),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  final _picker=ImagePicker();

  Future<File?>getImage(ImageSource source)async{
    final image=await _picker.pickImage(source: source);
    if(image!=null){
      File myfile = File(image.path);
    }
    setState(() {
      myfile=image;
    });
    return null;

  }
}
