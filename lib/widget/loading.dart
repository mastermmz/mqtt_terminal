import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';

class LoadingWidget extends StatefulWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  State<LoadingWidget> createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget> {
  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      // width: wsize - 40,
      blur: 3,
      color: Colors.white.withOpacity(0.2),
      border: const Border.fromBorderSide(BorderSide.none),
      shadowStrength: 2,
      // shape: BoxShape.circle,
      // borderRadius: BorderRadius.circular(16),
      child: Container(
        alignment: Alignment.center,
        //padding: EdgeInsets.symmetric(horizontal: 70.0 ,vertical: 20.0),
        child:  const SpinKitRing(
          color: Colors.white,
          size: 100.0,
          lineWidth: 10.0,
        ),
      ),
    );
  }
}
