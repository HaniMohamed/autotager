import 'package:autotager/app/core/utils/action_center/action_center.dart';
import 'package:autotager/app/data/managers/api_manager/products/products_manager.dart';
import 'package:autotager/app/data/managers/cart/abs_cart_manager.dart';
import 'package:autotager/app/data/managers/local_db/local_db_manager.dart';
import 'package:autotager/app/data/model/dtos/api/products_response_dto/product.dart';
import 'package:autotager/app/data/model/dtos/paginated_request_dto.dart';
import 'package:autotager/app/data/services/logger/logger.dart';
import 'package:get/get.dart';

class WishListCartManager implements AbsCartManager {
  final RxList<Product> products = <Product>[].obs;
  final AbsLocalDBManager _absLocalDBManager = Get.find<AbsLocalDBManager>();
  final ActionCenter _actionCenter = ActionCenter();
  final AbsProductsApiManager _productsApiManager =
      Get.put(ProductsAPIManager());

  @override
  String cartName = 'wishListCart';

  @override
  String cartTableScheme =
      "(code TEXT PRIMARY KEY, slug TEXT, quantity INTEGER)";

  @override
  Future<void> addProduct(Product product) async {
    Map? savedProduct =
        await _absLocalDBManager.fetchObject(cartName, 'code', product.code);

    if (savedProduct != null) {
      await _absLocalDBManager.insertObject(cartName, {
        "code": product.code,
        "slug": product.slug,
        "quantity": savedProduct['quantity'] + 1
      });
    } else {
      await _absLocalDBManager.insertObject(cartName,
          {"code": product.code, "slug": product.slug, "quantity": 1});
    }
    getProducts();
  }

  @override
  Future<void> clearCart() async {
    await _absLocalDBManager.clearTable(cartName);
    getProducts();
  }

  @override
  Future<void> getProducts() async {
    products.clear();
    await _absLocalDBManager.listObjects(cartName).then((value) async {
      for (var element in value) {
        Product? product;
        var result = await _actionCenter.execute(() async {
          product = await _productsApiManager.getProductBySlug(
            element['slug'],
            requestDto: PaginatedRequestDto(locale: "en"),
          );
        }, checkConnection: true);
        if (result && product != null) {
          products.add(product!);
        }
      }
    });
  }

  @override
  Future<void> decrementProduct(Product product) async {
    Map? savedProduct =
        await _absLocalDBManager.fetchObject(cartName, 'code', product.code);

    if (savedProduct != null) {
      await _absLocalDBManager.insertObject(cartName, {
        "code": product.code,
        "slug": product.slug,
        "quantity": savedProduct['quantity'] - 1
      });
    } else {
      await _absLocalDBManager.deleteObject(cartName, 'code', product.code);
    }
    getProducts();
  }

  @override
  Future<void> removeProduct(Product product) async {
    await _absLocalDBManager.deleteObject(cartName, 'code', product.code);
    getProducts();
  }

  @override
  Future<void> initTable() async {
    await _absLocalDBManager.initDB();
    await _absLocalDBManager.createTable(cartName, cartTableScheme);
  }
}
