import 'package:kapil_add_to_app_flutter/injection_container.dart';
import 'package:kapil_add_to_app_flutter/modules/product/models/product_detail_response.dart';
import 'package:kapil_add_to_app_flutter/modules/product/repositories/product_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';

part 'product_detail_state.dart';

class ProductDetailBloc extends Cubit<ProductDetailState> {
  ProductDetailBloc() : super(ProductDetailInitial());

  final _repo = sl.get<ProductRepo>();

  Future<void> getProductDetail({required int productId}) async {
    try {
      emit(ProductDetailLoading());

      final result = await _repo.getProductDetail(
        productId: productId,
      );

      if (result.success == true) {
        emit(ProductDetailLoaded(data: result.data));
      }
    } on DioException catch (error) {
      emit(
        ProductDetailError(
          exception: error,
          // TODO(kaxp) handle the error message properly
          message: error.toString(),
        ),
      );
    }
  }
}
