import 'package:kapil_add_to_app_flutter/theme/assets/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

mixin AppFonts {
  static String poppins = 'Poppins';
  static String dmSans = 'DMSans';
}

class TextStyleFactory {
  static TextStyle styleBold8({
    Color color = AppColors.black,
    FontWeight fontWeight = FontWeight.w700,
    String? fontFamily,
  }) {
    return TextStyle(
      fontFamily: fontFamily ?? AppFonts.poppins,
      fontWeight: fontWeight,
      color: color,
      fontSize: 8,
    );
  }

  static TextStyle styleBold10({
    Color color = AppColors.black,
    FontWeight fontWeight = FontWeight.w700,
    String? fontFamily,
  }) {
    return TextStyle(
      fontFamily: fontFamily ?? AppFonts.poppins,
      fontWeight: fontWeight,
      color: color,
      fontSize: 10,
    );
  }

  static TextStyle styleBold12({
    Color color = AppColors.black,
    FontWeight fontWeight = FontWeight.w700,
    String? fontFamily,
  }) {
    return TextStyle(
      fontFamily: fontFamily ?? AppFonts.poppins,
      fontWeight: fontWeight,
      color: color,
      fontSize: 12,
    );
  }

  static TextStyle styleBold14({
    Color? color = AppColors.black,
    FontWeight fontWeight = FontWeight.w700,
    String? fontFamily,
  }) {
    return TextStyle(
      fontFamily: fontFamily ?? AppFonts.poppins,
      fontWeight: fontWeight,
      color: color,
      fontSize: 14,
    );
  }

  static TextStyle styleBold16({
    Color color = AppColors.black,
    FontWeight fontWeight = FontWeight.w700,
    String? fontFamily,
  }) {
    return TextStyle(
      fontFamily: fontFamily ?? AppFonts.poppins,
      fontWeight: fontWeight,
      color: color,
      fontSize: 16,
    );
  }

  static TextStyle styleBold20({
    Color color = AppColors.black,
    FontWeight fontWeight = FontWeight.w700,
    String? fontFamily,
  }) {
    return TextStyle(
      fontFamily: fontFamily ?? AppFonts.poppins,
      fontWeight: fontWeight,
      color: color,
      fontSize: 20,
    );
  }

  static TextStyle styleNormal10({
    Color color = AppColors.black,
    FontWeight fontWeight = FontWeight.w400,
    String? fontFamily,
  }) {
    return TextStyle(
      fontFamily: fontFamily ?? AppFonts.poppins,
      fontWeight: fontWeight,
      color: color,
      fontSize: 10,
    );
  }

  static TextStyle styleNormal11({
    Color color = AppColors.black,
    FontWeight fontWeight = FontWeight.w500,
    String? fontFamily,
  }) {
    return TextStyle(
      fontFamily: fontFamily ?? AppFonts.poppins,
      fontWeight: fontWeight,
      color: color,
      fontSize: 12,
    );
  }

  static TextStyle styleNormal12({
    Color? color = AppColors.black,
    FontWeight fontWeight = FontWeight.w500,
    String? fontFamily,
  }) {
    return TextStyle(
      fontFamily: fontFamily ?? AppFonts.poppins,
      fontWeight: fontWeight,
      color: color,
      fontSize: 12,
    );
  }

  static TextStyle styleNormal14({
    Color? color = AppColors.black,
    FontWeight fontWeight = FontWeight.w500,
    String? fontFamily,
  }) {
    return TextStyle(
      fontFamily: fontFamily ?? AppFonts.poppins,
      fontWeight: fontWeight,
      color: color,
      fontSize: 14,
    );
  }

  static TextStyle styleNormal16({
    Color color = AppColors.black,
    FontWeight fontWeight = FontWeight.w500,
    String? fontFamily,
  }) {
    return TextStyle(
      fontFamily: fontFamily ?? AppFonts.poppins,
      fontWeight: fontWeight,
      color: color,
      fontSize: 16,
    );
  }

  static TextStyle styleNormal18({
    Color color = AppColors.black,
    FontWeight fontWeight = FontWeight.w500,
    String? fontFamily,
  }) {
    return TextStyle(
      fontFamily: fontFamily ?? AppFonts.poppins,
      fontWeight: fontWeight,
      color: color,
      fontSize: 16,
    );
  }

  static TextStyle styleNormal20({
    Color color = AppColors.black,
    FontWeight fontWeight = FontWeight.w500,
    String? fontFamily,
  }) {
    return TextStyle(
      fontFamily: fontFamily ?? AppFonts.poppins,
      fontWeight: fontWeight,
      color: color,
      fontSize: 20,
    );
  }

  static TextStyle regular(
    double fontSize, {
    Color color = AppColors.black,
    FontWeight fontWeight = FontWeight.w400,
    String? fontFamily,
  }) {
    return TextStyle(
      fontFamily: fontFamily ?? AppFonts.poppins,
      fontWeight: fontWeight,
      color: color,
      fontSize: fontSize,
    );
  }

  static TextStyle bold(
    double fontSize, {
    Color color = AppColors.black,
    FontWeight fontWeight = FontWeight.w700,
    String? fontFamily,
  }) {
    return TextStyle(
      fontFamily: fontFamily ?? AppFonts.poppins,
      fontWeight: fontWeight,
      color: color,
      fontSize: fontSize,
    );
  }
}
