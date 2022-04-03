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
                : SizedBox()),
            Text(
              'Hello, ${controller.email.value}',
              style: TextStyle(fontSize: 20),
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
