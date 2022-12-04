import 'package:flutter/material.dart';

Color primaryColor = Colors.cyan.shade600;
Color primaryColorDark = Colors.cyan.shade800;
Color textColor = Colors.white;
Color backgroundColor = Colors.deepOrangeAccent;
Color textOnBackgroundColor = Colors.amber.shade100;
Color canvasColor = Colors.amber.shade200;
Color titleColor = Colors.deepPurple;
MaterialColor dogTagColor = Colors.deepPurple;

Color lighten(Color color, [double amount = .1]) {
  assert(amount >= 0 && amount <= 1);

  final hsl = HSLColor.fromColor(color);
  final hslLight = hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));

  return hslLight.toColor();
}