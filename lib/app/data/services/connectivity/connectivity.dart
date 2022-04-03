import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:autotager/app/core/values/strings.dart';
import 'package:autotager/app/data/services/logger/logger.dart';
import 'package:autotager/app/global_widgets/overlay_helper.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ConnectivityService extends GetxService
    implements AbsConnectivityService {
  final AbsLoggerService _logger;

  @override
  RxInt connectionStatus = 0.obs;

  @override
  bool isConnected = false;

  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  ConnectivityService(this._logger);

  @override
  void onInit() {
    super.onInit();
    initConnectivity();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(updateConnectionStatus);
  }

  @override
  void onClose() {
    _connectivitySubscription.cancel();
    super.onClose();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  @override
  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e, s) {
      _logger.error(error: "signOut failed", stackTrace: s);
      return;
    }
    return updateConnectionStatus(result);
  }

  @override
  Future<void> updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.mobile:
        connectionStatus.value = 1;
        isConnected = true;
        break;
      case ConnectivityResult.wifi:
        connectionStatus.value = 2;
        isConnected = true;
        break;
      case ConnectivityResult.none:
        OverlayHelper.showGeneralToast(
          Get.overlayContext!,
          AppStrings.noConnection,
          AppStrings.noInternetConnection,
        );

        isConnected = false;
        connectionStatus.value = 0;
        break;
      default:
        OverlayHelper.showGeneralToast(
          Get.overlayContext!,
          AppStrings.networkError,
          AppStrings.failedNetworkConnection,
        );
        isConnected = false;
        break;
    }
  }
}

abstract class AbsConnectivityService {
  Future<void> initConnectivity();
  Future<void> updateConnectionStatus(ConnectivityResult result);
  RxInt connectionStatus = 0.obs;
  bool isConnected = false;
}
