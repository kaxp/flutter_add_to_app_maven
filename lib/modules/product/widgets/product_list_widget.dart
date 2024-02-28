import 'package:kapil_add_to_app_flutter/constants/radius_constants.dart';
import 'package:kapil_add_to_app_flutter/constants/spacing_constants.dart';
import 'package:kapil_add_to_app_flutter/modules/product/blocs/product_listing_bloc.dart';
import 'package:kapil_add_to_app_flutter/modules/product/pages/product_detail_page.dart';
import 'package:kapil_add_to_app_flutter/widgets/no_data_widget.dart';
import 'package:kapil_add_to_app_flutter/widgets/share_bottomsheet.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:kapil_add_to_app_flutter/modules/product/models/product_listing_response.dart';
import 'package:kapil_add_to_app_flutter/strings/app_strings.dart';
import 'package:kapil_add_to_app_flutter/theme/assets/app_colors.dart';
import 'package:kapil_add_to_app_flutter/theme/assets/app_icons.dart';
import 'package:kapil_add_to_app_flutter/theme/text_style_factory.dart';
import 'package:flutter/material.dart';

class ProductListWidget extends StatelessWidget {
  const ProductListWidget({
    required this.products,
    required this.creditCardBenefits,
    required this.onTap,
    required this.selectedCcBenefitIds,
    super.key,
    required this.state,
  });

  final List<ProductListingData> products;
  final List<CreditCardBenefits> creditCardBenefits;
  final Function(int) onTap;
  final List<int> selectedCcBenefitIds;
  final ProductListingState state;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: kSpacingXMedium,
        ),
        Visibility(
          visible: creditCardBenefits.isNotEmpty,
          child: Padding(
            padding: const EdgeInsets.only(
              bottom: kSpacingXMedium,
            ),
            child: state is ProductListingBenefitsLoaded ||
                    state is ProductListingLoaded
                ? _BuildCreditCardBenefitsWidget(
                    benefits: creditCardBenefits,
                    selectedCcBenefitIds: selectedCcBenefitIds,
                    onTap: onTap,
                  )
                : Container(),
          ),
        ),

        // Listview for product cards
        products.isNotEmpty
            ? ListView.separated(
                padding: const EdgeInsets.symmetric(
                  horizontal: kSpacingMedium,
                ),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailPage(
                            productId: product.productId,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(
                            kRadiusMedium,
                          ),
                        ),
                        border: Border.all(
                          color: AppColors.borderColor,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(
                          kSpacingMedium,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            _BuildCardHeader(
                              product: product,
                            ),
                            const SizedBox(
                              height: kSpacingMedium,
                            ),
                            Container(
                              height: 2,
                              margin: const EdgeInsets.symmetric(
                                horizontal: kSpacingXxLarge,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  kRadiusLarge,
                                ),
                                gradient: const LinearGradient(
                                  begin: Alignment.centerRight,
                                  end: Alignment.centerLeft,
                                  colors: [
                                    AppColors.white,
                                    AppColors.borderColor,
                                    AppColors.white,
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: kSpacingMedium,
                            ),
                            Visibility(
                              visible: product.features.isNotEmpty,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    bottom: kSpacingMedium),
                                child:
                                    _BuildCardBody(features: product.features),
                              ),
                            ),
                            _BuildCardFooter(
                              product: product,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(
                  height: kSpacingMedium,
                ),
              )
            : const Padding(
                padding: EdgeInsets.only(top: kSpacing70),
                child: NoDataWidget(),
              ),
      ],
    );
  }
}

class _BuildCreditCardBenefitsWidget extends StatelessWidget {
  const _BuildCreditCardBenefitsWidget({
    required this.benefits,
    required this.selectedCcBenefitIds,
    required this.onTap,
  });

  final List<CreditCardBenefits> benefits;
  final List<int> selectedCcBenefitIds;
  final Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: kSpacingXLarge,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(
          horizontal: kSpacingMedium,
        ),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: benefits.length,
        itemBuilder: (context, index) {
          final benefitData = benefits[index];
          final isSelected = selectedCcBenefitIds.contains(benefitData.id);

          return GestureDetector(
            onTap: () => onTap(benefitData.id),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.white,
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
                horizontal: kSpacingMedium,
                vertical: kSpacingXxSmall,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    benefitData.title,
                    style: TextStyleFactory.styleNormal14(
                      fontFamily: AppFonts.dmSans,
                      color: AppColors.black,
                    ),
                  ),
                  Visibility(
                    visible: isSelected,
                    child: Padding(
                      padding: const EdgeInsets.only(left: kSpacingSmall),
                      child: AppIcons.icClearSolid(
                        width: kSpacingSmall,
                        color: AppColors.black,
                      ),
                    ),
                  ),
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

class _BuildCardHeader extends StatelessWidget {
  const _BuildCardHeader({
    required this.product,
  });

  final ProductListingData product;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          child: CachedNetworkImage(
            imageUrl: product.productLogo,
            height: kSpacing50,
            width: kSpacing50,
            errorWidget: (_, __, ___) => Center(
              child: AppIcons.icBsLogo(
                height: kSpacingLarge,
                width: kSpacingLarge,
              ),
            ),
          ),
        ),
        const SizedBox(
          width: kSpacingMedium,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                product.productTitle,
                style: TextStyleFactory.styleBold16(),
              ),
              Text(
                product.productSubTitle,
                style: TextStyleFactory.styleNormal12(
                    color: AppColors.greySubtitleColor),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class _BuildCardBody extends StatelessWidget {
  const _BuildCardBody({
    required this.features,
  });

  final List<String> features;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          alignment: WrapAlignment.start,
          spacing: kSpacingMedium,
          runSpacing: kSpacingXSmall,
          children: features.map((e) {
            return RichText(
              textAlign: TextAlign.start,
              text: TextSpan(children: [
                WidgetSpan(
                  child: AppIcons.icDiamond(),
                ),
                const WidgetSpan(
                  child: SizedBox(width: kSpacingXxSmall),
                ),
                TextSpan(
                  text: e.toString().trim(),
                  style: TextStyleFactory.styleNormal10(),
                ),
              ]),
            );
          }).toList(growable: false),
        ),
        const SizedBox(
          height: kSpacingMedium,
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            vertical: kSpacingXSmall,
          ),
          decoration: const BoxDecoration(
            color: AppColors.greyBackgroundColor,
            borderRadius: BorderRadius.all(
              Radius.circular(
                kRadiusXSmall,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    AppStrings.annualFee,
                    style: TextStyleFactory.styleBold14(
                      fontFamily: AppFonts.dmSans,
                    ),
                  ),
                  Text(
                    '\$200',
                    style: TextStyleFactory.styleNormal12(
                      fontFamily: AppFonts.dmSans,
                    ),
                  ),
                ],
              ),
              Container(
                width: 1,
                height: kSpacingLarge,
                color: AppColors.borderColor,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    AppStrings.joiningFee,
                    style: TextStyleFactory.styleBold14(
                      fontFamily: AppFonts.dmSans,
                    ),
                  ),
                  Text(
                    '\$200',
                    style: TextStyleFactory.styleNormal12(
                      fontFamily: AppFonts.dmSans,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _BuildCardFooter extends StatelessWidget {
  const _BuildCardFooter({
    required this.product,
  });

  final ProductListingData product;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Visibility(
          visible: product.earnUpto != null,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: kSpacingZero,
              backgroundColor: AppColors.buttonSecondaryColor,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(kRadiusXSmall),
                ),
              ),
            ),
            onPressed: () {},
            child: Text(
              product.earnUpto ?? '',
              style: TextStyleFactory.styleNormal12(
                color: AppColors.blueTextColor,
                fontFamily: AppFonts.dmSans,
              ),
            ),
          ),
        ),
        // TODO(kaxp): ask if we need to increase the width when earnUpto is null.
        Expanded(
          flex: product.earnUpto != null ? 0 : 1,
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
                      shareData: product.shareData,
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
              product.earnUpto != null
                  ? AppStrings.share
                  : AppStrings.shareWithCustomer,
              style: TextStyleFactory.styleNormal14(
                color: AppColors.white,
                fontFamily: AppFonts.dmSans,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
