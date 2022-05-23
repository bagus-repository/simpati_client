import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simpati_client/cores/configs/configs.dart';
import 'package:simpati_client/cores/controllers/auth_controller.dart';
import 'package:simpati_client/cores/data/constants.dart';
import 'package:simpati_client/cores/routes/routes.dart';
import 'package:simpati_client/ui/widgets/widgets.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);
  final ctrl = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: screenSize.height / 5,
              ),
              Image.asset(ConstantData.LOGO_URL),
              dividerHeading(),
              const Text('Halaman Login', style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),),
              dividerHeading(),
              defaultTxtField(
                controller: ctrl.txtEmailCtrl,
                label: 'Alamat Email *',
                maxlines: 1,
              ),
              dividerDefault(),
              defaultTxtField(
                controller: ctrl.txtPasswordCtrl,
                label: 'Password *',
                isSecret: true,
                maxlines: 1,
              ),
              dividerHeading(),
              Obx(() => buttonSubmitDefault(
                  onPressed: () => ctrl.doLogin(),
                  text: 'Masuk',
                  isSubmitting: ctrl.isPageSubmitting.value
                ),
              ),
              dividerHeading(),
              RichText(
                text: TextSpan(
                  text: 'Belum punya akun ? ',
                  children: [
                    TextSpan(
                      text: 'Daftar sekarang.',
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => Get.offNamed(Routes.REGISTER_PAGE),
                    ),
                  ],
                  style: TextStyle(color: ConfigColor.primaryColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
