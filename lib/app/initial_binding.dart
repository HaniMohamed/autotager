import 'package:autotager/app/data/managers/api_manager/authentication/authentication_manager.dart';
import 'package:autotager/app/data/managers/cache_manager/cache_manager.dart';
import 'package:autotager/app/data/managers/local_db/local_db_manager.dart';
import 'package:autotager/app/data/services/authentication/auth_service.dart';
import 'package:autotager/app/data/services/connectivity/connectivity.dart';
import 'package:autotager/app/data/services/http/http_service.dart';
import 'package:autotager/app/data/services/logger/logger.dart';
import 'package:get/get.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    // Logger service
    Get.lazyPut<AbsLoggerService>(() => LoggerService());

    // connectivity service
    Get.lazyPut<AbsConnectivityService>(() => ConnectivityService(Get.find()));

    // cache service
    Get.lazyPut<AbsCacheManager>(() => CacheManager());

    // http service
    Get.lazyPut<AbsHttpService>(() => HttpService());

    // local db manager
    Get.lazyPut<AbsLocalDBManager>(() => LocalDBManager());

    // auth service
    Get.put(AuthService());
  }
}
