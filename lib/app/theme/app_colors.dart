// ignore_for_file: use_full_hex_values_for_flutter_colors

import 'package:flutter/material.dart';

class AppColors {
  static final List<Map<String, Color>> colors = [
    {
      'light': Color(0xFFF6F6F6),
      'main': Color(0xFF64748B),
      'text': Color(0xFF4B5563),
    },
    {
      'light': Color(0xFFF3E8FF),
      'main': Color(0xFFA855F7),
      'text': Color(0xFF9333EA),
    },
    {
      'light': Color(0xFFDCFCE7),
      'main': Color(0xFF22C55E),
      'text': Color(0xFF047857),
    },
    {
      'light': Color(0xFFFEF3C7),
      'main': Color(0xFFF59E0B),
      'text': Color(0xFFD97706),
    },
    {
      'light': Color(0xFFF0F9FF),
      'main': Color(0xFF3B82F6),
      'text': Color(0xFF2563EB),
    },
    {
      'light': Color(0xFFD1FAE5),
      'main': Color(0xFF059669),
      'text': Color(0xFF047857),
    },
    {
      'light': Color(0xFFECFEFF),
      'main': Color(0xFF06B6D4),
      'text': Color(0xFF0891B2),
    },
    {
      'light': Color(0xFFF5F3FF),
      'main': Color(0xFF8B5CF6),
      'text': Color(0xFF7C3AED),
    },
    {
      'light': Color(0xFFFCE7F3),
      'main': Color(0xFFEC4899),
      'text': Color(0xFFDB2777),
    },
    {
      'light': Color(0xFFE0E7FF),
      'main': Color(0xFF6366F1),
      'text': Color(0xFF4F46E5),
    },
  ];

  // 🌙 Primary brand colors
  static const Color primary = Color(0xFF0A84FF); // Blue
  static const Color primaryDark = Color(0xFF0066CC);
  static const Color primaryLight = Color(0xFF66B3FF);

  // 🌿 Secondary / accent colors
  static const Color secondary = Color(0xFFFF9500); // Orange
  static const Color secondaryDark = Color(0xFFCC7700);
  static const Color secondaryLight = Color(0xFFFFB84D);

  // ❤️ Status colors
  static const Color success = Color(0xFFC5F2B0); // Green
  static const Color error = Color(0xFFFF4769); // Red
  static const Color warning = Color(0xFFFFCC00); // Yellow
  static const Color info = Color(0xFF5AC8FA);

  // 🖤 Neutral / grayscale
  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);
  static const Color grey = Color(0xFF8E8E93);
  static const Color lightGrey = Color(0xFFD1D1D6);
  static const Color darkGrey = Color(0xFF3A3A3C);

  // 🎨 Backgrounds
  static const Color background = Color(0xFFF2F2F7);
  static const Color card = Color(0xFFFFFFFF);
  static const Color shadow = Color(0x1A000000);
  static const Color closeBgColor = Color(0xFFF4F4F4);

  // 🎨 Buttons
  static const Color enableButtonColor = Color(0xFF49BC8E);
  static const Color disableButtonColor = Color(0xFFC6E5D5);

  // 🔘 Indicator
  static const Color enableindicatorColor = Color(0xFF36A576);
  static const Color disableindicatorColor = Color(0xFFDDDDDD);

  static const Color textFiledbroderColor = Color(0xFFDDDDDD);

  static const Color skipColor = Color(0xFF7A7A7A);

  static const Color textColor = Color(0xFF1E1E1E);
  static const Color otpTColor = Color(0xFF606060);

  static const Color greySecondery = Color(0xFF646773);
  static const Color primaryBlack = Color(0xFF070707);
  static const Color redColor = Color(0xFFFF1943);
  static const Color linearGrey = Color(0xFFD9D9D9);
  static const Color yellowColor = Color(0xFFDDA20E);

  static const Color containerBackgroundColorYellow = Color(0xFFFFFEE8);
  static const Color containerBackgroundColorGreen = Color(0xFFDEF9ED);
  static const Color containerBackgroundColorPink = Color(0xFFFCEAE6);
  static const Color dividercolor = Color(0xFFE8E8E8);
  static const Color darkestBlue = Color(0xFF111527);

  static const Color allmembercontinerbackgroundcoloryellow = Color(0xFFFFFEE8);
  static const Color allmembercontinerbackgroundcolorgreen = Color(0xFFDEF9ED);
  static const Color continerbackgroundyellow = Color(0xFFFDF1AE);
  static const Color continerbackgroundpink = Color(0xFFF6C5BD);
  static const Color continerbackgroundgreen = Color(0xFFFC6E5D5);
  static const Color continerbackgroundred = Color(0xFFFFF8185);

  static const Color taskstatusbackgroundcontinergrey = Color(0xFF4B5563);
  static const Color taskstatusbackgroundcontineryellow = Color(0xFFFFB61D);
  static const Color deteleiconcolor = Color(0xFFFF3333);
  static const Color continerbackgroundcoloryellow = Color(0xFFFFFEE8);
  static const Color buttonbackgroundcolor = Color(0xFFE8173D);
  static const Color blackShades = Color(0xFF030612);
  static const Color yellow600 = Color(0xFF8E610A);
  static const Color redFlag = Color(0xFFFF5A5A);

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, primaryDark],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  //rajvi //addnewtask
  static const Color addnewtaskcontinerbackgroundcolor = Color(0xFF88B4D0);
  static const Color addnewtaskiconcolorblack = Color(0xFF292D32);
  static const Color addnewstatuscolorblue = Color(0xFF88B4D0);
  static const Color addnewstatuscoloryellow = Color(0xFFFFB405);
  static const Color addnewstatuscolorindigo = Color(0xFF7B61FF);
  static const Color addnewstatuscolorgreen = Color(0xFF36A576);
}
