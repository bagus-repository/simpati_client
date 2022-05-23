import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simpati_client/cores/configs/configs.dart';
import 'package:simpati_client/cores/models/screen_argument_model.dart';
import 'package:simpati_client/ui/widgets/widgets.dart';
import 'package:url_launcher/url_launcher_string.dart';

class NewUpdatePage extends StatelessWidget {
  final ScreenArgument? argument = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConfigColor.backgroundColor,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Versi aplikasi kadaluarsa, silahkan melakukan update',
              style: TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            dividerHeading(),
            buttonSubmitDefault(
                onPressed: () async {
                  if (argument != null) {
                    if (await canLaunchUrlString(argument!.stringPayload!)) {
                      await launchUrlString(argument!.stringPayload!);
                    }
                  }
                },
                text: 'Update'),
          ],
        ),
      ),
    );
  }
}
