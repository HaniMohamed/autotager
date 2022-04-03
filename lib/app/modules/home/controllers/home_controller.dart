import 'package:autotager/app/data/managers/api_manager/authentication/authentication_manager.dart';
import 'package:autotager/app/data/services/authentication/auth_service.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxBool loading = false.obs;
  RxString email = "".obs;
  @override
  void onInit() {
    super.onInit();
    email.value = Get.find<AuthService>().user?.email ?? "";
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void logout() async {
    loading.value = true;
    await Get.find<AuthService>().signOut();
    loading.value = false;
  }
}
