import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class PostView extends StatefulWidget {
  final String username;
  final String userImage;

  const PostView({Key? key, required this.username, required this.userImage})
      : super(key: key);

  @override
  State<PostView> createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Iconsax.arrow_left,
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
        title: Text(
          widget.username,
          style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            SizedBox(
              // padding: EdgeInsets.only(top: 30),
              width: MediaQuery.of(context).size.width,
              height: 500,
              child: Hero(
                  tag: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(widget.userImage),
                          fit: BoxFit.fill),
                    ),
                  )),
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
                child: TextFormField(
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground),
                  decoration: InputDecoration(
                      filled: true,
                      border: OutlineInputBorder(
                          gapPadding: 2,
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10)),
                      fillColor: Colors.grey.withOpacity(0.2),
                      hintText: 'comment',
                      iconColor: Colors.grey,
                      prefixIconColor: Colors.grey,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                      hintStyle:
                          TextStyle(color: Colors.grey.shade500, fontSize: 13)),
                )),
            Padding(
              padding: const EdgeInsets.only(left: 10,bottom: 10),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Theme.of(context).colorScheme.onBackground,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                    color:  Colors.grey.withOpacity(0.2)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Moses Gideon",
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.onBackground,
                              fontWeight: FontWeight.w500,
                              fontSize: 13),
                        ),
                        Text("ahswear bro,it has been terrible 😂",
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.onBackground,fontSize: 10)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10,bottom: 10),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Theme.of(context).colorScheme.onBackground,

                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                        color:  Colors.grey.withOpacity(0.2)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Moses Gideon",
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.onBackground,
                              fontWeight: FontWeight.w500,
                              fontSize: 13),
                        ),
                        Text("ahswear bro,it has been terrible 😂",
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.onBackground,fontSize: 10)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10,bottom: 10),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Theme.of(context).colorScheme.onBackground,

                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                        color:  Colors.grey.withOpacity(0.2)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Moses Gideon",
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.onBackground,
                              fontWeight: FontWeight.w500,
                              fontSize: 13),
                        ),
                        Text("ahswear bro,it has been terrible 😂",
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.onBackground,fontSize: 10)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10,bottom: 10),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Theme.of(context).colorScheme.onBackground,

                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                        color:  Colors.grey.withOpacity(0.2)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Moses Gideon",
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.onBackground,
                              fontWeight: FontWeight.w500,
                              fontSize: 13),
                        ),
                        Text("ahswear bro,it has been terrible 😂",
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.onBackground,fontSize: 10)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10,bottom: 10),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Theme.of(context).colorScheme.onBackground,
                    radius: 20,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                        color:  Colors.grey.withOpacity(0.2)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Moses Gideon",
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.onBackground,
                              fontWeight: FontWeight.w500,
                              fontSize: 13),
                        ),
                        Text("ahswear bro,it has been terrible 😂",
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.onBackground,fontSize: 10)),
                      ],
                    ),
                  ),
                ],
              ),
            ),



          ],
        ),
      ),
    );
  }
}
