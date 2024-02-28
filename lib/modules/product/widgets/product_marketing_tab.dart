import 'package:kapil_add_to_app_flutter/constants/spacing_constants.dart';
import 'package:kapil_add_to_app_flutter/theme/assets/app_colors.dart';
import 'package:kapil_add_to_app_flutter/theme/assets/app_icons.dart';
import 'package:kapil_add_to_app_flutter/widgets/card_preview.dart';
import 'package:kapil_add_to_app_flutter/widgets/custom_network_image.dart';
import 'package:kapil_add_to_app_flutter/widgets/no_data_widget.dart';
import 'package:flutter/material.dart';

class ProductMarketingTab extends StatelessWidget {
  const ProductMarketingTab({
    required this.marketingsData,
  });

  final List<String>? marketingsData;

  @override
  Widget build(BuildContext context) {
    return marketingsData!.isNotEmpty
        ? SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              vertical: kSpacingMedium,
            ),
            child: Column(
              children: [
                Visibility(
                  visible: marketingsData!.isNotEmpty ? true : false,
                  child: GestureDetector(
                    onTap: () {
                      _showPreview(context, marketingsData![0]);
                    },
                    child: Container(
                      height: 200.0,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(12),
                        ),
                        child: AspectRatio(
                          aspectRatio: 1.042,
                          child: CustomImage.network(
                            marketingsData![0],
                            fit: BoxFit.fill,
                            errorWidget: UnconstrainedBox(
                              child: AppIcons.icBsLogo(
                                width: 80,
                                height: 80,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: kSpacingMedium,
                ),
                GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1,
                    crossAxisSpacing: kSpacingXMedium,
                    mainAxisSpacing: kSpacingMedium,
                  ),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: marketingsData!.length > 1
                      ? marketingsData!.length - 1
                      : 0,
                  itemBuilder: (context, position) {
                    return GestureDetector(
                      onTap: () {
                        _showPreview(context, marketingsData![position + 1]);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ClipRRect(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(12),
                          ),
                          child: AspectRatio(
                            aspectRatio: 1.042,
                            child: CustomImage.network(
                              marketingsData![position + 1],
                              fit: BoxFit.cover,
                              errorWidget: UnconstrainedBox(
                                child: AppIcons.icBsLogo(
                                  width: 60,
                                  height: 60,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
          )
        : const NoDataWidget();
  }

  void _showPreview(BuildContext context, String image) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => Container(
        padding: EdgeInsets.zero,
        decoration: const BoxDecoration(color: AppColors.white),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: height / width < 1.30 ? width / 10 : 0,
          ),
          child: CardPreview(
            imagePath: image,
          ),
        ),
      ),
    );
  }
}
