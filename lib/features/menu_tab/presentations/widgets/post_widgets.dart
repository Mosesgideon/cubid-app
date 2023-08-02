import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_media/features/chats_tab/presentations/models/user_model.dart';
import '../../../authentication/presentation/widgets/custombutton_widgets.dart';

class PostWidget extends StatefulWidget {
  const PostWidget({Key? key}) : super(key: key);

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  final _controller = TextEditingController();
  bool isloading = false;
  XFile? myfile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Expanded(
          child: Column(
            children: [
              Center(
                  child: myfile != null
                      ? Container(
                          height: 450,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(0),
                              image: DecorationImage(
                                  image: FileImage(File(myfile!.path)),
                                  fit: BoxFit.cover)),
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
                                            borderRadius:
                                                const BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(20),
                                                    topRight:
                                                        Radius.circular(20)),
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
                                                    getImage(
                                                        ImageSource.gallery);
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
                                                            color: Theme.of(
                                                                    context)
                                                                .colorScheme
                                                                .onBackground,
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                    getImage(
                                                        ImageSource.camera);
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
                                                            color: Theme.of(
                                                                    context)
                                                                .colorScheme
                                                                .onBackground,
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
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
              const SizedBox(
                height: 20,
              ),
              Spacer(),
              CustomButton(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  child: isloading
                      ? const SizedBox(
                          height: 25,
                          width: 25,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ))
                      : const Text("Upload"),
                  onPressed: () {
                    uploadselectedImage();
                  })
            ],
          ),
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
            await storeDetails(value, FirebaseAuth.instance.currentUser!.uid);
          });
          break;
      }
    });
  }

  Future storeDetails(String imageUrl, String user) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    CollectionReference posts = FirebaseFirestore.instance.collection("posts");
    DocumentSnapshot<Map<String, dynamic>> users =
        await FirebaseFirestore.instance.collection("users").doc(uid).get();

    return posts.add({
      "images": imageUrl,
      "posterId": uid,
      "posterName": users.get('name'),
      "userImage": users.get('image'),
      "time": DateTime.now().millisecondsSinceEpoch,
    }).whenComplete(() {
      setState(() {
        isloading = false;
      });
      print("success");
      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          duration: Duration(milliseconds: 2000), content: Text("success")));
    });
  }

  Future posts(String imageUrl) async {
    DocumentReference reference =
        await FirebaseFirestore.instance.collection("userposts").doc();
    return reference.set({
      "images": imageUrl,
    });
  }
}
