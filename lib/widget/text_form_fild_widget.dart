import 'package:flutter/material.dart';

import '../color_teme.dart';

Widget textForFildWidget({
  bool showPassword = false,
  int? maxChar,
  TextInputType textInputType = TextInputType.name,
  required TextEditingController? controller,
  TextStyle? textFildStyleWidget,
  String? errorTextShow,
  String? labelText,
  double inputMargin = 5.0,
  double inputPaddingL = 15.0,
  double inputPaddingR = 15.0,
  String? Function(String?)? validator,
}) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: inputMargin),
    padding: EdgeInsets.only(left: inputPaddingL, right: inputPaddingR),
    child: TextFormField(

      validator: validator,
      obscureText: showPassword,
      maxLength: maxChar,
      keyboardType: textInputType,
      controller: controller,
      style: textFildStyleWidget,
      decoration: InputDecoration(
        filled: true,

        fillColor: focusColor,

        focusColor: focusColor,

        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          // gapPadding: 50.0,
          borderSide: BorderSide(
            width: 3,
            color: Colors.grey,
            strokeAlign: 20.0,
          ),
        ),

        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          borderSide: BorderSide(width: 3, color: Colors.redAccent),
        ),
        errorText: errorTextShow,

        labelText: labelText,
        labelStyle: TextStyle(
          color: colorFildText,
        ),
        // floatingLabelBehavior: FloatingLabelBehavior. ,
      ),
    ),
  );
}
