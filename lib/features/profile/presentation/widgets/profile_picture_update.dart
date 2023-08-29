import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_media/features/authentication/presentation/widgets/custombutton_widgets.dart';

class ProfilePic extends StatefulWidget {
  const ProfilePic({Key? key}) : super(key: key);

  @override
  State<ProfilePic> createState() => _ProfilePicState();
}

class _ProfilePicState extends State<ProfilePic> {
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
          style: TextStyle(color: Theme
              .of(context)
              .colorScheme
              .onBackground),
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
                            color: Theme
                                .of(context)
                                .colorScheme
                                .primary),
                        borderRadius: BorderRadius.circular(60),
                        image: DecorationImage(
                            image: FileImage(File(myfile!.path)),
                            fit: BoxFit.cover)),
                  ),
                )
                    : Container(
                  color: Colors.grey,
                  height: 500,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  child: IconButton(
                      onPressed: () {
                        showModalBottomSheet(
                            backgroundColor: Colors.transparent,
                            context: context,
                            builder: (index) =>
                                Container(
                                  padding: const EdgeInsets.all(20),
                                  height: 150,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20)),
                                    color: Theme
                                        .of(context)
                                        .cardColor,
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
                                                color: Theme
                                                    .of(context)
                                                    .colorScheme
                                                    .onBackground,
                                              ),
                                              Text(
                                                "Gallery",
                                                style: TextStyle(
                                                    color:
                                                    Theme
                                                        .of(context)
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
                                                color: Theme
                                                    .of(context)
                                                    .colorScheme
                                                    .onBackground,
                                              ),
                                              Text(
                                                "Camera",
                                                style: TextStyle(
                                                    color:
                                                    Theme
                                                        .of(context)
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
        .child("pictures/${DateTime
        .now()
        .microsecondsSinceEpoch}.jpg");

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
        case TaskState.paused:
          break;
        case TaskState.canceled:
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
      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          duration: Duration(milliseconds: 2000), content: Text("success")));
    });
  }
}





























// import 'package:crypto_wallet/net/flutterfire.dart';
// import 'package:flutter/material.dart';
//
// import 'home_view.dart';
//
// class Authentication extends StatefulWidget {
//   Authentication({Key key}) : super(key: key);
//
//   @override
//   _AuthenticationState createState() => _AuthenticationState();
// }
//
// class _AuthenticationState extends State<Authentication> {
//   TextEditingController _emailField = TextEditingController();
//   TextEditingController _passwordField = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         width: MediaQuery.of(context).size.width,
//         height: MediaQuery.of(context).size.height,
//         decoration: BoxDecoration(
//           color: Colors.blueAccent,
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               width: MediaQuery.of(context).size.width / 1.3,
//               child: TextFormField(
//                 style: TextStyle(color: Colors.white),
//                 controller: _emailField,
//                 decoration: InputDecoration(
//                   hintText: "something@email.com",
//                   hintStyle: TextStyle(
//                     color: Colors.white,
//                   ),
//                   labelText: "Email",
//                   labelStyle: TextStyle(
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: MediaQuery.of(context).size.height / 35),
//             Container(
//               width: MediaQuery.of(context).size.width / 1.3,
//               child: TextFormField(
//                 style: TextStyle(color: Colors.white),
//                 controller: _passwordField,
//                 obscureText: true,
//                 decoration: InputDecoration(
//                   hintText: "password",
//                   hintStyle: TextStyle(
//                     color: Colors.white,
//                   ),
//                   labelText: "Password",
//                   labelStyle: TextStyle(
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: MediaQuery.of(context).size.height / 35),
//             Container(
//               width: MediaQuery.of(context).size.width / 1.4,
//               height: 45,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(15.0),
//                 color: Colors.white,
//               ),
//               child: MaterialButton(
//                 onPressed: () async {
//                   bool shouldNavigate =
//                   await register(_emailField.text, _passwordField.text);
//                   if (shouldNavigate) {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => HomeView(),
//                       ),
//                     );
//                   }
//                 },
//                 child: Text("Register"),
//               ),
//             ),
//             SizedBox(height: MediaQuery.of(context).size.height / 35),
//             Container(
//               width: MediaQuery.of(context).size.width / 1.4,
//               height: 45,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(15.0),
//                 color: Colors.white,
//               ),
//               child: MaterialButton(
//                   onPressed: () async {
//                     bool shouldNavigate =
//                     await signIn(_emailField.text, _passwordField.text);
//                     if (shouldNavigate) {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => HomeView(),
//                         ),
//                       );
//                     }
//                   },
//                   child: Text("Login")),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }



