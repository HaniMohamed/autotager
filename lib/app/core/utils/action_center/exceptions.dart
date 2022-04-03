class ACException implements Exception {
  /// the message to display to the user
  String message;

  /// the technical descrition of the error
  String? description;

  dynamic originalException;

  ACException(this.message, {this.description});

  @override
  String toString() {
    return '(ACException) msg:$message desc:$description';
  }
}

class ApiTimeoutException extends ACException {
  ApiTimeoutException() : super('Request timed out');
}

class ApiResponseException extends ACException {
  int statusCode;

  ApiResponseException(this.statusCode)
      : super('Something went wrong, Try again later');
}
