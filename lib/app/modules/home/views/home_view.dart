import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Obx(() => controller.loading.isTrue
                ? Container(
                    margin: EdgeInsets.symmetric(vertical: 16),
                    child: CircularProgressIndicator())
                : Text(controller.products.length.toString())),
            Text(
              'Hello, ${controller.email.value}',
              style: TextStyle(fontSize: 20),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextButton(
                  child: Text('load more'),
                  onPressed: () {
                    controller.getProducts();
                  },
                ),
                TextButton(
                  child: Text('fore refresh'),
                  onPressed: () {
                    controller.getProducts(forceRefresh: true);
                  },
                ),
              ],
            ),
            TextButton(
              child: Text('Logout'),
              onPressed: () {
                controller.logout();
              },
            ),
          ],
        ),
      ),
    );
  }
}
