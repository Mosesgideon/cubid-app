import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:social_media/features/menu_tab/presentations/widgets/post_widget.dart';
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
          child: Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(30),
            ),
            child: IconButton(
              onPressed: () {
                Navigator.of(context)
                    .push(CupertinoPageRoute(builder: (index) => const Updates()));
              },
              icon: const Icon(
                Iconsax.add,
                color: Colors.white,
                size: 40,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class Updates extends StatefulWidget {
  const Updates({Key? key}) : super(key: key);

  @override
  State<Updates> createState() => _UpdatesState();
}

class _UpdatesState extends State<Updates> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Form(
                child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(children: [
                      // _appBarPost(),
                      const SizedBox(height: 10.0),
                      Expanded(
                        flex: 2,
                        child: SizedBox(
                          child: ListView(
                            children: [
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                        alignment: Alignment.topLeft,
                                        height: 120,
                                        width:
                                        MediaQuery.of(context).size.width *
                                            .125,
                                        child: const CircleAvatar(
                                          radius: 30,
                                          backgroundImage: NetworkImage(''),
                                        ),
                                      )
                                    ],
                                  ),
                                  Container(
                                    height: 100,
                                    width:
                                    MediaQuery.of(context).size.width * .78,
                                    color: Colors.white,
                                    child: TextFormField(
                                      maxLines: 4,
                                      decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.only(
                                            left: 10.0, top: 10.0),
                                        border: InputBorder.none,
                                        hintText: 'Agrega un comentario',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10.0),
                              Padding(
                                  padding: const EdgeInsets.only(
                                      left: 65.0, right: 10.0),
                                  child: ListView.builder(
                                    physics:
                                    const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemBuilder: (_, i) => Stack(
                                      children: [
                                        Container(
                                          height: 150,
                                          width: MediaQuery.of(context)
                                              .size
                                              .width *
                                              .95,
                                          margin: const EdgeInsets.only(
                                              bottom: 10.0),
                                          decoration: BoxDecoration(
                                              color: Colors.blue,
                                              borderRadius:
                                              BorderRadius.circular(10.0),
                                              image: const DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: AssetImage(''))),
                                        ),
                                        const Positioned(
                                          top: 5,
                                          right: 5,
                                          child: InkWell(
                                            child: CircleAvatar(
                                              backgroundColor: Colors.black38,
                                              child: Icon(Icons.close_rounded,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 5.0),
                      const SizedBox(height: 5.0),
                      const Divider(),
                      const InkWell(
                          child: Padding(
                              padding:
                              EdgeInsets.symmetric(vertical: 5.0),
                              child: Row(children: [
                                SizedBox(width: 5.0),
                              ]))),
                      Divider(),
                      const SizedBox(height: 5.0),
                    ])))));
  }
}
