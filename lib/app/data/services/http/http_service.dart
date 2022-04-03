import 'package:autotager/app/core/utils/action_center/exceptions.dart';
import 'package:autotager/app/data/enums.dart';
import 'package:autotager/app/data/services/logger/logger.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http/retry.dart';

class HttpService extends GetxService implements AbsHttpService {
  @override
  Future<http.Response?> sendRequest(Uri uri, HttpMethod httpMethod,
      {Object? body, Map<String, String> extraHeaders = const {}}) async {
    late http.Response response;
    switch (httpMethod) {
      case HttpMethod.get:
        try {
          response = await RetryClient(http.Client()).get(
            uri,
            headers: {
              'Accept': 'application/json',
            }..addAll(extraHeaders),
          );
        } catch (err) {
          _throwExceptionError(err);
        }
        break;
      case HttpMethod.post:
        try {
          response = await RetryClient(http.Client()).post(uri,
              headers: {
                'Accept': 'application/json',
              }..addAll(extraHeaders),
              body: body);
        } catch (err) {
          _throwExceptionError(err);
        }
        break;
      default:
    }
    if (response.statusCode < 200 || response.statusCode > 299) {
      _throwResponseError(response, body.toString());
      return null;
    }
    Get.find<AbsLoggerService>().info(message: response.body);
    return response;
  }

  void _throwExceptionError(err) {
    throw ACException(err.toString())..originalException = err;
  }

  void _throwResponseError(http.Response? response, String body) {
    Get.find<AbsLoggerService>()
        .error(message: "${response?.body ?? ""}\r requestBody: $body");
    throw ApiResponseException(response?.statusCode ?? 0)
      ..message = response?.body ?? ""
      ..originalException = response?.reasonPhrase;
  }
}

abstract class AbsHttpService {
  Future<http.Response?> sendRequest(Uri uri, HttpMethod httpMethod,
      {Object? body, Map<String, String> extraHeaders = const {}});
}
