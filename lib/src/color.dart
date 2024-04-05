import 'package:flutter/material.dart';

extension ColorExt on Color{

  ///Make color more brighten
  Color brighten([double percent = 0]) {
    assert(
    0 <= percent && percent <= 1,
    'percentage must be between 0 and 1',
    );
    final p = percent;
    return Color.fromARGB(
      alpha,
      red + ((255 - red) * p).round(),
      green + ((255 - green) * p).round(),
      blue + ((255 - blue) * p).round(),
    );
  }

  ///Make color more darken
  Color darken([double percent = 0]) {
    assert(
    0 <= percent && percent <= 1,
    'percentage must be between 0 and 1',
    );
    final p = percent;
    return Color.fromARGB(
      alpha,
      red - (red * p).round(),
      green - (green * p).round(),
      blue - (blue * p).round(),
    );
  }

  Color getTextColorForBackground() {
    final double relativeLuminance = computeLuminance();
    // const double kThreshold = 0.15; //this is for the material
    const double kThreshold = 0.18;
    if ((relativeLuminance + 0.05) * (relativeLuminance + 0.05) > kThreshold) {
      return Colors.black;
    }
    return Colors.white;
  }


}