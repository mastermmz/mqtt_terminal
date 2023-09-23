import 'package:flutter/material.dart';

import 'icon_path.dart';



Widget brokerButtonList({
  required name ,
  required host,
  required port,
  required username,
  required onTap,
  required onLongPress,
  required int iconPath,
}){
  return GestureDetector(
    onTap: onTap,
    onLongPress: onLongPress,
    child: Container(
      // padding:  const EdgeInsets.symmetric(horizontal: 20 , vertical: 7.0),
      // margin: const EdgeInsets.symmetric(horizontal: 30 , vertical:5),
      decoration: BoxDecoration(
        // gradient: const LinearGradient(
        //   begin: FractionalOffset.topLeft,
        //   end: FractionalOffset.bottomRight,
        //   colors: [Color(0xff406e78), Color(0xff777cbb) ],
        // ),
        color:const Color(0x7f0177fc),

        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [

          Icon(iconsPathModel[iconPath] , size: 70.0),
          Text(name , style: const TextStyle(fontWeight: FontWeight.w700 , fontSize: 25.0)),
          Text("$host:$port" , style: const TextStyle(fontWeight: FontWeight.w700 , fontSize: 10.0)),
          const SizedBox(height: 10,),
        ],
      ),
    ),
  );
}