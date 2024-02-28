import 'package:kapil_add_to_app_flutter/theme/assets/app_icons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';

class CustomImage {
  static Widget network(
    String? url, {
    BoxFit? fit,
    Color? color,
    double? width,
    double? height,
    Widget? errorWidget,
    Key? key,
  }) {
    return url.toString().endsWith('.svg')
        ? SvgPicture.network(
            url!,
            width: width,
            height: height,
            fit: fit ?? BoxFit.contain,
            colorFilter: color != null
                ? ColorFilter.mode(
                    color,
                    BlendMode.srcIn,
                  )
                : null,
            placeholderBuilder: (_) => Center(
              child: SizedBox(
                height: height,
                width: width,
                child: Center(
                  child: AppIcons.loadingGif(),
                ),
              ),
            ),
          )
        : (url.toString().endsWith('.json') || url.toString().endsWith('.txt'))
            ? Lottie.network(
                url ?? '',
                height: height,
                width: width,
                fit: fit,
              )
            : CachedNetworkImage(
                key: key,
                imageUrl: url ?? '',
                fit: fit,
                width: width,
                height: height,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    Center(
                  child: SizedBox(
                    height: 25,
                    width: 25,
                    child: Center(
                      child: AppIcons.loadingGif(),
                    ),
                  ),
                ),
                errorWidget: (context, url, error) =>
                    errorWidget ??
                    UnconstrainedBox(
                      child: AppIcons.icBsLogo(
                        width: 100,
                        height: 100,
                      ),
                    ),
              );
  }
}
