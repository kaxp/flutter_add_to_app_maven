import 'package:kapil_add_to_app_flutter/constants/radius_constants.dart';
import 'package:kapil_add_to_app_flutter/constants/spacing_constants.dart';
import 'package:kapil_add_to_app_flutter/modules/product/models/product_detail_response.dart';
import 'package:kapil_add_to_app_flutter/strings/app_strings.dart';
import 'package:kapil_add_to_app_flutter/theme/assets/app_colors.dart';
import 'package:kapil_add_to_app_flutter/theme/text_style_factory.dart';
import 'package:kapil_add_to_app_flutter/widgets/share_bottomsheet.dart';
import 'package:flutter/material.dart';

class ProductDetailBottomNavbar extends StatelessWidget {
  const ProductDetailBottomNavbar({
    super.key,
    required this.productDetailData,
  });

  final ProductDetailData productDetailData;

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Container(
        decoration: const BoxDecoration(
          color: AppColors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: AppColors.black,
              blurRadius: 10,
              offset: Offset(0.0, 10.0),
            )
          ],
        ),
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(
          horizontal: kSpacingMedium,
          vertical: kSpacingXSmall,
        ),
        child: Row(
          children: [
            // Earn Upto widget
            Visibility(
              visible: productDetailData.earnUptoValue != null,
              child: Padding(
                padding: const EdgeInsets.only(right: kSpacingMedium),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      productDetailData.earnUptoKey ?? '',
                      style: TextStyleFactory.styleNormal14(
                        color: AppColors.black,
                        fontFamily: AppFonts.dmSans,
                      ),
                    ),
                    Text(
                      productDetailData.earnUptoValue ?? '',
                      style: TextStyleFactory.styleBold20(
                        color: AppColors.black,
                        fontFamily: AppFonts.dmSans,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Share button
            Expanded(
              child: ElevatedButton.icon(
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
                  showModalBottomSheet<dynamic>(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: AppColors.black,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(kRadiusMedium),
                      ),
                    ),
                    builder: (context) => Wrap(
                      children: [
                        ShareBottomSheet(
                          shareData: productDetailData.shareData,
                        )
                      ],
                    ),
                  );
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
          ],
        ),
      );
    });
  }
}
