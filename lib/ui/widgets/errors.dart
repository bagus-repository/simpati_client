import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:simpati_client/cores/configs/colors_config.dart';
import 'package:simpati_client/cores/models/api_response_model.dart';
import 'package:simpati_client/ui/widgets/widgets.dart';

Container errorPageLoader(
    {required dynamic error,
    required BuildContext context,
    void Function()? callback,
    String? btnString,
    IconData? iconData}) {
  String title = '-';
  String desc = '-';
  iconData ??= FontAwesomeIcons.exclamationCircle;
  var sizeWidget = MediaQuery.of(context).size;

  btnString ??= 'Ulangi';
  if (error is APIErrorResponse) {
    title = 'ErrCode: ${error.code} ${error.title}';
    desc = error.msg;
  } else if (error is DioError) {
    title = 'Koneksi Error';
    desc = error.message;
  } else {
    title = 'Unknown Error';
    desc = error.toString();
  }

  return Container(
    alignment: Alignment.center,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: sizeWidget.width / 5,
          height: sizeWidget.height / 8,
          child: Center(
            child: FaIcon(
              iconData,
              size: 24.0,
              color: ConfigColor.primaryColor,
            ),
          ),
        ),
        dividerHeading(),
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22.0,
          ),
        ),
        dividerDefault(),
        Text(
          desc,
          style: const TextStyle(
            fontWeight: FontWeight.w300,
            fontSize: 18.0,
          ),
        ),
        if (callback != null) ...[
          dividerDefault(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: buttonSubmitDefault(onPressed: callback, text: btnString),
          )
        ],
      ],
    ),
  );
}
