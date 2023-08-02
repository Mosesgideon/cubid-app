import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_media/features/authentication/presentation/widgets/custombutton_widgets.dart';
import 'package:social_media/features/home_screen/presentation/homeScreen.dart';

class ProfilePicAdd extends StatefulWidget {
  const ProfilePicAdd({Key? key}) : super(key: key);

  @override
  State<ProfilePicAdd> createState() => _ProfilePicAddState();
}

class _ProfilePicAddState extends State<ProfilePicAdd> {
  bool isloading = false;
  XFile? myfile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: SizedBox(),
        title: Text(
          "Add picture",
          style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Center(
                child: myfile != null
                    ? ClipOval(
                  child: Container(
                    height: 400,
                    width: 400,
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 2,
                            color: Theme.of(context).colorScheme.primary),
                        borderRadius: BorderRadius.circular(60),
                        image: DecorationImage(
                            image: FileImage(File(myfile!.path)),
                            fit: BoxFit.cover)),
                  ),
                )
                    : Container(
                  color: Colors.grey,
                  height: 500,
                  width: MediaQuery.of(context).size.width,
                  child: IconButton(
                      onPressed: () {
                        showModalBottomSheet(
                            backgroundColor: Colors.transparent,
                            context: context,
                            builder: (index) => Container(
                              padding: EdgeInsets.all(20),
                              height: 150,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20)),
                                color: Theme.of(context).cardColor,
                              ),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context);
                                        getImage(ImageSource.gallery);
                                        // ImagePicker picker=ImagePicker().pickImage(source: ImageSource.gallery)
                                      },
                                      child: Column(
                                        children: [
                                          Icon(
                                            Iconsax.gallery,
                                            size: 60,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onBackground,
                                          ),
                                          Text(
                                            "Gallery",
                                            style: TextStyle(
                                                color:
                                                Theme.of(context)
                                                    .colorScheme
                                                    .onBackground,
                                                fontSize: 20,
                                                fontWeight:
                                                FontWeight.w400),
                                          )
                                        ],
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context);
                                        getImage(ImageSource.camera);
                                      },
                                      child: Column(
                                        children: [
                                          Icon(
                                            Iconsax.camera,
                                            size: 60,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onBackground,
                                          ),
                                          Text(
                                            "Camera",
                                            style: TextStyle(
                                                color:
                                                Theme.of(context)
                                                    .colorScheme
                                                    .onBackground,
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
                            ));
                      },
                      icon: const Icon(
                        Iconsax.gallery_add,
                        size: 50,
                        color: Colors.white,
                      )),
                )),
            Spacer(),
            CustomButton(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: isloading
                    ? const SizedBox(
                    height: 25,
                    width: 25,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ))
                    : Text("Finish"),
                onPressed: () {
                  uploadselectedImage();
                })
          ],
        ),
      ),
    );
  }

  final _picker = ImagePicker();

  Future<File?> getImage(ImageSource source) async {
    final image = await _picker.pickImage(source: source);
    if (image != null) {
      File myfile = File(image.path);
    }
    setState(() {
      myfile = image;
    });
    return null;
  }

  void uploadselectedImage() async {
    setState(() {
      isloading = true;
    });
    final files = myfile;
    final data = SettableMetadata(contentType: "image/jpeg");
    final storageref = FirebaseStorage.instance.ref();

    Reference reference = storageref
        .child("pictures/${DateTime.now().microsecondsSinceEpoch}.jpg");

    final uploadTask = reference.putFile(File(files!.path), data);

    uploadTask.snapshotEvents.listen((event) async {
      switch (event.state) {
        case TaskState.error:
          setState(() {
            isloading = false;
          });
          print("faled");
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(TaskState.error.toString())));
          break;
        case TaskState.running:
          setState(() {
            isloading = true;
          });
          print("loading");
          break;
        case TaskState.success:
          reference.getDownloadURL().then((value) async {
            await storeDetails(value);
          });
          break;
      }
    });
  }

  Future storeDetails(String imageUrl) {
    DocumentReference users = FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid);
    return users.update({
      "image": imageUrl,
    }).whenComplete(() {
      setState(() {
        isloading = false;
      });
      print("success");
      Navigator.pushReplacement(context, CupertinoPageRoute(builder: (index)=>HomeScreen()));

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          duration: Duration(milliseconds: 2000), content: Text("success")));
    });
  }
}
