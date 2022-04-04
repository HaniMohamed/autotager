import 'package:autotager/app/data/managers/cart_manager/abs_cart_manager.dart';
import 'package:autotager/app/data/managers/cart_manager/order_cart_manager.dart';
import 'package:autotager/app/data/managers/cart_manager/wishlist_cart_manager.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.put(OrderCartManager());
    Get.put(WishListCartManager());
  }
}
