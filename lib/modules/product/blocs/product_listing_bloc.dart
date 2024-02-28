import 'package:kapil_add_to_app_flutter/injection_container.dart';
import 'package:kapil_add_to_app_flutter/modules/product/models/product_categories_response.dart';
import 'package:kapil_add_to_app_flutter/modules/product/models/product_listing_response.dart';
import 'package:kapil_add_to_app_flutter/modules/product/repositories/product_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';

part 'product_listing_state.dart';

class ProductListingBloc extends Cubit<ProductListingState> {
  ProductListingBloc() : super(ProductListingInitial());

  final _repo = sl.get<ProductRepo>();
  List<int> selectedCcBenefitIds = [];
  late ProductListings? productListings;

  Future<void> getProductCategories() async {
    try {
      emit(ProductListingPageLoading());

      final result = await _repo.getProductCategories();

      if (result.success ?? false) {
        getProductListings(
          categories: result.data,
          categoryId: result.data[0].categoryId,
        );
      }
    } on DioException catch (error) {
      emit(
        ProductListingCategoryError(
          exception: error,
          // TODO(kaxp) handle the error message properly
          message: error.toString(),
        ),
      );
    }
  }

  Future<void> getProductListings({
    List<ProductCategoriesData>? categories,
    required int categoryId,
    String? searchQuery,
  }) async {
    try {
      if (state is! ProductListingPageLoading) {
        if (state is! ProductListingCategoryDataLoading) {
          emit(ProductListingBodyLoading(
            products: state.products,
            creditCardBenefits: state.creditCardBenefits,
            categories: state.categories,
            selectedCatId: categoryId,
          ));
        }
      }

      final result = await _repo.getProductListings(
        categoryId: categoryId,
        searchQuery: searchQuery ?? "",
      );

      if (result.data != null) {
        productListings = result.data;

        emit(ProductListingLoaded(
          products: productListings!.products,
          creditCardBenefits: productListings!.creditCardBenefits,
          categories: categories ?? state.categories,
          selectedCatId: categoryId,
        ));
      }
    } on DioException catch (error) {
      emit(
        ProductListingCategoryError(
          exception: error,
          // TODO(kaxp) handle the error message properly
          message: error.toString(),
        ),
      );
    }
  }

  void onSearchIconTap() {
    emit(ProductListingSearchEnabled(
      products: state.products,
      creditCardBenefits: state.creditCardBenefits,
      categories: state.categories,
      selectedCatId: state.selectedCatId,
    ));
  }

  void onSearchClear() {
    emit(ProductListingLoaded(
      products: state.products,
      creditCardBenefits: state.creditCardBenefits,
      categories: state.categories,
      selectedCatId: state.selectedCatId,
    ));
  }

  /// This method help to fetch the data of respective category
  /// selected by the user, e.g Categories like Credit Card,
  /// Personal Loan, Bank account, etc.
  void onCategoryTap(int categoryId) {
    // clear the credit card selected benefeits
    selectedCcBenefitIds = [];

    emit(ProductListingCategoryDataLoading(
      products: state.products,
      creditCardBenefits: state.creditCardBenefits,
      categories: state.categories,
      selectedCatId: categoryId,
    ));

    getProductListings(
      categoryId: categoryId,
    );
  }

  /// This method help to filter the credit card data based
  /// on the benefits selected by the use, e.g benefits like
  /// Travel, Lifestyle, Movies, etc.
  void onBenefitFilterTap(int benefitId) {
    if (selectedCcBenefitIds.contains(benefitId)) {
      selectedCcBenefitIds.remove(benefitId);
    } else {
      selectedCcBenefitIds.add(benefitId);
    }

    Set<int> selectedIds = selectedCcBenefitIds.toSet();
    List<ProductListingData> filteredDataByBenefitId;

    if (selectedIds.isEmpty) {
      // If no benefits are selected, include all products
      filteredDataByBenefitId = productListings!.products;
    } else {
      // Filter products where all selected benefit IDs are contained in the product's benefits
      filteredDataByBenefitId = productListings!.products.where((product) {
        return selectedIds.every((id) => product.benefits.contains(id));
      }).toList();
    }

    emit(ProductListingBenefitsLoaded(
      categories: state.categories,
      creditCardBenefits: state.creditCardBenefits,
    ));

    emit(ProductListingLoaded(
      products: filteredDataByBenefitId,
      creditCardBenefits: state.creditCardBenefits,
      categories: state.categories,
      selectedCatId: state.selectedCatId,
    ));
  }
}
