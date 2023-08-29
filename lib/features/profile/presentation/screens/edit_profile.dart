import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:social_media/features/authentication/presentation/widgets/custombutton_widgets.dart';
import 'package:social_media/features/authentication/presentation/widgets/textfield_widget.dart';
import 'package:social_media/features/profile/presentation/screens/profile_page.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final nameController = TextEditingController();
  final userController = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String name = "";
  String username = "";

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    User? user = _auth.currentUser;
    DocumentSnapshot userData =
        await _firestore.collection("users").doc(user!.uid).get();
    setState(() {
      name = userData.get("name");
      username = userData.get("username");
    });
  }

  bool isloading = false;

  Future<void> _updateProfile() async {
    User? user = _auth.currentUser;
    setState(() {
        isloading=true;
    });
    await _firestore.collection("users").doc(user!.uid).update({
      "name": name,
      "username": username,
    }).whenComplete(() {
      Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (index)=>const Profile()));
      setState(() {
        isloading=false;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Profile updated!")));
    });


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          "Edit profile",
          style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formkey,
          child: Expanded(
            child: Column(
              children: [
                const SizedBox(
                  height: 25,
                ),
                OutlinedFormField(
                    initialValue: name,
                    onChange: (value) {
                      setState(() {
                        name = value;
                      });
                    },
                    hint: 'name',
                    validator: (val) {
                      if (val!.isEmpty) {
                        return null;
                      }
                      return null;
                    },
                    // controller: nameController,
                    preffix: const Icon(
                      Iconsax.profile_add,
                    )),
                const SizedBox(
                  height: 10,
                ),
                OutlinedFormField(
                    // controller: userController,
                    hint: 'username',
                    initialValue: username,
                    onChange: (value) {
                      setState(() {
                        username = value;
                      });
                    },
                    validator: (val) {
                      if (val!.isEmpty) {
                        return null;
                      }
                      return null;
                    },
                    preffix: const Icon(
                      Iconsax.profile_add,
                    )),
                const SizedBox(
                  height: 10,
                ),

                const SizedBox(
                  height: 10,
                ),
                // const OutlinedFormField(
                //     hint: 'contact',
                //     preffix: Icon(
                //       Iconsax.call_add,
                //     )),
                Spacer(),
                CustomButton(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: isloading
                        ?  SizedBox(
                            height: 25,
                            width: 25,
                            child: CircularProgressIndicator(
                              color: Theme.of(context).colorScheme.onBackground,
                            ))
                        : Text("Update"),
                    onPressed: () {
                      _updateProfile();
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future updateProfile() async {
    if (_formkey.currentState!.validate()) {}
  }
}

// void updateProfile() {
// }z
