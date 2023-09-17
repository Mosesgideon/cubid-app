import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_media/features/menu_tab/presentations/screens/menu.dart';
import '../../../authentication/presentation/widgets/custombutton_widgets.dart';

class PostWidget extends StatefulWidget {
  const PostWidget({Key? key}) : super(key: key);

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  // final _controller = TextEditingController();
  bool isloading = false;
  XFile? myfile;
  late File _videoFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onBackground.withOpacity(0.6),
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Expanded(
          child: Column(
            children: [
              Center(
                  child: myfile != null
                      ? Column(
                        children: [
                          Container(
                              height: 550,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(0),
                                  image: DecorationImage(
                                      image: FileImage(File(myfile!.path)),
                                      fit: BoxFit.cover)),
                            ),
                       const SizedBox(height: 20,),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: CustomButton(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 15),
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
                                }),
                          )

                        ],
                      )
                      : Column(
                        children: [
                          Container(
                              color: Colors.white24,
                              height: 350,
                              width: MediaQuery.of(context).size.width,
                              child: Image.asset('assets/png/imgOnboard.png'),

                              ),

                          Container(
                            padding: const EdgeInsets.only(right: 10),
                            alignment: Alignment.bottomRight,
                            child: Column(
                              children: [
                                CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Theme.of(context)
                                      .colorScheme
                                      .onBackground
                                      .withOpacity(0.1),
                                  child:  InkWell(
                                    onTap: ()=> getImage(ImageSource.gallery),
                                    child: Icon(Iconsax.gallery,
                                        color: Theme.of(context).colorScheme.onBackground),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Theme.of(context)
                                      .colorScheme
                                      .onBackground
                                      .withOpacity(0.1),
                                  child:  InkWell(
                                    onTap: _pickVideo,
                                    child: Icon(Iconsax.video,
                                        color: Theme.of(context).colorScheme.onBackground),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Theme.of(context)
                                        .colorScheme
                                        .onBackground
                                        .withOpacity(0.1),
                                    child:  Icon(Iconsax.text,
                                        color: Theme.of(context).colorScheme.onBackground))
                              ],
                            ),
                          ),

                        ],
                      )),

            ],
          ),
        ),
      ),
    );
  }

  final _picker = ImagePicker();

  Future<File?> getImage(ImageSource source) async {
    final image = await _picker.pickImage(source: ImageSource.gallery);
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
          print("failed");
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

  Future<void> _pickVideo() async {
    final pickedFile =
    await ImagePicker().pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _videoFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _uploadVideo() async {
    if (_videoFile != null) {
      final storageReference =
      FirebaseStorage.instance.ref().child('videos/${DateTime.now()}.mp4');
      final uploadTask = storageReference.putFile(_videoFile!);
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
            storageReference.getDownloadURL().then((value) async {
              await postVideo(value);
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  duration: Duration(milliseconds: 1000),
                  content: Text("Successful")));
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (index) => UserMenu()));
            });
            break;
          case TaskState.paused:
          // TODO: Handle this case.
          case TaskState.canceled:
          // TODO: Handle this case.
        }
      });
    }
  }

  Future<void> postVideo(String vidUrl) async {
    CollectionReference abuse =
    FirebaseFirestore.instance.collection('posts');

    // Call the user's CollectionReference to add a new report
    return await abuse
        .add({
      'video': vidUrl,
    })
        .then((value) => print("report added"))
        .catchError((error) => print("Failed to add report: $error"));
  }
}
