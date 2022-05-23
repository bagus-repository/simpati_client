import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:simpati_client/cores/configs/configs.dart';
import 'package:simpati_client/cores/controllers/onboarding_controller.dart';

class OnboardingPage extends StatelessWidget {
  final controller = Get.put(OnboardingController());

  OnboardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: controller.onboardingList,
      onDone: () => controller.doneOnboarding(),
      done: _buttonOnboarding(title: 'Mulai'),
      showSkipButton: true,
      showNextButton: true,
      skip: const Text(
        'Lewati',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      next: _buttonOnboarding(title: 'Lanjut'),
      dotsDecorator: DotsDecorator(
        size: const Size.square(10.0),
        activeSize: const Size(20.0, 10.0),
        activeColor: ConfigColor.secondaryColor,
        color: Colors.black26,
        spacing: const EdgeInsets.symmetric(horizontal: 3.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
      ),
      skipFlex: 0,
      nextFlex: 0,
    );
  }

  Container _buttonOnboarding({required String title}) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(30.0)),
          gradient: LinearGradient(colors: <Color>[
            ConfigColor.primaryColor,
            ConfigColor.backgroundColor,
          ]),
        ),
        child: Text(
          title,
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      );
}
