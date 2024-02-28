import 'dart:io';
import 'dart:ui' as ui;
import 'package:kapil_add_to_app_flutter/constants/radius_constants.dart';
import 'package:kapil_add_to_app_flutter/constants/spacing_constants.dart';
// import 'package:kapil_add_to_app_flutter/modules/product/models/product_listing_response.dart';
import 'package:kapil_add_to_app_flutter/strings/app_strings.dart';
import 'package:kapil_add_to_app_flutter/theme/assets/app_colors.dart';
import 'package:kapil_add_to_app_flutter/theme/text_style_factory.dart';
import 'package:kapil_add_to_app_flutter/widgets/custom_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class ShareBottomSheet extends StatefulWidget {
  const ShareBottomSheet({
    super.key,
    required this.shareData,
  });

  final dynamic shareData;

  @override
  State<ShareBottomSheet> createState() => _ShareBottomSheetState();
}

class _ShareBottomSheetState extends State<ShareBottomSheet> {
  final _boundryKey = GlobalKey();
  DateTime? _buttonClickTime;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: 240,
        maxHeight: MediaQuery.of(context).size.height * 0.80,
      ),
      child: Card(
        color: AppColors.white,
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(kRadiusMedium),
            topRight: Radius.circular(kRadiusMedium),
          ),
        ),
        child: _getBody(
          context,
          widget.shareData,
        ),
      ),
    );
  }

  Widget _getBody(BuildContext context, dynamic shareData) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RepaintBoundary(
          key: _boundryKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomImage.network(
                shareData.shareImage,
                height: MediaQuery.of(context).size.height / 2.5,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.fill,
              ),
            ],
          ),
        ),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.all(kSpacingSmall),
            child: Scrollbar(
              trackVisibility: true,
              thumbVisibility: true,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Linkify(
                  onOpen: (link) async {
                    if (!await launchUrl(Uri.parse(link.url))) {
                      throw Exception('Could not launch ${link.url}');
                    }
                  },
                  text: _createMessageText(),
                  style: const TextStyle(color: AppColors.black),
                  linkStyle: const TextStyle(color: AppColors.blueTextColor),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kSpacingMedium),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: kSpacingZero,
              backgroundColor: AppColors.buttonPrimaryColor,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(kRadiusXSmall),
                ),
              ),
            ),
            onPressed: () {
              _onShare(context);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.share_rounded,
                  size: kSpacingMedium,
                  color: AppColors.white,
                ),
                const SizedBox(
                  width: kSpacingXxSmall,
                ),
                Text(
                  AppStrings.shareWithCustomer,
                  style: TextStyleFactory.styleNormal14(
                    color: AppColors.white,
                    fontFamily: AppFonts.dmSans,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: kSpacingXSmall,
        )
      ],
    );
  }

  Future? _onShare(BuildContext context) async {
    if (!_checkRedundantClick(DateTime.now())) {
      return Future.delayed(const Duration(milliseconds: 20), () async {
        try {
          final message = _createMessageText();
          final RenderRepaintBoundary boundary = _boundryKey.currentContext!
              .findRenderObject()! as RenderRepaintBoundary;
          final ui.Image image = await boundary.toImage(
              pixelRatio: MediaQuery.of(context).devicePixelRatio);
          final ByteData? byteData =
              await image.toByteData(format: ui.ImageByteFormat.png);
          final Uint8List pngBytes = byteData!.buffer.asUint8List();

          final Directory? directory = Platform.isAndroid
              ? await getExternalStorageDirectory() //FOR ANDROID
              : await getApplicationSupportDirectory(); //FOR iOS
          final String fileName =
              'temp_share_card_${DateTime.now().second}${DateTime.now().millisecond}${DateTime.now().microsecond}';
          if (directory != null) {
            final String path = '${directory.absolute.path}/$fileName.png';
            final File imgFile = File(path);
            await imgFile.writeAsBytes(pngBytes);
            await Share.shareXFiles(
              [XFile(imgFile.path)],
              text: message,
            );
          }
        } catch (exception) {
          if (kDebugMode) {
            debugPrint(exception.toString());
          }
        }
      });
    }
  }

  bool _checkRedundantClick(DateTime currentTime) {
    if (_buttonClickTime == null) {
      _buttonClickTime = currentTime;
      return false;
    }

    if (currentTime.difference(_buttonClickTime!).inSeconds < 2) {
      return true;
    }

    _buttonClickTime = currentTime;
    return false;
  }

  String _createMessageText() {
    String content = '';
    if (widget.shareData.shareContent != null &&
        widget.shareData.shareContent!.isNotEmpty) {
      content += '${widget.shareData.shareContent!} ';
    }
    if (widget.shareData.shareLink.isNotEmpty) {
      content += widget.shareData.shareLink;
    } else {
      if (widget.shareData.shareLink.isNotEmpty) {
        content += widget.shareData.shareLink;
      }
    }

    return content;
  }
}
