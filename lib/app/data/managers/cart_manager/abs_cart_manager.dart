import 'package:autotager/app/data/model/dtos/api/products_response_dto/product.dart';

abstract class AbsCartManager {
  abstract String cartName;
  abstract String cartTableScheme;
  Future<void> initTable();
  Future<void> getProducts();
  Future<void> addProduct(Product product);
  Future<void> decrementProduct(Product product);
  Future<void> removeProduct(Product product);
  Future<void> clearCart();
}
