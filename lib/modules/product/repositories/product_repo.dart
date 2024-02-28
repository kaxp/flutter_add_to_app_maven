import 'package:kapil_add_to_app_flutter/modules/product/models/product_categories_response.dart';
import 'package:kapil_add_to_app_flutter/modules/product/models/product_detail_request.dart';
import 'package:kapil_add_to_app_flutter/modules/product/models/product_detail_response.dart';
import 'package:kapil_add_to_app_flutter/modules/product/models/product_listing_request.dart';
import 'package:kapil_add_to_app_flutter/modules/product/models/product_listing_response.dart';
import 'package:kapil_add_to_app_flutter/networking/retrofit/product_api_client.dart';

class ProductRepo {
  final ProductApiClient _productApiClient = ProductApiClient();

  Future<ProductCategoriesResponse> getProductCategories() async {
    return _productApiClient.getProductCategories();
  }

  Future<ProductListingResponse> getProductListings({
    required String searchQuery,
    required int categoryId,
  }) async {
    final requestBody = ProductListingRequest(
      categoryId: categoryId,
      searchString: searchQuery,
    );

    return _productApiClient.getProductListing(
      body: requestBody,
    );
  }

  Future<ProductDetailResponse> getProductDetail(
      {required int productId}) async {
    final ProductDetailRequest bodyParams = ProductDetailRequest(
      productId: productId,
    );

    return _productApiClient.getProductDetail(
      body: bodyParams,
    );
  }
}
