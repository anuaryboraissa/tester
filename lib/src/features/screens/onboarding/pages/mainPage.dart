import 'package:erisiti/src/constants/styles/style.dart';

import 'package:erisiti/src/features/screens/onboarding/pages/features/helper.dart';
import 'package:flutter/material.dart';

import '../../login/Login.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  PageController controller = PageController();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: PageView(
              allowImplicitScrolling: true,
              scrollDirection: Axis.horizontal,
              controller: controller,
              onPageChanged: (pageNumber) {
                setState(() {
                  currentIndex = pageNumber;
                });
              },
              children: OnboardHelper.list,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 25, left: 25, right: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: currentIndex == 0
                          ? ApplicationStyles.realAppColor
                          : ApplicationStyles.inactiveOnboardingPageColor,
                      radius: 7,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    CircleAvatar(
                      backgroundColor: currentIndex == 1
                          ? ApplicationStyles.realAppColor
                          : ApplicationStyles.inactiveOnboardingPageColor,
                      radius: 7,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    CircleAvatar(
                      backgroundColor: currentIndex == 2
                          ? ApplicationStyles.realAppColor
                          : ApplicationStyles.inactiveOnboardingPageColor,
                      radius: 7,
                    ),
                  ],
                ),
                Row(
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            backgroundColor: ApplicationStyles.realAppColor),
                        onPressed: () {
                          changePage();
                          if (currentIndex == 2) {
                            Navigator.of(context)
                                .popUntil((route) => route.isFirst);
                            Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(
                              builder: (context) => const Login(),
                            ));
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              currentIndex < 2 ? "Next" : "Finish",
                              style:
                                  ApplicationStyles.getStyle(false, 20, null),
                            ),
                            if (currentIndex < 2)
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.arrow_forward,
                                  size: 23,
                                  weight: 20,
                                ),
                              )
                          ],
                        ))
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  changePage() {
    controller.nextPage(
        duration: const Duration(milliseconds: 800), curve: Curves.linear);
  }
}
