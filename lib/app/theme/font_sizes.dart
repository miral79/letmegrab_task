// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class FontSizes {
  // Extra Small
  static const double xs = 10.0;
  static const double sm = 12.0;
  static const double md = 14.0;
  static const double lg = 16.0;
  static const double xl = 18.0;

  // Heading Levels
  static const double h6 = 20.0;
  static const double h5 = 22.0;
  static const double h4 = 24.0;
  static const double h3 = 28.0;
  static const double h2 = 32.0;
  static const double h1 = 36.0;

  // Display sizes
  static const double displaySmall = 40.0;
  static const double displayMedium = 48.0;
  static const double displayLarge = 56.0;

  // Custom semantic aliases
  static const double ten = 10.0; // same as xs
  static const double linke = 14.0; // same as md

  /// Get a responsive font size depending on phone/tablet
  static double responsive(BuildContext context, double baseSize) {
    final width = MediaQuery.of(context).size.width;
    final scaleFactor = MediaQuery.of(context).textScaleFactor;

    if (width < 600) {
      // Phone → use normal base size
      return baseSize * scaleFactor;
    } else if (width < 900) {
      // Small Tablet → slightly larger
      return baseSize * 1.2 * scaleFactor;
    } else {
      // Large Tablet / Desktop → even larger
      return baseSize * 1.4 * scaleFactor;
    }
  }
}
