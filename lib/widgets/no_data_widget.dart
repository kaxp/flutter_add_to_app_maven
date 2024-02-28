import 'package:kapil_add_to_app_flutter/theme/assets/app_icons.dart';
import 'package:flutter/material.dart';

class NoDataWidget extends StatelessWidget {
  const NoDataWidget({
    super.key,
    this.title = 'Sorry no data found',
  });

  final String? title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppIcons.icEmptyData(220),
        const SizedBox(height: 24),
        Text(
          title!,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
