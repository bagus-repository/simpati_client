import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simpati_client/cores/configs/colors_config.dart';

InputDecoration defaultInputDecor() => InputDecoration(
      filled: true,
      fillColor: Colors.white70,
      isDense: true,
      enabledBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(
          Radius.circular(10.0),
        ),
        borderSide:
            BorderSide(width: 1.5, color: Colors.black38.withOpacity(0.3)),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(
          Radius.circular(10.0),
        ),
        borderSide:
            BorderSide(width: 1.5, color: Colors.black38.withOpacity(0.3)),
      ),
      errorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
        borderSide: BorderSide(width: 1.5, color: Colors.red),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(
          Radius.circular(15.0),
        ),
        borderSide: BorderSide(width: 2.5, color: ConfigColor.primaryColor),
      ),
      focusedErrorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(15.0),
        ),
        borderSide: BorderSide(width: 2.5, color: Colors.red),
      ),
    );

TextField defaultTxtField({
  required TextEditingController controller,
  String? hint,
  String? label,
  String? errorText,
  bool isDisable = false,
  bool isSecret = false,
  bool isCollapsed = false,
  int? minLines,
  int? maxlines,
  void Function(String)? onChanged,
  Widget? suffixIcon,
  List<TextInputFormatter> inputFormats = const [],
  TextInputType inputType = TextInputType.text,
  TextInputAction? inputAction,
  FocusNode? focusNode,
  void Function()? onTap,
}) {
  return TextField(
    autofocus: false,
    enabled: !isDisable,
    obscureText: isSecret,
    minLines: minLines,
    maxLines: maxlines,
    cursorColor: ConfigColor.secondaryColor,
    decoration: defaultInputDecor().copyWith(
        labelStyle: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
            color: Colors.grey.shade700),
        hintText: hint,
        labelText: label,
        errorText: errorText == '' ? null : errorText,
        // filled: controller.text.isNotEmpty,
        suffixIcon: suffixIcon),
    controller: controller,
    onChanged: onChanged,
    inputFormatters: inputFormats,
    keyboardType: inputType,
    focusNode: focusNode,
    onTap: onTap,
    textInputAction: inputAction,
  );
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
