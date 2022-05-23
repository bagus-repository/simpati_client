import 'package:flutter/material.dart';
import 'package:simpati_client/cores/models/screen_argument_model.dart';

class MenuModel {
  String menuId;
  String menuLink;
  String menuName;
  Color menuColor;
  IconData menuIcon;
  List<ScreenArgument> submenus;

  MenuModel({
    required this.menuId,
    required this.menuLink,
    required this.menuName,
    required this.menuColor,
    required this.menuIcon,
    this.submenus = const [],
  });
}
