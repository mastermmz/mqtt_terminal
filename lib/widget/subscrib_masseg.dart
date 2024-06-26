import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import 'mqtt_version.dart';

Widget subscribMasseg(SubscribMassegClass subscribMasseg , context){
  var send = const BorderRadius.only(
    bottomLeft: Radius.circular(20.0),
    // bottomRight:Radius.circular(20.0),
    topLeft: Radius.circular(20.0),
    topRight:  Radius.circular(20.0),
  );
  var resev = const BorderRadius.only(
    // bottomLeft: Radius.circular(20.0),
    bottomRight:Radius.circular(20.0),
    topLeft: Radius.circular(20.0),
    topRight:  Radius.circular(20.0),
  );
  BorderRadius shipe = const BorderRadius.only();
  Color massegColor = Colors.white70;
  Color massegFildColor = Colors.white70;
  if(subscribMasseg.send == true){
    shipe = send;
    massegFildColor = subscribMasseg.massegColor;
    massegColor = const Color(0xffE4F0FE);

  }else{
    shipe = resev;
    massegFildColor = const Color(0xffdfdfdf);
    massegColor = const Color(0xff5d5d5d);
  }
  return Container(
    // color: Colors.red,
    width: 10,
    // height: 5,
    alignment:subscribMasseg.send == true? Alignment.centerRight: Alignment.centerLeft,
    padding:  const EdgeInsets.symmetric(horizontal: 10 , vertical: 2.0),
    // padding:  const EdgeInsets.only(left: 10),
    margin: const EdgeInsets.symmetric(horizontal: 10 , vertical:2),
    //
    // decoration: BoxDecoration(
    //   color: subscribMasseg.massegColor,
    //   borderRadius: shipe,
    // ),
    child: Column(
      crossAxisAlignment: subscribMasseg.send == true? CrossAxisAlignment.end:CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: AutoSizeText(
                subscribMasseg.topic! ,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: const TextStyle(
                    fontWeight: FontWeight.w700) ,
                textAlign: TextAlign.left)
        ),
        Container(
            alignment: subscribMasseg.send == true?Alignment.centerLeft: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Text(mqttTopicVersionList[subscribMasseg.topicsVersion!] , style: const TextStyle(fontSize: 10.0 , fontWeight: FontWeight.w400) , textAlign: TextAlign.left)),
        Container(
          // alignment: Alignment.centerRight,
          padding:  const EdgeInsets.symmetric(horizontal: 30 , vertical: 10.0),
          // padding:  const EdgeInsets.only(left: 10),
          // margin: const EdgeInsets.symmetric(horizontal: 20 , vertical:8),
          decoration: BoxDecoration(
            color: massegFildColor,
            borderRadius: shipe,
          ),
          child: Text(
            subscribMasseg.masseg! ,
            style: TextStyle(
              color: massegColor,
                fontSize: 12.0 ,
                fontWeight: FontWeight.w400)
            ,
          )
        ),

      ],
    ),
  );
}

class SubscribMassegClass{
  String? masseg;
  String? topic;
  int? topicsVersion;
  bool? send;
  Color massegColor = const Color(0xff0177FC);
}