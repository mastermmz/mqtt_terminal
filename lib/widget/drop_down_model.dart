import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../color_teme.dart';

Widget dropDownmodel({
  required List<String> items ,
  required String? selectedValues ,
  required onChengFun ,
  required String libelText,
  double width = 130,
  double fontSize = 12.0,
}){
  return DropdownButtonHideUnderline(
    child: DropdownButton2<String>(
      isExpanded: true,
      barrierColor: Color(0x95A6A6A6),
      hint: Text(
        libelText,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.w700,
          color: Colors.black,
        ),
        overflow: TextOverflow.ellipsis,
      ),
      items: items
          .map((String item) => DropdownMenuItem<String>(
        value: item,
        child: Text(
          item,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ))
          .toList(),
      value: selectedValues,
      onChanged: onChengFun,
      buttonStyleData: ButtonStyleData(
        // height: 40,
        // width: width,
        // padding: const EdgeInsets.only(left: 14, right: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Colors.black,
          ),
          color: focusColor,

        ),
      ),
      iconStyleData: const IconStyleData(
        icon: Icon(
          Icons.arrow_forward_ios_outlined,
        ),
        iconSize: 14,
        iconEnabledColor: Colors.black,
        iconDisabledColor: Colors.black,
      ),
      dropdownStyleData: DropdownStyleData(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: focusColor,
        ),
        scrollbarTheme: ScrollbarThemeData(
          radius: const Radius.circular(8),
          thickness: MaterialStateProperty.all<double>(6),
          thumbVisibility: MaterialStateProperty.all<bool>(true),
        ),
      ),
      // menuItemStyleData: const MenuItemStyleData(
      //   // height: 40,
      //   // padding: EdgeInsets.only(left: 14, right: 14),
      // ),
    ),
  );
}