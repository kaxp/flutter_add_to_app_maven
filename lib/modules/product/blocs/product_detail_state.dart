part of 'product_detail_bloc.dart';

abstract class ProductDetailState extends Equatable {
  const ProductDetailState({this.data});

  final ProductDetailData? data;
  @override
  List<Object?> get props => [data];
}

class ProductDetailInitial extends ProductDetailState {}

class ProductDetailLoading extends ProductDetailState {}

class ProductDetailLoaded extends ProductDetailState {
  const ProductDetailLoaded({
    required ProductDetailData data,
  }) : super(data: data);
}

class ProductDetailError extends ProductDetailState {
  const ProductDetailError({
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
