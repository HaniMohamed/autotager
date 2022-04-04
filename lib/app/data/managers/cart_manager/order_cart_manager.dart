import 'package:autotager/app/core/utils/action_center/action_center.dart';
import 'package:autotager/app/data/managers/api_manager/products/products_manager.dart';
import 'package:autotager/app/data/managers/cart_manager/abs_cart_manager.dart';
import 'package:autotager/app/data/managers/local_db/local_db_manager.dart';
import 'package:autotager/app/data/model/cart_product.dart';
import 'package:autotager/app/data/model/dtos/api/products_response_dto/product.dart';
import 'package:autotager/app/data/model/dtos/paginated_request_dto.dart';
import 'package:autotager/app/data/services/logger/logger.dart';
import 'package:get/get.dart';

class OrderCartManager extends GetxController implements AbsCartManager {
  final AbsLocalDBManager _absLocalDBManager = Get.find<AbsLocalDBManager>();
  final ActionCenter _actionCenter = ActionCenter();
  final AbsProductsApiManager _productsApiManager =
      Get.put(ProductsAPIManager());

  @override
  RxList<CartProduct> cartProducts = <CartProduct>[].obs;

  @override
  String cartName = 'orderCart';

  @override
  String cartTableScheme =
      "(code TEXT PRIMARY KEY, slug TEXT, quantity INTEGER, createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL)";

  @override
  RxBool inProgress = RxBool(false);

  @override
  Future<void> onInit() async {
    await initTable();
    super.onInit();
  }

  @override
  Future<void> addProduct(Product product) async {
    Map? savedProduct =
        await _absLocalDBManager.fetchObject(cartName, 'code', product.code);

    if (savedProduct != null) {
      await _absLocalDBManager.updateObject(
          cartName,
          {
            "code": product.code,
            "slug": product.slug,
            "quantity": savedProduct['quantity'] + 1
          },
          'code',
          product.code);
    } else {
      await _absLocalDBManager.insertObject(cartName,
          {"code": product.code, "slug": product.slug, "quantity": 1});
    }
  }

  @override
  Future<void> clearCart() async {
    await _absLocalDBManager.clearTable(cartName);
  }

  @override
  Future<void> getProducts() async {
    inProgress.value = true;
    List<CartProduct> products = <CartProduct>[];
    await _absLocalDBManager
        .listObjects(cartName, orderByKey: "createdAt")
        .then((value) async {
      for (var element in value) {
        Product? product;
        var result = await _actionCenter.execute(() async {
          product = await _productsApiManager.getProductBySlug(
            element['slug'],
            requestDto: PaginatedRequestDto(locale: "en"),
          );
        }, checkConnection: true);
        if (result && product != null) {
          products.add(CartProduct(product!, element['quantity']));
        }
      }
    });
    cartProducts.value = products;
    inProgress.value = false;
  }

  @override
  Future<void> decrementProduct(Product product) async {
    Map? savedProduct =
        await _absLocalDBManager.fetchObject(cartName, 'code', product.code);

    if (savedProduct != null) {
      if (savedProduct['quantity'] > 1) {
        await _absLocalDBManager.updateObject(
            cartName,
            {
              "code": product.code,
              "slug": product.slug,
              "quantity": savedProduct['quantity'] - 1
            },
            'code',
            product.code);
      } else {
        await _absLocalDBManager.deleteObject(cartName, 'code', product.code);
      }
    }
  }

  @override
  Future<void> removeProduct(Product product) async {
    await _absLocalDBManager.deleteObject(cartName, 'code', product.code);
  }

  @override
  Future<void> initTable() async {
    await _absLocalDBManager.initDB();
    await _absLocalDBManager.createTable(cartName, cartTableScheme);
  }
}
