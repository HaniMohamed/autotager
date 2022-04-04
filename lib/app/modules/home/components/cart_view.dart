import 'package:autotager/app/data/enums.dart';
import 'package:autotager/app/data/managers/cart_manager/abs_cart_manager.dart';
import 'package:autotager/app/data/model/cart_product.dart';
import 'package:autotager/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CartView extends StatelessWidget {
  const CartView(
      {Key? key,
      required this.cartType,
      required this.cartManager,
      required this.refreshController})
      : super(key: key);
  final CartType cartType;
  final AbsCartManager cartManager;
  static final HomeController homeController = Get.find();
  final RefreshController refreshController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          alignment: Alignment.centerLeft,
          child: Text("${cartType.name.capitalizeFirst} Cart:"),
        ),
        Expanded(
          child: Obx(() => SmartRefresher(
                controller: refreshController,
                enablePullUp: false,
                onRefresh: () =>
                    CartView.homeController.getCartList(cartType, cartManager),
                footer: const ClassicFooter(),
                child: cartManager.cartProducts.isEmpty
                    ? Center(child: Text("No products found"))
                    : ListView.builder(
                        itemCount: cartManager.cartProducts.length,
                        itemBuilder: (context, index) {
                          CartProduct cartProduct =
                              cartManager.cartProducts[index];
                          return ListTile(
                            leading: Image.network(
                                cartProduct.product.images?.first.cachedPath ??
                                    ""),
                            title: Text(
                              cartProduct.product.name ?? "",
                              maxLines: 2,
                            ),
                            subtitle: Text(
                                "${cartProduct.product.variants?.variant?.price?.current ?? ""} ${cartProduct.product.variants?.variant?.price?.currency ?? ""}"),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                    onPressed: () => CartView.homeController
                                        .addToCart(
                                            cartProduct.product, cartType,
                                            refresh: true),
                                    icon: Icon(Icons.add_circle)),
                                Text(cartProduct.quantity.toString()),
                                IconButton(
                                    onPressed: () => CartView.homeController
                                        .decrementProductFromCart(
                                            cartProduct.product,
                                            cartType,
                                            cartManager,
                                            refresh: true),
                                    icon: Icon(Icons.remove_circle_rounded)),
                              ],
                            ),
                          );
                        }),
              )),
        ),
      ],
    );
  }
}
