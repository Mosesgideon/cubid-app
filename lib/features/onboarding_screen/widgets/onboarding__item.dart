import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OnboardingItem extends StatefulWidget {
   OnboardingItem(
      {Key? key, required this.header, required this.img,})
      : super(key: key);
  final String header;
  final String img;
  // Color color;

  @override
  _OnboardingItemState createState() => _OnboardingItemState();
}

class _OnboardingItemState extends State<OnboardingItem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
               // DecorationImage(image: AssetImage(widget.img), fit: BoxFit.cover),
            ),
        child: Container(
          // decoration: const BoxDecoration(),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          // color: widget.color,
          height: MediaQuery.of(context).size.height * 0.75,
          width: MediaQuery.of(context).size.width,
          child: Column(

            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                  child: Image.asset(width: 150, height: 150, widget.img)),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: Text(widget.header,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    )),
              ),
              const SizedBox(
                height: 16,
              ),

            ],
          ),
        ),
      ),
    );
  }
}
