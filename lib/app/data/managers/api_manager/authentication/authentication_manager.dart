import 'package:autotager/app/core/values/common_urls.dart';
import 'package:autotager/app/data/enums.dart';
import 'package:autotager/app/data/model/login_response.dart';
import 'package:autotager/app/data/model/user.dart';
import 'package:autotager/app/data/services/http/http_service.dart';
import 'package:get/get.dart';

class AuthAPIManager extends AbsAuthApiManager {
  String get baseUrl => CommonUrls.authServerUrl + '/api-auth';

  @override
  RxBool inProgress = RxBool(false);

  @override
  Future<User?> getUserModel(String token) async {
    Uri uri = Uri.parse(baseUrl + '/user');

    inProgress.value = true;

    var response = await Get.find<AbsHttpService>().sendRequest(
        uri, HttpMethod.get,
        extraHeaders: {"Authorization": "Token $token"});

    if (response != null) {
      inProgress.value = false;

      return User.fromJson(response.body);
    }
    inProgress.value = false;
    return null;
  }

  @override
  Future<LoginResponse?> login(String username, String password) async {
    Uri uri = Uri.parse(baseUrl + '/login');

    inProgress.value = true;

    var response = await Get.find<AbsHttpService>().sendRequest(
        uri, HttpMethod.post,
        body: {"username": username, "password": password});

    if (response != null) {
      inProgress.value = false;
      return LoginResponse.fromJson(response.body);
    }

    inProgress.value = false;
    return null;
  }

  @override
  Future<bool> logout(String token) async {
    Uri uri = Uri.parse(baseUrl + '/logout');

    inProgress.value = true;

    var response = await Get.find<AbsHttpService>().sendRequest(
        uri, HttpMethod.post,
        extraHeaders: {"Authorization": "Token $token"});

    if (response != null) {
      inProgress.value = false;

      return true;
    }
    inProgress.value = false;
    return false;
  }

  @override
  Future<LoginResponse?> register(
      String username, String email, String password) async {
    Uri uri = Uri.parse(baseUrl + '/register');

    inProgress.value = true;

    var response = await Get.find<AbsHttpService>().sendRequest(
        uri, HttpMethod.post,
        body: {"username": username, "email": email, "password": password});

    if (response != null) {
      inProgress.value = false;

      return LoginResponse.fromJson(response.body);
    }
    inProgress.value = false;
    return null;
  }
}

abstract class AbsAuthApiManager {
  late RxBool inProgress;

  Future<User?> getUserModel(String token);
  Future<LoginResponse?> login(String username, String password);
  Future<LoginResponse?> register(
      String username, String email, String password);
  Future<bool> logout(String token);
}
