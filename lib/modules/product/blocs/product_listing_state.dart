part of 'product_listing_bloc.dart';

abstract class ProductListingState extends Equatable {
  const ProductListingState({
    this.products = const [],
    this.filterByBenefitProducts = const [],
    this.creditCardBenefits = const [],
    this.categories = const [],
    this.selectedCatId = 3,
  });

  final List<ProductListingData> products;
  final List<ProductListingData> filterByBenefitProducts;
  final List<CreditCardBenefits> creditCardBenefits;
  final List<ProductCategoriesData> categories;
  final int selectedCatId;

  @override
  List<Object?> get props => [
        products,
        creditCardBenefits,
        categories,
        selectedCatId,
      ];
}

class ProductListingInitial extends ProductListingState {}

class ProductListingPageLoading extends ProductListingState {}

class ProductListingBodyLoading extends ProductListingState {
  const ProductListingBodyLoading({
    required List<ProductListingData> products,
    required List<CreditCardBenefits> creditCardBenefits,
    required List<ProductCategoriesData> categories,
    required int selectedCatId,
  }) : super(
          products: products,
          creditCardBenefits: creditCardBenefits,
          categories: categories,
          selectedCatId: selectedCatId,
        );
}

class ProductListingLoaded extends ProductListingState {
  const ProductListingLoaded({
    required List<ProductListingData> products,
    required List<CreditCardBenefits> creditCardBenefits,
    required List<ProductCategoriesData> categories,
    required int selectedCatId,
  }) : super(
          products: products,
          creditCardBenefits: creditCardBenefits,
          categories: categories,
          selectedCatId: selectedCatId,
        );
}

class ProductListingBenefitsLoaded extends ProductListingState {
  const ProductListingBenefitsLoaded({
    required List<ProductCategoriesData> categories,
    required List<CreditCardBenefits> creditCardBenefits,
  }) : super(
          creditCardBenefits: creditCardBenefits,
          categories: categories,
        );
}

class ProductListingEmpty extends ProductListingState {}

class ProductListingError extends ProductListingState {}

class ProductListingSearchEnabled extends ProductListingState {
  const ProductListingSearchEnabled({
    required List<ProductListingData> products,
    required List<CreditCardBenefits> creditCardBenefits,
    required List<ProductCategoriesData> categories,
    required int selectedCatId,
  }) : super(
          products: products,
          creditCardBenefits: creditCardBenefits,
          categories: categories,
          selectedCatId: selectedCatId,
        );
}

class ProductListingCategoryDataLoading extends ProductListingState {
  const ProductListingCategoryDataLoading({
    required List<ProductListingData> products,
    required List<CreditCardBenefits> creditCardBenefits,
    required List<ProductCategoriesData> categories,
    required int selectedCatId,
  }) : super(
          products: products,
          creditCardBenefits: creditCardBenefits,
          categories: categories,
          selectedCatId: selectedCatId,
        );
}

class ProductListingCategoryError extends ProductListingState {
  const ProductListingCategoryError({
    required this.exception,
    required this.message,
  });

  final Object? exception;
  final String message;

  @override
  List<Object?> get props => [
        exception,
        message,
        ...super.props,
      ];
}
