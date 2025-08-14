// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_element

part of 'dating_app_color.dart';

// **************************************************************************
// ThemeExtensionsGenerator
// **************************************************************************

mixin _$ThemeExtensionMixin on ThemeExtension<DatingAppColor> {
  @override
  ThemeExtension<DatingAppColor> copyWith({
    Color? primary50,
    Color? primary700,
    Color? primary800,
    Color? gray300,
    Color? gray400,
    Color? gray500,
    Color? gray600,
    Color? gray700,
    Color? grayInputField,
    Color? blueBorderColor,
    Color? primaryBrandColor,
    Color? borderColor,
    Color? coquelicot,
    Color? night,
    Color? darkGray,
    Color? antiFlashWhite,
    Color? earthYellow,
  }) {
    final object = this as DatingAppColor;

    return DatingAppColor(
      primary50: primary50 ?? object.primary50,
      primary700: primary700 ?? object.primary700,
      primary800: primary800 ?? object.primary800,
      gray300: gray300 ?? object.gray300,
      gray400: gray400 ?? object.gray400,
      gray500: gray500 ?? object.gray500,
      gray600: gray600 ?? object.gray600,
      gray700: gray700 ?? object.gray700,
      grayInputField: grayInputField ?? object.grayInputField,
      blueBorderColor: blueBorderColor ?? object.blueBorderColor,
      primaryBrandColor: primaryBrandColor ?? object.primaryBrandColor,
      borderColor: borderColor ?? object.borderColor,
      coquelicot: coquelicot ?? object.coquelicot,
      night: night ?? object.night,
      darkGray: darkGray ?? object.darkGray,
      antiFlashWhite: antiFlashWhite ?? object.antiFlashWhite,
      earthYellow: earthYellow ?? object.earthYellow,
    );
  }

  @override
  ThemeExtension<DatingAppColor> lerp(
    ThemeExtension<DatingAppColor>? other,
    double t,
  ) {
    final otherValue = other;

    if (otherValue is! DatingAppColor) {
      return this;
    }

    final value = this as DatingAppColor;

    return DatingAppColor(
      primary50: Color.lerp(
        value.primary50,
        otherValue.primary50,
        t,
      )!,
      primary700: Color.lerp(
        value.primary700,
        otherValue.primary700,
        t,
      )!,
      primary800: Color.lerp(
        value.primary800,
        otherValue.primary800,
        t,
      )!,
      gray300: Color.lerp(
        value.gray300,
        otherValue.gray300,
        t,
      )!,
      gray400: Color.lerp(
        value.gray400,
        otherValue.gray400,
        t,
      )!,
      gray500: Color.lerp(
        value.gray500,
        otherValue.gray500,
        t,
      )!,
      gray600: Color.lerp(
        value.gray600,
        otherValue.gray600,
        t,
      )!,
      gray700: Color.lerp(
        value.gray700,
        otherValue.gray700,
        t,
      )!,
      grayInputField: Color.lerp(
        value.grayInputField,
        otherValue.grayInputField,
        t,
      )!,
      blueBorderColor: Color.lerp(
        value.blueBorderColor,
        otherValue.blueBorderColor,
        t,
      )!,
      primaryBrandColor: Color.lerp(
        value.primaryBrandColor,
        otherValue.primaryBrandColor,
        t,
      )!,
      borderColor: Color.lerp(
        value.borderColor,
        otherValue.borderColor,
        t,
      )!,
      coquelicot: Color.lerp(
        value.coquelicot,
        otherValue.coquelicot,
        t,
      )!,
      night: Color.lerp(
        value.night,
        otherValue.night,
        t,
      )!,
      darkGray: Color.lerp(
        value.darkGray,
        otherValue.darkGray,
        t,
      )!,
      antiFlashWhite: Color.lerp(
        value.antiFlashWhite,
        otherValue.antiFlashWhite,
        t,
      )!,
      earthYellow: Color.lerp(
        value.earthYellow,
        otherValue.earthYellow,
        t,
      )!,
    );
  }

  @override
  bool operator ==(Object other) {
    final value = this as DatingAppColor;

    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DatingAppColor &&
            identical(value.primary50, other.primary50) &&
            identical(value.primary700, other.primary700) &&
            identical(value.primary800, other.primary800) &&
            identical(value.gray300, other.gray300) &&
            identical(value.gray400, other.gray400) &&
            identical(value.gray500, other.gray500) &&
            identical(value.gray600, other.gray600) &&
            identical(value.gray700, other.gray700) &&
            identical(value.grayInputField, other.grayInputField) &&
            identical(value.blueBorderColor, other.blueBorderColor) &&
            identical(value.primaryBrandColor, other.primaryBrandColor) &&
            identical(value.borderColor, other.borderColor) &&
            identical(value.coquelicot, other.coquelicot) &&
            identical(value.night, other.night) &&
            identical(value.darkGray, other.darkGray) &&
            identical(value.antiFlashWhite, other.antiFlashWhite) &&
            identical(value.earthYellow, other.earthYellow));
  }

  @override
  int get hashCode {
    final value = this as DatingAppColor;

    return Object.hash(
      runtimeType,
      value.primary50,
      value.primary700,
      value.primary800,
      value.gray300,
      value.gray400,
      value.gray500,
      value.gray600,
      value.gray700,
      value.grayInputField,
      value.blueBorderColor,
      value.primaryBrandColor,
      value.borderColor,
      value.coquelicot,
      value.night,
      value.darkGray,
      value.antiFlashWhite,
      value.earthYellow,
    );
  }
}

extension DatingAppColorBuildContext on BuildContext {
  DatingAppColor get datingAppColor =>
      Theme.of(this).extension<DatingAppColor>()!;
}
