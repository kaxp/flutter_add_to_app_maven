import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';

class AppIcons {
  /// place all icons paths here
  static const String _IMAGES_FOLDER_PATH = 'assets/icons/';
  static const String _Animation_FOLDER_PATH = 'assets/animation/';

  static const String _icAppLogo = _IMAGES_FOLDER_PATH + 'ic_app_logo.svg';
  static const String _icAppLoader = _Animation_FOLDER_PATH + 'loading.json';
  static const String _icBackArrow = _IMAGES_FOLDER_PATH + 'ic_back_arrow.svg';
  static const String _icClearSolid =
      _IMAGES_FOLDER_PATH + 'ic_clear_solid.svg';
  static const String _icHomeNavbar =
      _IMAGES_FOLDER_PATH + 'ic_home_navbar.svg';
  static const String _icLeadsNavbar =
      _IMAGES_FOLDER_PATH + 'ic_leads_navbar.svg';
  static const String _icSearch = _IMAGES_FOLDER_PATH + 'ic_search.svg';
  static const String _icShareSolid =
      _IMAGES_FOLDER_PATH + 'ic_share_solid.svg';
  static const String _icTotalLeads =
      _IMAGES_FOLDER_PATH + 'ic_total_leads.svg';
  static const String _icLeadsArrow =
      _IMAGES_FOLDER_PATH + 'ic_leads_arrow.svg';
  static const String _icInfo = _IMAGES_FOLDER_PATH + 'ic_info.svg';
  static const String _icCall = _IMAGES_FOLDER_PATH + 'ic_call.svg';
  static const String _icWhatsapp = _IMAGES_FOLDER_PATH + 'ic_whatsapp.svg';
  static const String _icBsLogo = _IMAGES_FOLDER_PATH + 'ic_bs_logo.svg';
  static const String _icDiamond = _IMAGES_FOLDER_PATH + 'ic_diamond.png';
  static const String _icCheckSolid =
      _IMAGES_FOLDER_PATH + 'ic_check_solid.svg';
  static const String _icAlert = _IMAGES_FOLDER_PATH + 'ic_alert.svg';
  static const String _icArrowTilt = _IMAGES_FOLDER_PATH + 'ic_arrow_tilt.svg';
  static const String _icRaiseQuery =
      _IMAGES_FOLDER_PATH + 'ic_raise_query.svg';
  static const String _icSend = _IMAGES_FOLDER_PATH + 'ic_send.svg';
  static const String _icBot = _IMAGES_FOLDER_PATH + 'ic_bot.svg';
  static const String _icPlus = _IMAGES_FOLDER_PATH + 'ic_plus.svg';
  static const String _icFile = _IMAGES_FOLDER_PATH + 'ic_file.svg';
  static const String _icDownloadCircular =
      _IMAGES_FOLDER_PATH + 'ic_download_circular.svg';
  static const String _icPhone = _IMAGES_FOLDER_PATH + 'phone.svg';
  static const String _icYoutube = _IMAGES_FOLDER_PATH + 'youtube.svg';
  static const String _icEmptyData = _IMAGES_FOLDER_PATH + 'ic_no_customer.svg';

  /// directly create the Lottie images here and use in code
  static LottieBuilder loadingGif() => Lottie.asset(
        _icAppLoader,
        width: 100,
        fit: BoxFit.fitWidth,
      );

  /// directly create the svgIcon here and use in code
  static SvgPicture appLogo() => SvgPicture.asset(_icAppLogo);
  static SvgPicture icBackArrow({double? width}) =>
      SvgPicture.asset(_icBackArrow, width: width);
  static SvgPicture icClearSolid({double? width, Color? color}) =>
      SvgPicture.asset(
        _icClearSolid,
        width: width,
        colorFilter: ColorFilter.mode(
          color ?? Colors.transparent,
          BlendMode.srcIn,
        ),
      );

  static SvgPicture icHomeNavbar() => SvgPicture.asset(_icHomeNavbar);

  static SvgPicture icLeadsNavbar() => SvgPicture.asset(_icLeadsNavbar);

  static SvgPicture icSearch({double? width}) =>
      SvgPicture.asset(_icSearch, width: width);

  static SvgPicture icShareSolid() => SvgPicture.asset(_icShareSolid);

  static SvgPicture icTotalLeads({double? width}) =>
      SvgPicture.asset(_icTotalLeads, width: width);

  static SvgPicture icLeadsArrow({double? width}) => SvgPicture.asset(
        _icLeadsArrow,
        width: width,
      );

  static SvgPicture icInfo({double? width, Color? color}) => SvgPicture.asset(
        _icInfo,
        width: width,
        colorFilter: ColorFilter.mode(
          color ?? Colors.transparent,
          BlendMode.srcIn,
        ),
      );

  static SvgPicture icCall() => SvgPicture.asset(_icCall);

  static SvgPicture icWhatsapp() => SvgPicture.asset(_icWhatsapp);

  static SvgPicture icBsLogo(
          {double? height = 24, double? width, Color? color}) =>
      SvgPicture.asset(
        _icBsLogo,
        width: width,
        height: height,
        // ignore: deprecated_member_use
        color: color,
      );

  static Image icDiamond() => Image.asset(
        _icDiamond,
        height: 16,
        width: 16,
      );

  static SvgPicture icCheckSolid({double? width, Color? color}) =>
      SvgPicture.asset(
        _icCheckSolid,
        width: width,
        colorFilter: ColorFilter.mode(
          color ?? Colors.transparent,
          BlendMode.srcIn,
        ),
      );

  static SvgPicture icAlert({double? width, Color? color}) => SvgPicture.asset(
        _icAlert,
        width: width,
        colorFilter: ColorFilter.mode(
          color ?? Colors.transparent,
          BlendMode.srcIn,
        ),
      );

  static SvgPicture icSend({
    double? width,
  }) =>
      SvgPicture.asset(
        _icSend,
        width: width,
      );
  static SvgPicture icBot({
    double? width,
  }) =>
      SvgPicture.asset(
        _icBot,
        width: width,
      );

  static SvgPicture icPlus({double? width, double? height}) => SvgPicture.asset(
        _icPlus,
        width: width,
        height: height,
      );

  static SvgPicture icArrowTilt() => SvgPicture.asset(_icArrowTilt);

  static SvgPicture icRaiseQuery() => SvgPicture.asset(_icRaiseQuery);
  static SvgPicture icFile({
    double? width,
  }) =>
      SvgPicture.asset(
        _icFile,
        width: width,
      );
  static SvgPicture icDownloadCircular({
    double? width,
  }) =>
      SvgPicture.asset(
        _icDownloadCircular,
        width: width,
      );

  static SvgPicture icPhone(
    double? width,
  ) =>
      SvgPicture.asset(
        _icPhone,
        width: width,
      );

  static SvgPicture icYoutube(double? width) => SvgPicture.asset(
        _icYoutube,
        width: width,
      );

  static SvgPicture icEmptyData(double? width) => SvgPicture.asset(
        _icEmptyData,
        width: width,
      );
}
