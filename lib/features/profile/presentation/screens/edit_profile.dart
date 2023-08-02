import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:social_media/features/authentication/presentation/widgets/custombutton_widgets.dart';
import 'package:social_media/features/authentication/presentation/widgets/textfield_widget.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final nameController = TextEditingController();
  final userController = TextEditingController();
  final _formkey = GlobalKey<FormState>();


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
          child: Column(
            children: [

              const SizedBox(
                height: 25,
              ),
              OutlinedFormField(
                  hint: 'name',
                  validator: (val) {
                    if (val!.isEmpty) {
                      return null;
                    }
                    return null;
                  },
                  controller: nameController,
                  preffix: const Icon(
                    Iconsax.profile_add,
                  )),
              const SizedBox(
                height: 10,
              ),
              OutlinedFormField(
                  controller: userController,
                  hint: 'username',
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
              // const OutlinedFormField(
              //     hint: 'email',
              //     preffix: Icon(
              //       Iconsax.message,
              //     )),
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
                  child: Text("Update"),
                  onPressed: () {
                    updateProfile();
                  })
            ],
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
