import 'package:autotager/app/core/utils/action_center/action_center.dart';
import 'package:autotager/app/core/utils/helpers/pagination_helper.dart';
import 'package:autotager/app/data/managers/api_manager/products/products_manager.dart';
import 'package:autotager/app/data/model/dtos/api/products_response_dto/product.dart';
import 'package:autotager/app/data/model/dtos/paginated_request_dto.dart';
import 'package:autotager/app/data/model/dtos/paginated_response_dto.dart';
import 'package:autotager/app/data/services/authentication/auth_service.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeController extends GetxController {
  RxBool loading = false.obs;
  RxString email = "".obs;

  RxList<Product> products = <Product>[].obs;
  final int _pageSize = 10;
  RxInt totalRecords = 0.obs;

  final ActionCenter _actionCenter = ActionCenter();
  final AbsProductsApiManager _productsApiManager =
      Get.put(ProductsAPIManager());

  final RefreshController refreshController =
      RefreshController(initialRefresh: true);

  void _resetLoading() async {
    refreshController.refreshCompleted();
    if (totalRecords.value <= products.length) {
      refreshController.loadNoData();
    } else {
      refreshController.loadComplete();
    }
  }

  Future<void> getProducts({bool forceRefresh = false}) async {
    var pagination = PaginationHelper.getNextPagination(
        forceRefresh ? 0 : products.length, _pageSize);
    PaginatedResponseDto<Product>? paginatedResponse;
    var result = await _actionCenter.execute(() async {
      paginatedResponse = await _productsApiManager.getDiscountedProducts(
        requestDto: PaginatedRequestDto(
            pageNumber: pagination.pageNumber, pageSize: pagination.pageSize),
      );
    }, checkConnection: true);
    if (result && paginatedResponse != null) {
      totalRecords.value = paginatedResponse!.total!;
      if (forceRefresh) {
        products.clear();
      }
      products.addAll(paginatedResponse!.items!);
    }
    _resetLoading();
  }

  @override
  void onInit() {
    super.onInit();
    email.value = Get.find<AuthService>().user?.email ?? "";
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void logout() async {
    loading.value = true;
    await Get.find<AuthService>().signOut();
    loading.value = false;
  }
}
