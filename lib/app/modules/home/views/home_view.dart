import 'package:autotager/app/data/model/dtos/api/products_response_dto/product.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
        centerTitle: true,
      ),
      body: Center(
          child: Obx(() => SmartRefresher(
              controller: controller.refreshController,
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
                  );
                },
              )))),
    );
  }
}
