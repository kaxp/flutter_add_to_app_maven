import 'package:kapil_add_to_app_flutter/theme/assets/app_icons.dart';
import 'package:flutter/material.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: Get.height * .7,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        // crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            height: 56,
          ),
          AppIcons.icEmptyData(220),
          Container(
            height: 36,
          ),
          const Text(
            'No Data Found',
          ),
        ],
      ),
    );
  }
}
