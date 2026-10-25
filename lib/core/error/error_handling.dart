import 'package:dio/dio.dart';

import '../failure/failure.dart';

class ErrorHandler {
  static Failure handle(dynamic exception) {
    if (exception is DioException) {
      return _handleRemoteError(exception.toString());
    }
    return Failure(failureMessage: 'Unexpected error occurred');
  }

  static Failure _handleRemoteError(String message) {
    final errorMessage = message.trim();
    if (errorMessage.contains('401') ||
        errorMessage.contains('unauthorized') ||
        errorMessage.contains('Unauthenticated')) {
      return Failure(failureMessage: 'فشل في المصادقة. ');
    }
    if (errorMessage.contains('403') ||
        errorMessage.contains('forbidden') ||
        errorMessage.contains('Forbidden')) {
      return Failure(failureMessage: 'ليس لديك إذن الوصول ');
    }
    if (errorMessage.contains('404') || errorMessage.contains('not found')) {
      return Failure(failureMessage: 'البيانات غير موجودة');
    }
    if (errorMessage.contains('422') ||
        errorMessage.contains('unprocessable content')) {
      return Failure(failureMessage: 'البيانات غير موجودة');
    }
    if (errorMessage.contains('500') ||
        errorMessage.contains('internal server error')) {
      return Failure(failureMessage: 'خطأ في الخادم الداخلي');
    }
    if (errorMessage.contains('SocketException') ||
        errorMessage.contains('connection failed') ||
        errorMessage.contains('HandshakeException')) {
      return Failure(failureMessage: 'لا يوجد اتصال بالانترنت');
    }
    if (errorMessage.contains('Timeout') ||
        errorMessage.contains('Deadline') ||
        errorMessage.contains('Connection timed out')) {
      return Failure(failureMessage: 'انتهت مهلة الاتصال');
    }
    if (errorMessage.contains('FormatException') ||
        errorMessage.contains('TypeError')) {
      return Failure(failureMessage: 'تنسيق البيانات غير صالح');
    }
    if (errorMessage.isNotEmpty &&
        !errorMessage.contains('Exception') &&
        errorMessage.contains('Error')) {
      return Failure(failureMessage: errorMessage);
    }
    return Failure(failureMessage: 'Unexpected error occurred');
  }
}
