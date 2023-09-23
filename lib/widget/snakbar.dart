import 'package:animated_snack_bar/animated_snack_bar.dart';


void snakbarShowModel({Duration number = const Duration(milliseconds: 21) , required String msg , required context , AnimatedSnackBarType snakbarType = AnimatedSnackBarType.success}){
  AnimatedSnackBar.material(
    duration: number,
    msg,
    type: snakbarType,
    desktopSnackBarPosition: DesktopSnackBarPosition.topCenter,
  ).show(context);
}

