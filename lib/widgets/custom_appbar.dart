import 'package:kapil_add_to_app_flutter/constants/spacing_constants.dart';
import 'package:kapil_add_to_app_flutter/theme/assets/app_colors.dart';
import 'package:kapil_add_to_app_flutter/theme/assets/app_icons.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    Key? key,
    this.title,
    this.isCenter,
    this.actions,
    this.leading,
    this.onLeadingTap,
    this.backgroundColor = AppColors.white,
  }) : super(key: key);

  final Widget? leading;
  final Widget? title;
  final Color? backgroundColor;
  final List<Widget>? actions;
  final bool? isCenter;
  final VoidCallback? onLeadingTap;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: leading ??
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: AppIcons.icBackArrow(
              width: kSpacingLarge,
            ),
          ),
      backgroundColor: backgroundColor,
      title: title,
      actions: actions,
      centerTitle: isCenter ?? false,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
