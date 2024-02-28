import 'package:kapil_add_to_app_flutter/modules/product/models/product_categories_response.dart';
import 'package:kapil_add_to_app_flutter/modules/product/models/product_detail_request.dart';
import 'package:kapil_add_to_app_flutter/modules/product/models/product_detail_response.dart';
import 'package:kapil_add_to_app_flutter/modules/product/models/product_listing_request.dart';
import 'package:kapil_add_to_app_flutter/modules/product/models/product_listing_response.dart';
import 'package:kapil_add_to_app_flutter/networking/constants/network_constants.dart';
import 'package:kapil_add_to_app_flutter/networking/http_client.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'product_api_client.g.dart';

@RestApi()
abstract class ProductApiClient {
  factory ProductApiClient() {
    return _ProductApiClient(
      defaultHttpClient(),
      baseUrl: NetworkConstants.baseUrl,
    );
  }

  @GET('/product_categories')
  Future<ProductCategoriesResponse> getProductCategories();

  @POST('/product_listing')
  Future<ProductListingResponse> getProductListing({
    @Body() required ProductListingRequest body,
  });

  @POST('/product_details')
  Future<ProductDetailResponse> getProductDetail({
    @Body() required ProductDetailRequest body,
  });
}
