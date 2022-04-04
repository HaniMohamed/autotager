import 'package:autotager/app/data/model/dtos/api/products_response_dto/product.dart';

class CartProduct {
  Product product;
  int quantity;
  CartProduct(this.product, this.quantity);
}
