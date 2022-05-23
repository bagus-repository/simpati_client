import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simpati_client/cores/configs/colors_config.dart';
import 'package:simpati_client/cores/controllers/splash_controller.dart';
import 'package:simpati_client/cores/data/constants.dart';
import 'package:simpati_client/ui/widgets/widgets.dart';

class SplashScreenPage extends StatelessWidget {
  SplashScreenPage({Key? key}) : super(key: key);
  final controller = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: ConfigColor.secondaryColor,
            ),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    ConstantData.LOGO_URL,
                    width: screenSize.width/2,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 28.0,
            child: pageLoader(),
          ),
        ],
      ),
    );
  }
}
