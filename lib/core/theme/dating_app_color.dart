import 'package:flutter/material.dart';
import 'package:theme_extensions_builder_annotation/theme_extensions_builder_annotation.dart';

part 'dating_app_color.g.theme.dart';

@themeExtensions
class DatingAppColor extends ThemeExtension<DatingAppColor>
    with _$ThemeExtensionMixin {
  const DatingAppColor({
    this.blueBorderColor = const Color(0xFF0B0077),
    this.borderColor = const Color(0xFF3E3E3E),
    this.coquelicot = const Color(0xFFFF3C00),
    this.night = const Color(0xFF151515),
    this.darkGray = const Color(0xFF5A5A5A),
    this.antiFlashWhite = const Color(0xFFEEEEEE),
    this.earthYellow = const Color(0xFFF7B15B),
    this.primary50 = const Color(0xFFFFFCFB),
    this.primaryBrandColor = const Color(0xFFE50914),
    this.primary700 = const Color(0xFFFF3C00),
    this.primary800 = const Color(0xFF8E2100),
    this.gray300 = const Color(0xFFC4C4C4),
    this.gray400 = const Color(0xFFA3A3A3),
    this.gray500 = const Color(0xFF7B7B7B),
    this.gray600 = const Color(0xFF4B4B4B),
    this.gray700 = const Color(0xFF141414),
    this.grayInputField = const Color(0xFF414141),
  });

  final Color primary50;
  final Color primary700;
  final Color primary800;

  final Color gray300;
  final Color gray400;
  final Color gray500;
  final Color gray600;
  final Color gray700;
  final Color grayInputField;

  final Color blueBorderColor;
  final Color primaryBrandColor;

  final Color borderColor;

  final Color coquelicot;
  final Color night;
  final Color darkGray;
  final Color antiFlashWhite;
  final Color earthYellow;
}
