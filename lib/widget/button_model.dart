import 'package:flutter/material.dart';


Widget buttonWidget({
  FontWeight labelTextFontWeight = FontWeight.normal,
  Color labelTextColor = Colors.white,
  required labelText,
  required buttonFunction ,
  double? fontSizeButton = 20.0 ,
  double horizontalButtonSize = 50.0 ,
  double horizontalMarginSize = 1.0 ,
  double verticalMarginSize = 0.0,
  bool access = true,
}){
  return GestureDetector(
    onTap: (){
      buttonFunction();
    },
    child: Container(
      padding:  EdgeInsets.symmetric(horizontal: horizontalButtonSize , vertical: 7.0),
      margin: EdgeInsets.symmetric(horizontal: horizontalMarginSize , vertical: verticalMarginSize),
      decoration: BoxDecoration(
        gradient: access == true ? const LinearGradient(
          begin: FractionalOffset.topLeft,
          end: FractionalOffset.bottomRight,
          colors: [Color(0xff2c5977), Color(0xff7799bb) ],
        ) : null,
        color: access == false ? const Color(0xffbbbbbb) : null,

        borderRadius: BorderRadius.circular(60.0),
      ),
      child: Text(
        labelText,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: fontSizeButton,
          color: labelTextColor,
          fontWeight: labelTextFontWeight,
        ),
      ),
    ),
  );
}

