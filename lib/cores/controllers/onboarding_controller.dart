import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:simpati_client/cores/controllers/controller.dart';
import 'package:simpati_client/cores/data/providers/pref_provider.dart';

class OnboardingController extends Controller {
  final pageDecoration = const PageDecoration(
    titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
    bodyTextStyle: TextStyle(fontSize: 19.0),
    descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
    pageColor: Colors.white,
    imagePadding: EdgeInsets.zero,
  );
  late List<PageViewModel> onboardingList = [
    PageViewModel(
      title: "Hi,",
      body: "Terima kasih telah menginstall aplikasi Simpati",
      image: _buildImageIntro('assets/images/onboarding1.png'),
      decoration: pageDecoration,
    ),
    PageViewModel(
      title: 'Tentang',
      body:
          'Aplikasi ini digunakan untuk pelayanan Pelabuhan Padang Tikar',
      image: _buildImageIntro('assets/images/onboarding2.png'),
      decoration: pageDecoration,
    ),
    PageViewModel(
      title: 'Fitur',
      body: 'Informasi terbaru, E-filling, dll',
      image: _buildImageIntro('assets/images/onboarding3.png'),
      decoration: pageDecoration,
    ),
  ];

  Widget _buildImageIntro(String assetName) {
    return Align(
      child: Image.asset(assetName),
      alignment: Alignment.bottomCenter,
    );
  }

  void doneOnboarding() async {
    await PrefProvider.secureStorage.write(key: PrefProvider.IS_DONE_INTRO_KEY, value: 'true');
    Get.back();
  }
}