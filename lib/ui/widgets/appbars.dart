import 'package:flutter/material.dart';
import 'package:simpati_client/cores/configs/colors_config.dart';

PreferredSizeWidget defaultAppBar({
  required String title,
  List<Widget> actions = const [],
  PreferredSizeWidget? bottom,
}) =>
    AppBar(
      title: Text(
        title,
        style: TextStyle(color: ConfigColor.secondaryTextColor),
      ),
      backgroundColor: ConfigColor.backgroundColor,
      actions: actions,
      bottom: bottom,
      elevation: 0.0,
      iconTheme: IconThemeData(color: ConfigColor.secondaryTextColor),
    );
