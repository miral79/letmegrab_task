import 'package:flutter/widgets.dart';
// ignore: depend_on_referenced_packages
import 'package:get/get.dart';

class ResponsiveService extends GetxService {
  late double width;
  late double height;

  /// Initialize with context
  void init(BuildContext context) {
    final size = MediaQuery.of(context).size;
    width = size.width;
    height = size.height;
  }

  bool get isMobile => width < 600;
  bool get isTablet => width >= 600 && width < 1024;
  bool get isDesktop => width >= 1024;

  /// Scale text size based on screen width
  double scaleText(double size) => size * (width / 375);

  /// Scale UI element proportionally to screen width
  double scaleWidth(double value) => value * (width / 375);

  /// Scale UI element proportionally to screen height
  double scaleHeight(double value) => value * (height / 812);
}
