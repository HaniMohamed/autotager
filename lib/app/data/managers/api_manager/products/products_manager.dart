import 'dart:convert';

import 'package:autotager/app/core/values/common_urls.dart';
import 'package:autotager/app/data/enums.dart';
import 'package:autotager/app/data/model/dtos/api/products_response_dto/product.dart';
import 'package:autotager/app/data/model/dtos/paginated_request_dto.dart';
import 'package:autotager/app/data/model/dtos/paginated_response_dto.dart';
import 'package:autotager/app/data/model/login_response.dart';
import 'package:autotager/app/data/model/user.dart';
import 'package:autotager/app/data/services/http/http_service.dart';
import 'package:get/get.dart';

class ProductsAPIManager extends AbsProductsApiManager {
  String get baseUrl =>
      CommonUrls.storeServerUrl + '/shop-api/taxon-products/by-slug';

  @override
  RxBool inProgress = RxBool(false);

  @override
  Future<PaginatedResponseDto<Product>?> getDiscountedProducts(
      {required PaginatedRequestDto requestDto}) async {
    Uri uri = Uri.parse(baseUrl + '/sales-discounts');
    uri = uri.replace(queryParameters: requestDto.toMap());

    inProgress.value = true;

    var response = await Get.find<AbsHttpService>().sendRequest(
      uri,
      HttpMethod.get,
    );

    if (response!.statusCode >= 200 && response.statusCode < 300) {
      inProgress.value = false;

      var map = json.decode(response.body);
      return PaginatedResponseDto.fromMap(map, (p0) => Product.fromMap(p0));
    }
    inProgress.value = false;
    return null;
  }
}

abstract class AbsProductsApiManager {
  late RxBool inProgress;

  Future<PaginatedResponseDto<Product>?> getDiscountedProducts(
      {required PaginatedRequestDto requestDto});
}
