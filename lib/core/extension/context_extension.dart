// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);
}

extension MediaQueryExtension on BuildContext {
  double get height => mediaQuery.size.height;
  double get width => mediaQuery.size.width;

  double get textFieldWidthValue => width * 0.65;
  double get textFieldHeightValue => height * 0.06;

  double get buttonWidthValue => width * 0.65;
  double get buttondHeightValue => height * 0.05;

  double get lowValue => height * 0.01;
  double get normalValue => height * 0.02;
  double get largeValue => height * 0.04;
  double get VeryLargeValue => height * 0.06;
}

extension ThemeExtension on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;
  ColorScheme get colors => theme.colorScheme;
}

extension PaddingExtensionAll on BuildContext {
  EdgeInsets get paddingLow => EdgeInsets.all(lowValue);
  EdgeInsets get paddingNormal => EdgeInsets.all(normalValue);
  EdgeInsets get paddingLarge => EdgeInsets.all(largeValue);
  EdgeInsets get paddingVeryLarge => EdgeInsets.all(VeryLargeValue);
}

extension DurationExtension on BuildContext {
  Duration get lowDuration => const Duration(milliseconds: 500);
  Duration get mediumDuration => const Duration(seconds: 1);
  Duration get largeDuration => const Duration(seconds: 2);
}

extension ColorExtension on BuildContext {
  Color get specialBlue => const Color.fromARGB(255, 55, 130, 216);
}

extension RadiusExtension on BuildContext {
  BorderRadius get smallRadius => BorderRadius.circular(4.0);
  BorderRadius get mediumRadius => BorderRadius.circular(12.0);
  BorderRadius get largeRadius => BorderRadius.circular(36.0);
}
