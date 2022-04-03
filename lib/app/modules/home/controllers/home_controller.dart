import 'package:autotager/app/core/utils/action_center/action_center.dart';
import 'package:autotager/app/core/utils/helpers/pagination_helper.dart';
import 'package:autotager/app/data/managers/api_manager/authentication/authentication_manager.dart';
import 'package:autotager/app/data/managers/api_manager/products/products_manager.dart';
import 'package:autotager/app/data/model/dtos/api/products_response_dto/product.dart';
import 'package:autotager/app/data/model/dtos/paginated_request_dto.dart';
import 'package:autotager/app/data/services/authentication/auth_service.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxBool loading = false.obs;
  RxString email = "".obs;

  RxList<Product> products = <Product>[].obs;
  final int _pageSize = 10;

  final ActionCenter _actionCenter = ActionCenter();
  final AbsProductsApiManager _productsApiManager =
      Get.put(ProductsAPIManager());

  @override
  void onInit() {
    super.onInit();
    email.value = Get.find<AuthService>().user?.email ?? "";
  }

  @override
  void onReady() {
    super.onReady();
  }

  getProducts({bool forceRefresh = false}) async {
    var pagination = PaginationHelper.getNextPagination(
        forceRefresh ? 0 : products.length, _pageSize);

    await _actionCenter.execute(() async {
      _productsApiManager
          .getDiscountedProducts(
        requestDto: PaginatedRequestDto(
            pageNumber: pagination.pageNumber, pageSize: pagination.pageSize),
      )
          .then((paginatedResponse) {
        if (paginatedResponse != null) {
          if (forceRefresh) {
            products.clear();
          }
          products.addAll(paginatedResponse.items!);
        }
      });
    });
  }

  @override
  void onClose() {}

  void logout() async {
    loading.value = true;
    await Get.find<AuthService>().signOut();
    loading.value = false;
  }
}
