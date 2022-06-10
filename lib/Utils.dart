import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class Utils {
  static showSnackBar(String? text) {
    if (text == null) return;

    final messengerKey = GlobalKey<ScaffoldMessengerState>();

    final snackBar = SnackBar(content: Text(text),
      backgroundColor: Colors.red,);

    messengerKey.currentState!
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

}
Widget slider () {
  var sliderSleek = SleekCircularSlider(
      appearance: CircularSliderAppearance(
        size: 50,
        customColors: CustomSliderColors(
            trackColor: Colors.blue,
            progressBarColor: Colors.blue
        ) ,
        spinnerMode: true,
      ));
  return sliderSleek;
}