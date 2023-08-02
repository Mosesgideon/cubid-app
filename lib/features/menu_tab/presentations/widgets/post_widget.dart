import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_media/features/menu_tab/presentations/widgets/post_widgets.dart';

class PostItems extends StatefulWidget {

  const PostItems({Key? key,}) : super(key: key);

  @override
  State<PostItems> createState() => _PostItemsState();
}

class _PostItemsState extends State<PostItems> {
  final list = ['Text', 'Photo', 'Video', ''];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.builder(
            shrinkWrap: true,
            itemCount: list.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                crossAxisCount: 2),
            itemBuilder: (contex, index) =>
                GestureDetector(
                  onTap: () {
                    if (list[index]== "Text") {
                      // Navigator.of(context).push(CupertinoPageRoute(builder: (index)=>))
                    } else if (list[index] == "Photo") {
                      Navigator.pop(context);
                      Navigator.of(context).push(
                          CupertinoPageRoute(builder: (index) =>  PostWidget()));
                    }
                    else if (list[index]=='Video') {

                    }
                  },
                  child: Card(
                    color: Theme
                        .of(context)
                        .colorScheme
                        .onPrimary,
                    child: Center(
                      child: Text(
                        list[index],
                        style: TextStyle(
                            color: Theme
                                .of(context)
                                .colorScheme
                                .primary,
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                )),
      ),
    );
  }
}
