import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:simpati_client/cores/configs/colors_config.dart';
import 'package:simpati_client/ui/widgets/buttons.dart';
import 'package:simpati_client/ui/widgets/dividers.dart';

enum DialogStatus { success, error, info }
enum AlertStatus { success, error, info }

class AlertUtil {
  static showResponseDialog({
    required BuildContext context,
    String? title,
    String? content,
    required DialogStatus status,
    void Function(BuildContext context)? onOk,
    bool onlyOk = false,
  }) async {
    String icon;
    String statusText;
    Color color;
    switch (status) {
      case DialogStatus.success:
        icon = 'success';
        statusText = 'Berhasil';
        color = ConfigColor.successColor;
        break;
      case DialogStatus.error:
        icon = 'error';
        statusText = 'Gagal';
        color = ConfigColor.errorColor;
        break;
      default:
        icon = 'info';
        statusText = 'Info';
        color = ConfigColor.infoColor;
    }
    await showDialog(
        barrierDismissible: !onlyOk,
        context: context,
        builder: (dialogContext) => Dialog(
              backgroundColor: Colors.transparent,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(16.0),
                          topRight: Radius.circular(16.0),
                        ),
                      ),
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        children: [
                          Container(
                            width: 100.0,
                            height: 100.0,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/images/$icon.png'),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          Text(
                            title ?? statusText,
                            style: TextStyle(
                              color: ConfigColor.secondaryTextColor,
                              fontSize: 22.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            content ?? '',
                            textAlign: TextAlign.center,
                          ),
                          dividerDefault(),
                          buttonCompact(
                              onPressed: () =>
                                  onOk ?? Navigator.of(dialogContext).pop(),
                              text: 'OK',
                              buttonColor: color),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }

  static Future<bool> showConfirmDialog(
    BuildContext context, {
    String? title,
    String? msg,
    String? okText,
    String? cancelText,
  }) async {
    return await showDialog<bool>(
            context: context,
            barrierDismissible: true,
            builder: (dialogContext) {
              return AlertDialog(
                title: Text(title ?? 'Konfirmasi'),
                content: Text(msg ?? 'Apakah anda yakin ?'),
                actions: <Widget>[
                  buttonCompact(
                    buttonColor: Colors.transparent,
                    textColor: ConfigColor.primaryTextColor.withOpacity(0.7),
                    text: cancelText ?? 'Tidak',
                    onPressed: () {
                      Navigator.pop(dialogContext, false);
                    },
                  ),
                  buttonCompact(
                    text: okText ?? 'Ya',
                    onPressed: () {
                      Navigator.pop(dialogContext, true);
                    },
                  ),
                ],
              );
            }) ??
        false;
  }

  static void showSnackbar(String title, String msg, AlertStatus status,
      {Function()? buttonPressed,
      String? buttonText,
      bool persistent = false}) {
    Get.snackbar(
      title,
      msg,
      icon: const Center(
        child: FaIcon(
          FontAwesomeIcons.bell,
          size: 20.0,
          color: Colors.white,
        ),
      ),
      shouldIconPulse: false,
      backgroundColor: status == AlertStatus.error
          ? ConfigColor.errorColor
          : status == AlertStatus.info
              ? ConfigColor.infoColor
              : ConfigColor.successColor,
      colorText: ConfigColor.secondaryTextColor,
      barBlur: 8.0,
      borderRadius: 14.0,
      snackStyle: SnackStyle.FLOATING,
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
      dismissDirection: DismissDirection.horizontal,
      animationDuration: const Duration(milliseconds: 300),
      duration: Duration(seconds: persistent ? 30 : 5),
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
      mainButton: buttonPressed != null
          ? TextButton(
              onPressed: buttonPressed,
              child: Text(buttonText ?? '-',
                  style: TextStyle(
                    color: ConfigColor.secondaryTextColor,
                  )))
          : null,
    );
  }
}
