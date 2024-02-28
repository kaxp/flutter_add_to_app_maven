import 'package:kapil_add_to_app_flutter/constants/radius_constants.dart';
import 'package:kapil_add_to_app_flutter/constants/spacing_constants.dart';
import 'package:kapil_add_to_app_flutter/modules/product/models/product_categories_response.dart';
import 'package:kapil_add_to_app_flutter/theme/assets/app_colors.dart';
import 'package:kapil_add_to_app_flutter/theme/assets/app_icons.dart';
import 'package:kapil_add_to_app_flutter/theme/text_style_factory.dart';
import 'package:kapil_add_to_app_flutter/widgets/custom_network_image.dart';
import 'package:flutter/material.dart';

class ProductCategoriesWidget extends StatelessWidget {
  const ProductCategoriesWidget({
    required this.categories,
    required this.onTap,
    required this.selectedCatIndex,
    super.key,
  });

  final List<ProductCategoriesData> categories;
  final Function(int) onTap;
  final int selectedCatIndex;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: kSpacing60,
      child: ListView.separated(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(
          horizontal: kSpacingMedium,
        ),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = selectedCatIndex == categories[index].categoryId;

          return GestureDetector(
            onTap: () => onTap(
              category.categoryId,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: isSelected ? AppColors.black : AppColors.white,
                borderRadius: const BorderRadius.all(
                  Radius.circular(
                    kRadiusMedium,
                  ),
                ),
                border: Border.all(
                  color: isSelected ? AppColors.black : AppColors.borderColor,
                ),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: kSpacingSmall,
                vertical: kSpacingXSmall,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomImage.network(
                    category.categoryIcon,
                    height: 24,
                    width: 24,
                    color: isSelected ? AppColors.white : AppColors.black,
                    fit: BoxFit.fill,
                    errorWidget: Center(
                      child: AppIcons.icBsLogo(
                        color: isSelected ? AppColors.white : AppColors.black,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: kSpacingSmall,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        category.categoryName,
                        style: TextStyleFactory.styleNormal14(
                          color: isSelected ? AppColors.white : AppColors.black,
                        ),
                      ),
                      Visibility(
                        visible: category.earnUpto != null,
                        child: Text(
                          category.earnUpto ?? '',
                          style: TextStyleFactory.styleNormal12(
                            color: isSelected
                                ? AppColors.white
                                : AppColors.blueTextColor,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(
          width: kSpacingSmall,
        ),
      ),
    );
  }
}
