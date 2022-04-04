import 'package:autotager/app/data/enums.dart';
import 'package:autotager/app/data/model/dtos/api/products_response_dto/product.dart';
import 'package:autotager/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ProductsView extends StatelessWidget {
  const ProductsView({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          alignment: Alignment.centerLeft,
          child: Text("All Products:"),
        ),
        Expanded(
          child: Obx(() => SmartRefresher(
              controller: controller.productsRefreshController,
              enablePullUp: true,
              onRefresh: () => controller.getProducts(forceRefresh: true),
              onLoading: () => controller.getProducts(),
              footer: const ClassicFooter(),
              child: ListView.builder(
                itemCount: controller.products.length,
                itemBuilder: (context, index) {
                  Product product = controller.products[index];
                  return ListTile(
                    leading:
                        Image.network(product.images?.first.cachedPath ?? ""),
                    title: Text(
                      product.name ?? "",
                      maxLines: 2,
                    ),
                    subtitle: Text(
                        "${product.variants?.variant?.price?.current ?? ""} ${product.variants?.variant?.price?.currency ?? ""}"),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            onPressed: () =>
                                controller.addToCart(product, CartType.order),
                            icon: Icon(Icons.add_shopping_cart)),
                        IconButton(
                            onPressed: () => controller.addToCart(
                                product, CartType.wishList),
                            icon: Icon(Icons.post_add_outlined)),
                      ],
                    ),
                  );
                },
              ))),
        ),
      ],
    );
  }
}
