import 'package:autotager/app/data/managers/api_manager/authentication/authentication_manager.dart';
import 'package:autotager/app/data/services/authentication/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  RxBool passwordVisibility = false.obs;
  RxBool loginView = true.obs;
  RxBool loading = false.obs;

  btnAction() async {
    loading.value = true;
    loginView.value ? await login() : await register();
    loading.value = false;
  }

  Future login() async {
    await Get.find<AuthService>()
        .login(usernameController.text, passwordController.text);
  }

  Future register() async {
    await Get.find<AuthService>().register(
        usernameController.text, emailController.text, passwordController.text);
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
