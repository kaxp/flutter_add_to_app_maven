import 'package:kapil_add_to_app_flutter/theme/assets/app_icons.dart';
import 'package:kapil_add_to_app_flutter/constants/spacing_constants.dart';
import 'package:flutter/material.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({
    super.key,
    required this.child,
    required this.isLoading,
    this.message = 'Wait a moment...',
    this.opacity = 1.0,
  });

  final Widget child;
  final bool isLoading;
  final String message;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          Opacity(
            opacity: opacity,
            child: const ModalBarrier(
              dismissible: false,
              color: Colors.white,
            ),
          ),
        if (isLoading)
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppIcons.loadingGif(),
                const SizedBox(height: kSpacingXLarge),
                Text(
                  message,
                  textScaler: const TextScaler.linear(1.4),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
