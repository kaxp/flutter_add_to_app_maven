// ignore_for_file: must_be_immutable
import 'dart:io';
import 'dart:ui' as ui;
import 'package:kapil_add_to_app_flutter/constants/radius_constants.dart';
import 'package:kapil_add_to_app_flutter/constants/spacing_constants.dart';
import 'package:kapil_add_to_app_flutter/injection_container.dart';
import 'package:kapil_add_to_app_flutter/strings/app_strings.dart';
import 'package:kapil_add_to_app_flutter/theme/assets/app_colors.dart';
import 'package:kapil_add_to_app_flutter/theme/assets/app_icons.dart';
import 'package:kapil_add_to_app_flutter/theme/text_style_factory.dart';
import 'package:kapil_add_to_app_flutter/widgets/custom_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class CardPreview extends StatelessWidget {
  CardPreview({
    super.key,
    required this.imagePath,
  });

  final String imagePath;
  GlobalKey globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final agentMobile = sdkInitResponse.agentMobile;
    final agentName = sdkInitResponse.agentName;

    return Card(
      color: AppColors.white,
      margin: EdgeInsets.zero,
      elevation: 0,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shadowColor: AppColors.borderColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(0),
          topRight: Radius.circular(0),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RepaintBoundary(
            key: globalKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(maxHeight: height / 1.3),
                  child: CustomImage.network(
                    imagePath,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  height: kSpacingMedium,
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: kSpacingMedium),
                  color: AppColors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: kRadiusXMedium,
                        child: Text((agentName ?? '')[0].toUpperCase()),
                      ),
                      const SizedBox(
                        width: kSpacingMedium,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                agentName ?? '',
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              AppIcons.icPhone(kSpacingMedium),
                              Text(
                                '  +91 $agentMobile',
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: kSpacingMedium,
          ),
          SizedBox(
            width: width - 32,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.black,
                elevation: 1,
                padding: const EdgeInsets.all(kSpacingSmall),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(kRadiusXSmall)),
              ),
              onPressed: () async {
                final file = await capture(context);
                // ignore: deprecated_member_use
                if (file != null) await Share.shareFiles([file.path]);
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.share_sharp,
                size: kSpacingMedium,
                color: AppColors.white,
              ),
              label: Text(
                AppStrings.shareWithCustomer,
                style: TextStyleFactory.styleNormal14(
                  color: AppColors.white,
                  fontFamily: AppFonts.dmSans,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: kSpacingMedium,
          ),
        ],
      ),
    );
  }

  Future<File?> capture(
    BuildContext context, {
    String path = '',
    Duration delay = const Duration(milliseconds: 20),
  }) {
    return Future.delayed(delay, () async {
      try {
        final RenderRepaintBoundary boundary = globalKey.currentContext!
            .findRenderObject() as RenderRepaintBoundary;
        final ui.Image image = await boundary.toImage(
            pixelRatio: MediaQuery.of(context).devicePixelRatio);
        final ByteData? byteData =
            await image.toByteData(format: ui.ImageByteFormat.png);
        final Uint8List pngBytes = byteData!.buffer.asUint8List();
        if (path == '') {
          final directory = (await getApplicationDocumentsDirectory()).path;
          const String fileName = 'Card';
          path = '$directory/$fileName.png';
        }
        final File imgFile = File(path);
        await imgFile.writeAsBytes(pngBytes);
        return imgFile;
      } on Exception {
        if (kDebugMode) {
          print(Exception);
        }
        return null;
      }
    });
  }
}
