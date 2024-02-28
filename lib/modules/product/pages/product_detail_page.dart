import 'package:kapil_add_to_app_flutter/constants/radius_constants.dart';
import 'package:kapil_add_to_app_flutter/constants/spacing_constants.dart';
import 'package:kapil_add_to_app_flutter/injection_container.dart';
import 'package:kapil_add_to_app_flutter/modules/product/blocs/product_detail_bloc.dart';
import 'package:kapil_add_to_app_flutter/modules/product/models/product_detail_response.dart';
import 'package:kapil_add_to_app_flutter/modules/product/widgets/product_detail_bottom_navbar.dart';
import 'package:kapil_add_to_app_flutter/modules/product/widgets/product_marketing_tab.dart';
import 'package:kapil_add_to_app_flutter/strings/app_strings.dart';
import 'package:kapil_add_to_app_flutter/theme/assets/app_colors.dart';
import 'package:kapil_add_to_app_flutter/theme/assets/app_icons.dart';
import 'package:kapil_add_to_app_flutter/theme/text_style_factory.dart';
import 'package:kapil_add_to_app_flutter/widgets/custom_appbar.dart';
import 'package:kapil_add_to_app_flutter/widgets/custom_loader.dart';
import 'package:kapil_add_to_app_flutter/modules/product/widgets/product_detail_tab.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({
    super.key,
    required this.productId,
  });

  final int productId;

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage>
    with SingleTickerProviderStateMixin {
  final _bloc = sl.get<ProductDetailBloc>();
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    _bloc.getProductDetail(productId: widget.productId);
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductDetailBloc, ProductDetailState>(
      bloc: _bloc,
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.pageBackgroundColor,
          appBar: CustomAppBar(
            title: Text(
              AppStrings.productDetail,
            ),
          ),
          bottomNavigationBar: state.data != null
              ? ProductDetailBottomNavbar(
                  productDetailData: state.data!,
                )
              : const SizedBox.shrink(),
          body: state is ProductDetailLoading
              ? const CustomLoader(
                  isLoading: true,
                  child: SizedBox.shrink(),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: kSpacingMedium,
                  ),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: kSpacingMedium,
                      ),
                      state.data != null
                          ? _BuildCardHeader(
                              product: state.data!,
                            )
                          : const SizedBox.shrink(),
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
                        height: kSpacingXMedium,
                      ),
                      SizedBox(
                        height: 46,
                        child: TabBar(
                          controller: tabController,
                          labelColor: AppColors.white,
                          labelStyle: TextStyleFactory.styleNormal14(
                            fontFamily: AppFonts.dmSans,
                          ),
                          unselectedLabelColor: AppColors.black,
                          unselectedLabelStyle: TextStyleFactory.styleNormal14(
                            fontFamily: AppFonts.dmSans,
                          ),
                          indicatorColor: AppColors.buttonPrimaryColor,
                          indicator: BoxDecoration(
                            color: Colors
                                .black, // Background color of selected tab
                            border:
                                Border.all(color: Colors.black), // Black border
                          ),
                          indicatorSize: TabBarIndicatorSize.tab,
                          indicatorPadding: EdgeInsets.zero,
                          labelPadding: const EdgeInsets.fromLTRB(
                            0,
                            kSpacingXxSmall,
                            0,
                            kSpacingXxSmall,
                          ),
                          tabs: const [
                            Tab(
                              text: 'Details',
                            ),
                            Tab(
                              text: 'Marketing',
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: TabBarView(
                          controller: tabController,
                          children: [
                            ProductDetailTab(
                              productDetail: state.data?.tabs.details,
                            ),
                            ProductMarketingTab(
                              marketingsData: state.data?.tabs.marketing,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
        );
      },
    );
  }
}

class _BuildCardHeader extends StatelessWidget {
  const _BuildCardHeader({
    required this.product,
  });

  final ProductDetailData product;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          child: CachedNetworkImage(
            imageUrl: product.productLogo ?? '',
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
                product.productTitle ?? '',
                style: TextStyleFactory.styleBold16(),
              ),
              Text(
                product.productSubTitle ?? '',
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

extension StringExtensions on String {
  String? get videoId {
    bool isValidId(String? id) => RegExp(r'^[_\-a-zA-Z\d]{11}$').hasMatch(id!);

    Uri uri;
    try {
      uri = Uri.parse(this);
    } catch (e) {
      return null;
    }
    if (!['https', 'http'].contains(uri.scheme)) {
      return null;
    }

    if (['youtube.com', 'www.youtube.com', 'm.youtube.com']
            .contains(uri.host) &&
        uri.pathSegments.isNotEmpty &&
        uri.pathSegments.first == 'watch' &&
        uri.queryParameters.containsKey('v')) {
      final videoId = uri.queryParameters['v'];
      return isValidId(videoId) ? videoId : null;
    }

    // youtu.be/xxxxxxxxxxx
    if (uri.host == 'youtu.be' && uri.pathSegments.isNotEmpty) {
      final videoId = uri.pathSegments.first;
      return isValidId(videoId) ? videoId : null;
    }

    return null;
  }

  String get thumbnail {
    return 'https://img.youtube.com/vi/$videoId/mqdefault.jpg';
  }
}
