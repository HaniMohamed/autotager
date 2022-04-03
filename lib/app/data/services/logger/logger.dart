class LoggerService extends AbsLoggerService {
  static bool displayErrorDetails = false;

  @override
  void info({
    dynamic message,
  }) {
    print('Logger : Info : $message');
  }

  @override
  void error(
      {dynamic message,
      dynamic error,
      dynamic stackTrace,
      dynamic exception,
      dynamic exceptionStackTrace,
      dynamic exceptionMessage,
      dynamic exceptionStackTraceMessage}) {
    print(
        'Logger : Error : $message : $error : $stackTrace : $exception : $exceptionStackTrace : $exceptionMessage : $exceptionStackTraceMessage');
  }

  @override
  void warning(
      {dynamic message,
      dynamic error,
      dynamic stackTrace,
      dynamic exception,
      dynamic exceptionStackTrace,
      dynamic exceptionMessage,
      dynamic exceptionStackTraceMessage}) {
    print(
        'Logger : Warning : $message : $error : $stackTrace : $exception : $exceptionStackTrace : $exceptionMessage : $exceptionStackTraceMessage');
  }

  @override
  void debug(
      {dynamic message,
      dynamic error,
      dynamic stackTrace,
      dynamic exception,
      dynamic exceptionStackTrace,
      dynamic exceptionMessage,
      dynamic exceptionStackTraceMessage}) {
    print(
        'Logger : Debug : $message : $error : $stackTrace : $exception : $exceptionStackTrace : $exceptionMessage : $exceptionStackTraceMessage');
  }
}

abstract class AbsLoggerService {
  void info({
    dynamic message,
  }) {}

  void error(
      {dynamic message,
      dynamic error,
      dynamic stackTrace,
      dynamic exception,
      dynamic exceptionStackTrace,
      dynamic exceptionMessage,
      dynamic exceptionStackTraceMessage}) {}

  void warning(
      {dynamic message,
      dynamic error,
      dynamic stackTrace,
      dynamic exception,
      dynamic exceptionStackTrace,
      dynamic exceptionMessage,
      dynamic exceptionStackTraceMessage}) {}

  void debug(
      {dynamic message,
      dynamic error,
      dynamic stackTrace,
      dynamic exception,
      dynamic exceptionStackTrace,
      dynamic exceptionMessage,
      dynamic exceptionStackTraceMessage}) {}
}
