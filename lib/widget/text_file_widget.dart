import 'package:flutter/material.dart';

Color fildColors = const Color(0xffdfdfdf);
Color colorFildText =  const Color(0xff000000);


Widget textFildWidget({
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
}){
  return Container(
    margin: EdgeInsets.symmetric(vertical: inputMargin),
    padding: EdgeInsets.only(left: inputPaddingL , right: inputPaddingR),
    child: TextField(
      obscureText: showPassword,
      maxLength: maxChar,
      keyboardType: textInputType,
      controller: controller,
      style: textFildStyleWidget,
      decoration: InputDecoration(
        filled: true,
        fillColor: fildColors,
        // focusColor: Colors.red,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide.none,
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

