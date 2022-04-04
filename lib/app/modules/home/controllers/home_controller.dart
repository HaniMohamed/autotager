import 'package:autotager/app/core/utils/action_center/action_center.dart';
import 'package:autotager/app/core/utils/helpers/pagination_helper.dart';
import 'package:autotager/app/core/values/app_colors.dart';
import 'package:autotager/app/data/enums.dart';
import 'package:autotager/app/data/managers/api_manager/products/products_manager.dart';
import 'package:autotager/app/data/managers/cart_manager/abs_cart_manager.dart';
import 'package:autotager/app/data/managers/cart_manager/order_cart_manager.dart';
import 'package:autotager/app/data/managers/cart_manager/wishlist_cart_manager.dart';
import 'package:autotager/app/data/model/dtos/api/products_response_dto/product.dart';
import 'package:autotager/app/data/model/dtos/paginated_request_dto.dart';
import 'package:autotager/app/data/model/dtos/paginated_response_dto.dart';
import 'package:autotager/app/data/services/authentication/auth_service.dart';
import 'package:flutter/material.dart';
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

  final RefreshController productsRefreshController =
      RefreshController(initialRefresh: true);

  final RefreshController orderCartRefreshController =
      RefreshController(initialRefresh: true);

  final RefreshController wishlistCartRefreshController =
      RefreshController(initialRefresh: true);

  RxInt selectedTabIndex = 0.obs;

  void onTabTapped(int value) {
    selectedTabIndex.value = value;
  }

  void _resetProductsLoading() async {
    productsRefreshController.refreshCompleted();
    if (totalRecords.value <= products.length) {
      productsRefreshController.loadNoData();
    } else {
      productsRefreshController.loadComplete();
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
    _resetProductsLoading();
  }

  Future<void> addToCart(Product product, CartType cartType,
      {bool refresh = false}) async {
    late AbsCartManager _cartManager;
    switch (cartType) {
      case CartType.order:
        _cartManager = Get.find<OrderCartManager>();
        break;
      case CartType.wishList:
        _cartManager = Get.find<WishListCartManager>();
        break;
    }

    var result = await _actionCenter.execute(() async {
      await _cartManager.addProduct(product);
    });
    if (result) {
      Get.snackbar(
        "Success",
        "Product added to cart",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.green,
        borderColor: AppColors.green,
        colorText: AppColors.white,
        borderWidth: 0,
        margin: EdgeInsets.all(0),
        borderRadius: 5,
        duration: Duration(seconds: 1),
      );
      if (refresh) {
        switch (cartType) {
          case CartType.order:
            orderCartRefreshController.requestRefresh();
            break;
          case CartType.wishList:
            wishlistCartRefreshController.requestRefresh();
            break;
        }
      }
    }
  }

  Future<void> decrementProductFromCart(
      Product product, CartType cartType, AbsCartManager cartManager,
      {bool refresh = false}) async {
    var result = await _actionCenter.execute(() async {
      await cartManager.decrementProduct(product);
    });
    if (result) {
      Get.snackbar(
        "Success",
        "Product removed from cart",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.grey,
        colorText: AppColors.blackColor,
        borderWidth: 0,
        margin: EdgeInsets.all(0),
        borderRadius: 5,
        duration: Duration(seconds: 1),
      );
      if (refresh) {
        switch (cartType) {
          case CartType.order:
            orderCartRefreshController.requestRefresh();
            break;
          case CartType.wishList:
            wishlistCartRefreshController.requestRefresh();
            break;
        }
      }
    }
  }

  Future<void> getCartList(
      CartType cartType, AbsCartManager cartManager) async {
    var result = await _actionCenter.execute(() async {
      await cartManager.getProducts();
    });
    if (result) {
      switch (cartType) {
        case CartType.order:
          orderCartRefreshController.refreshCompleted();
          break;
        case CartType.wishList:
          wishlistCartRefreshController.refreshCompleted();
          break;
      }
    }
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
