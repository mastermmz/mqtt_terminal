import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

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
      hint: Text(
        libelText,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.w700,
          color: Colors.black87,
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
            color: Colors.black87,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ))
          .toList(),
      value: selectedValues,
      onChanged: onChengFun,
      buttonStyleData: ButtonStyleData(
        height: 40,
        width: width,
        padding: const EdgeInsets.only(left: 14, right: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: Colors.black26,
          ),
          color: const Color(0xff4797f0),
        ),
        // elevation: 2,
      ),
      iconStyleData: const IconStyleData(
        icon: Icon(
          Icons.arrow_forward_ios_outlined,
        ),
        iconSize: 14,
        iconEnabledColor: Colors.black87,
        iconDisabledColor: Colors.black87,
      ),
      dropdownStyleData: DropdownStyleData(
        // maxHeight: 200,
        // width: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: const Color(0xff4797f0),
        ),
        // offset: const Offset(-20, 0),
        scrollbarTheme: ScrollbarThemeData(
          radius: const Radius.circular(40),
          thickness: MaterialStateProperty.all<double>(6),
          thumbVisibility: MaterialStateProperty.all<bool>(true),
        ),
      ),
      menuItemStyleData: const MenuItemStyleData(
        height: 40,
        padding: EdgeInsets.only(left: 14, right: 14),
      ),
    ),
  );
}