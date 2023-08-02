import 'package:flutter/material.dart';
import 'package:social_media/features/onboarding_screen/screens/onboarding.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key, }) : super(key: key);



  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    var d = const Duration(seconds: 5);
    Future.delayed(d).then((value) => {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const IntroScreen()))
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
            height: 100,
            width: 100,
            "assets/png/Logo.png")
      ),
    );
  }
}