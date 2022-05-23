import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:simpati_client/cores/configs/colors_config.dart';

Widget btnOnboarding({required String title}) => Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(30.0)),
        gradient: LinearGradient(colors: <Color>[
          ConfigColor.primaryColor,
          ConfigColor.primaryColorVariant,
        ]),
      ),
      child: Text(
        title,
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );

Widget buttonSubmitDefault({
  IconData? iconData,
  required void Function() onPressed,
  required String text,
  bool isSubmitting = false,
}) =>
    Material(
      color: Colors.transparent,
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
              colors: isSubmitting
                  ? <Color>[
                      Colors.grey.shade700,
                      Colors.grey.shade700,
                    ]
                  : <Color>[
                      ConfigColor.primaryColor,
                      ConfigColor.primaryColor,
                    ]),
        ),
        child: InkWell(
          splashFactory: InkRipple.splashFactory,
          splashColor: ConfigColor.primaryColor.withOpacity(0.4),
          onTap: isSubmitting ? null : onPressed,
          borderRadius: BorderRadius.circular(15.0),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
            child: isSubmitting
                ? const SpinKitCircle(
                    color: Colors.white,
                    size: 20.0,
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      iconData != null
                          ? Icon(
                              iconData,
                              color: Colors.white,
                              size: 20.0,
                            )
                          : Container(),
                      iconData != null
                          ? const SizedBox(
                              width: 10.0,
                            )
                          : const SizedBox(),
                      Text(
                        text,
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
          ),
        ),
      ),
    );

Widget buttonCompact(
    {IconData? iconData,
    required void Function() onPressed,
    required String text,
    bool isSubmitting = false,
    Color? buttonColor,
    Color? textColor,
    double? elevation,
    double? size}) {
  if (iconData != null && !isSubmitting) {
    return RaisedButton.icon(
      onPressed: isSubmitting ? null : onPressed,
      icon: Icon(
        iconData,
        size: size ?? 16.0,
        color: textColor ?? ConfigColor.secondaryTextColor,
      ),
      label: Text(
        text,
        style: TextStyle(
            color: textColor ?? ConfigColor.secondaryTextColor,
            fontSize: size ?? 16.0),
      ),
      elevation: elevation ?? 0.0,
      color: buttonColor ?? ConfigColor.primaryColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
    );
  }

  return RaisedButton(
    onPressed: isSubmitting ? null : onPressed,
    child: isSubmitting
        ? const FittedBox(
            fit: BoxFit.contain,
            child: SpinKitCircle(
              color: Colors.white,
              size: 16.0,
            ),
          )
        : Text(
            text,
            style: TextStyle(
                color: textColor ?? ConfigColor.secondaryTextColor,
                fontSize: size ?? 16.0),
          ),
    elevation: 0.0,
    color: buttonColor ?? ConfigColor.primaryColor,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
  );
}

Widget defaultIconButton(
        {required IconData iconData,
        required void Function() onPressed,
        Color? color,
        double? size,
        String? tooltip}) =>
    IconButton(
      icon: Icon(
        iconData,
        size: size ?? 20.0,
      ),
      onPressed: onPressed,
      color: color,
      tooltip: tooltip,
    );
