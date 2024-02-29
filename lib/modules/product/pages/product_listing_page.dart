import 'dart:async';

import 'package:flutter/services.dart';
import 'package:kapil_add_to_app_flutter/constants/spacing_constants.dart';
import 'package:kapil_add_to_app_flutter/injection_container.dart';
import 'package:kapil_add_to_app_flutter/modules/product/blocs/product_listing_bloc.dart';
import 'package:kapil_add_to_app_flutter/modules/product/widgets/product_categories_widget.dart';
import 'package:kapil_add_to_app_flutter/modules/product/widgets/product_list_widget.dart';
import 'package:kapil_add_to_app_flutter/strings/app_strings.dart';
import 'package:kapil_add_to_app_flutter/theme/assets/app_colors.dart';
import 'package:kapil_add_to_app_flutter/theme/assets/app_icons.dart';
import 'package:kapil_add_to_app_flutter/theme/text_style_factory.dart';
import 'package:kapil_add_to_app_flutter/widgets/custom_appbar.dart';
import 'package:kapil_add_to_app_flutter/widgets/custom_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductListingPage extends StatefulWidget {
  const ProductListingPage({super.key});

  @override
  State<ProductListingPage> createState() => _ProductListingPageState();
}

class _ProductListingPageState extends State<ProductListingPage> {
  final _bloc = sl.get<ProductListingBloc>();
  Timer? _timer;
  final _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _bloc.getProductCategories();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductListingBloc, ProductListingState>(
      bloc: sl<ProductListingBloc>(),
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.pageBackgroundColor,
          appBar: CustomAppBar(
            leading: IconButton(
              onPressed: () {
                SystemChannels.platform.invokeMethod('SystemNavigator.pop');
              },
              icon: AppIcons.icBackArrow(
                width: kSpacingLarge,
              ),
            ),
            title: state is ProductListingSearchEnabled ||
                    _textController.text.isNotEmpty
                ? _buildSearchField(state.selectedCatId)
                : Text(
                    AppStrings.categories,
                  ),
            actions: [
              IconButton(
                onPressed: () {
                  if (state is ProductListingSearchEnabled) {
                    if (_textController.text.isEmpty) {
                      _bloc.onSearchClear();
                      return;
                    }

                    _textController.text = '';
                    // fetch default product listing
                    _bloc.getProductListings(
                      categoryId: state.selectedCatId,
                      searchQuery: '',
                    );
                  } else {
                    _bloc.onSearchIconTap();
                  }
                },
                icon: state is ProductListingSearchEnabled ||
                        _textController.value.text.isNotEmpty
                    ? AppIcons.icClearSolid(
                        width: kSpacingMedium,
                        color: AppColors.black,
                      )
                    : AppIcons.icSearch(
                        width: kSpacingMedium,
                      ),
              ),
            ],
          ),
          body: CustomLoader(
            isLoading: state is ProductListingInitial ||
                state is ProductListingPageLoading,
            child: ListView(
              padding: const EdgeInsets.symmetric(
                vertical: kSpacingMedium,
              ),
              shrinkWrap: true,
              children: [
                ProductCategoriesWidget(
                  categories: state.categories,
                  onTap: (categoryId) {
                    // On changing the category we need to clear the search query
                    _textController.text = '';
                    _bloc.onCategoryTap(
                      categoryId,
                    );
                  },
                  selectedCatIndex: state.selectedCatId,
                ),
                Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Opacity(
                      opacity: state is ProductListingCategoryDataLoading
                          ? 0.4
                          : 1.0,
                      child: ProductListWidget(
                        state: state,
                        products: state.products,
                        creditCardBenefits: state.creditCardBenefits,
                        onTap: (benefitId) =>
                            _bloc.onBenefitFilterTap(benefitId),
                        selectedCcBenefitIds: _bloc.selectedCcBenefitIds,
                      ),
                    ),
                    state is ProductListingCategoryDataLoading
                        ? Center(
                            child: AppIcons.loadingGif(),
                          )
                        : const SizedBox.shrink(),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSearchField(int categoryId) {
    return TextField(
      controller: _textController,
      autofocus: true,
      textAlign: TextAlign.start,
      decoration: InputDecoration(
        hintText: AppStrings.searchByProductOrPincode,
        border: InputBorder.none,
      ),
      style: TextStyleFactory.styleNormal16(
        fontWeight: FontWeight.w400,
        color: AppColors.black,
      ),
      onChanged: (value) => _onQueryChanged(value, categoryId),
    );
  }

  void _onQueryChanged(String query, int categoryId) {
    _debounce(const Duration(milliseconds: 500), () {
      if (query.length > 2)
        _bloc.getProductListings(
          categoryId: categoryId,
          searchQuery: query,
        );
    });
  }

  void _debounce(Duration duration, void Function() callback) {
    if (_timer?.isActive ?? false) _timer!.cancel();
    _timer = Timer(duration, callback);
  }
}
