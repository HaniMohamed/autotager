import 'package:autotager/app/core/values/app_colors.dart';
import 'package:autotager/app/data/enums.dart';
import 'package:autotager/app/data/managers/cart_manager/order_cart_manager.dart';
import 'package:autotager/app/data/managers/cart_manager/wishlist_cart_manager.dart';
import 'package:autotager/app/data/model/dtos/api/products_response_dto/product.dart';
import 'package:autotager/app/modules/home/components/cart_view.dart';
import 'package:autotager/app/modules/home/components/products_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AutoTager Task'),
        centerTitle: true,
      ),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart),
                label: 'Order Cart',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.list_alt_rounded),
                label: 'WishList',
              ),
            ],
            currentIndex: controller.selectedTabIndex.value,
            selectedItemColor: AppColors.blue,
            onTap: controller.onTabTapped,
          )),
      body: Center(child: Obx(() {
        switch (controller.selectedTabIndex.value) {
          case 0:
            return ProductsView(
              controller: controller,
            );
          case 1:
            return CartView(
              key: UniqueKey(),
              cartType: CartType.order,
              cartManager: Get.find<OrderCartManager>(),
              refreshController: controller.orderCartRefreshController,
            );

          case 2:
            return CartView(
              key: UniqueKey(),
              cartType: CartType.wishList,
              cartManager: Get.find<WishListCartManager>(),
              refreshController: controller.wishlistCartRefreshController,
            );

          default:
            return ProductsView(
              controller: controller,
            );
        }
      })),
    );
  }
}
