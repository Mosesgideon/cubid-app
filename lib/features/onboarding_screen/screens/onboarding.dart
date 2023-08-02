import 'package:flutter/cupertino.dart';
import 'package:iconsax/iconsax.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:social_media/app_constants/strings/appStrings.dart';
import 'package:social_media/app_constants/theme/app_colors.dart';
import 'package:social_media/features/authentication/presentation/screens/signup_screen.dart';
import 'package:social_media/features/authentication/presentation/widgets/custombutton_widgets.dart';
import 'package:social_media/features/onboarding_screen/widgets/onboarding__item.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  PageController _controller = PageController();

  bool lastpagechange = false;
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (value) {
              setState(() {
                lastpagechange = (value == 2);
                currentIndex = value;
              });
            },
            children: [
              OnboardingItem(
                header: lorem,
                img: 'assets/png/imgOnboard.png',
              ),
              OnboardingItem(
                header: onboardingHeader,
                img: 'assets/png/Logo.png',
              ),
              OnboardingItem(
                header: lastOnbaording,
                img: 'assets/png/Logo.png',
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SmoothPageIndicator(
                  effect: const ExpandingDotsEffect(
                      spacing: 8.0,
                      dotWidth: 6.0,
                      dotHeight: 6.0,
                      strokeWidth: 1.5,
                      dotColor: lightpurple,
                      activeDotColor: Colors.grey),
                  controller: _controller,
                  count: 3,
                ),
                const SizedBox(
                  height: 20,
                ),
                lastpagechange
                    ? CustomButton(
                        // bgColor: Theme.of(context).colorScheme.primary,
                        isExpanded: false,
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                              CupertinoPageRoute(builder: (index) => SignUp()));

                          // showModalBottomSheet(
                          //   backgroundColor: Colors.transparent,
                          //   context: context,
                          //   builder: (index) => Container(
                          //     padding: const EdgeInsets.all(18),
                          //     height: 300,
                          //     decoration: const BoxDecoration(
                          //         color: cardlightcolor,
                          //         borderRadius: BorderRadius.only(
                          //             topRight: Radius.circular(20),
                          //             topLeft: Radius.circular(20))),
                          //     child: Column(
                          //       // mainAxisAlignment: MainAxisAlignment.center,
                          //       // crossAxisAlignment: CrossAxisAlignment.center,
                          //       children: [
                          //         Container(
                          //           width: 50,
                          //           height: 6,
                          //           decoration: BoxDecoration(
                          //               color: Theme.of(context)
                          //                   .colorScheme
                          //                   .onBackground,
                          //               borderRadius: BorderRadius.circular(5)),
                          //         ),
                          //         const SizedBox(
                          //           height: 15,
                          //         ),
                          //         CustomButton(
                          //             child: Text(
                          //               "Login to continue",
                          //               style: TextStyle(
                          //                   color: Theme.of(context)
                          //                       .colorScheme
                          //                       .onBackground),
                          //             ),
                          //             onPressed: () {}),
                          //         const SizedBox(
                          //           height: 20,
                          //         ),
                          //         CustomOutlinedButton(
                          //           onPressed: () {},
                          //           child: Text(
                          //             "SignUp",
                          //             style: TextStyle(
                          //               color: Theme.of(context)
                          //                   .colorScheme
                          //                   .onBackground,
                          //             ),
                          //           ),
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          // );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            children: [
                              Text(
                                "Start Messaging",
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimary),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              const Icon(Iconsax.arrow_right_14,
                                  size: 20, color: Colors.white)
                            ],
                          ),
                        ),
                      )
                    : CustomButton(
                        isExpanded: false,
                        bgColor: Theme.of(context).colorScheme.primary,
                        onPressed: () {
                          _controller.jumpToPage(currentIndex + 1);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 55),
                          child: Center(
                            child: Row(
                              children: [
                                Text(
                                  "Next",
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                const Icon(Iconsax.arrow_right_14,
                                    size: 20, color: Colors.white)
                              ],
                            ),
                          ),
                        ),
                      ),
                const SizedBox(
                  height: 50,
                )
              ],
            ),
          )
        ],
      )),
    );
  }
}
