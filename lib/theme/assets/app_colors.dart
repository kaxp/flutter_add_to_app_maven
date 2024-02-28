import 'package:flutter/material.dart';

class AppColors {
  static const Color buttonPrimaryColor = Color(0xFF0C0C0C);
  static const Color buttonPrimaryDisabledColor = Color(0xFF676D75);
  static const Color buttonSecondaryColor = Color(0xFFE0EEFF);
  static const Color pageBackgroundColor = Color(0xFFF9F9F9);
  static const Color bottomSheetHeaderBgColor = Color(0xFF16242F);
  static const Color black54 = Color(0xFF757575);
  static const Color black = Color(0xFF000000);
  static const Color blackLight = Color(0xFF28272A);
  static const Color white = Color(0xFFFFFFFF);
  static const Color greyLightSubtitleColor = Color(0xFF6D6D6D);
  static const Color greySubtitleColor = Color(0xFF6C6363);
  static const Color greyTextFieldColor = Color(0xFF666666);
  static const Color greyBorderColor = Color(0xFFE3E3E3);
  static const Color borderColor = Color(0xFFCDCDCD);
  static const Color borderLightColor = Color(0xFFDADADA);
  static const Color greyBgUserComment = Color(0xFFF2F4F5);
  static const Color selectedBorderColor = Color(0xFF0C0C0C);
  static const Color blueTextColor = Color(0xFF0070F6);
  static const Color blueBgColorTop = Color(0xFFF1F5FA);
  static const Color blueBgColorBottom = Color(0xFFF2F8FF);
  static const Color greyBackgroundColor = Color(0xFFF2F2F2);
  static const Color greyColor = Color(0xFFF4F4F4);
  static const Color skyBlueDarkColor = Color(0xFF36565E);
  static const Color yellowTextColor = Color(0xFF8C6600);
  static const Color yellowBgColor = Color(0xFFEEAF00);

  //Leads color
  static const Color yellowTextColorPending = Color(0xFFA36E20);
  static const Color yellowBgColorPending = Color(0xFFFFDBA5);
  static const Color redTextColorExpired = Color(0xFFCE0000);
  static const Color redBgColorExpired = Color(0xFFFFDBDB);
  static const Color skyBlueTextColorActionRequired = Color(0xFF0C7A88);
  static const Color skyBlueBgColorActionRequired = Color(0xFFD8FBFF);
  static const Color greenTextColorSuccess = Color(0xFF08862B);
  static const Color greenBgColorSuccess = Color(0xFFD7FFE2);
  static const Color greenBorderColor = Color(0xFF49D49D);
  static const Color transparent = Colors.transparent;

  static const Gradient dividerGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [white, buttonPrimaryDisabledColor, white],
  );
}
