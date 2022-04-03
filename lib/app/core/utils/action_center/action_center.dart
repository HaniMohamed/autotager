import 'package:autotager/app/core/values/strings.dart';
import 'package:autotager/app/data/services/connectivity/connectivity.dart';
import 'package:autotager/app/data/services/logger/logger.dart';
import 'package:autotager/app/global_widgets/overlay_helper.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';

import 'exceptions.dart';

class ActionCenter {
  final _logger = Get.find<AbsLoggerService>();
  final _connectivityService = Get.find<AbsConnectivityService>();

  static bool displayErrorDetails = false;

  ActionCenter();

  /// returns true if the action is completed successfully,
  /// [errorHandler] takes the exception or error, and is used to
  /// pre-handle it, returns true if the error handled and false
  /// if the error not handled by it, and hence it will fall to
  /// the generic handling
  Future<bool> execute(Future<void> Function() action,
      {bool checkConnection = false,
      Function(dynamic ex)? errorHandler}) async {
    try {
      // if check connection
      if (checkConnection) {
        if (!_connectivityService.isConnected) {
          _logger.info(message: 'ActionCenter : No Internet Connection');
          OverlayHelper.showErrorToast(
              Get.overlayContext!, 'No Internet Connection');
          return false;
        }
      }

      await action();

      return true;
    } catch (ex, st) {
      // the handler sent by the caller
      if (errorHandler != null && errorHandler(ex)) {
        _logger.error(error: ex, stackTrace: st);
        return false;
      }
      // check for context as it is necessary for toast

      if (ex is ACException) {
        _logger.error(error: ex.message, stackTrace: st);

        // specialized exceptions
        if (ex is ApiTimeoutException) {
          OverlayHelper.showErrorToast(
              Get.overlayContext!, AppStrings.requestTimeout);
        } else if (ex is ApiResponseException) {
          String message = ex.message.isNotEmpty
              ? ex.message
              : AppStrings.somethingWrongTryAgain;
          if (HttpStatus(ex.statusCode).isServerError) {
            OverlayHelper.showErrorToast(
                Get.overlayContext!, message.replaceAll("\"", ""));
          } else {
            OverlayHelper.showWarningToast(
                Get.overlayContext!, message.replaceAll("\"", ""));
          }
        } else {
          OverlayHelper.showErrorToast(
              Get.overlayContext!, ex.message.replaceAll("\"", ""));
        }
      } else {
        OverlayHelper.showErrorToast(
            Get.overlayContext!, AppStrings.somethingWrong);
        _logger.error(error: ex.toString());
      }

      return false;
    } finally {}
  }
}
