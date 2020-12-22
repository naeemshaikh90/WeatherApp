import 'package:weather_app/utils/global_shared_objects.dart';

class BadRequestException implements Exception {
  String toString() {
    return apiExceptionMessages.message400BadRequest;
  }
}

class UnauthorizedException implements Exception {
  String toString() {
    return apiExceptionMessages.message401Unauthorized;
  }
}

class ForbiddenException implements Exception {
  String toString() {
    return apiExceptionMessages.message403Forbidden;
  }
}

class NotFoundException implements Exception {
  String toString() {
    return apiExceptionMessages.message404NotFound;
  }
}

class InternalServerErrorException implements Exception {
  String toString() {
    return apiExceptionMessages.message500InternalServerError;
  }
}

class ServiceUnavailableException implements Exception {
  String toString() {
    return apiExceptionMessages.message503ServiceUnavailable;
  }
}

class GatewayTimeoutException implements Exception {
  String toString() {
    return apiExceptionMessages.message504GatewayTimeout;
  }
}

class DefaultException implements Exception {
  String toString() {
    return apiExceptionMessages.somethingWentWrong;
  }
}

class CustomException implements Exception {
  final String message;
  CustomException(this.message);

  String toString() {
    return message;
  }
}

bool shouldIgnoreException(exception) {
  if (exception is BadRequestException ||
      exception is UnauthorizedException ||
      exception is ForbiddenException ||
      exception is NotFoundException ||
      exception is InternalServerErrorException ||
      exception is ServiceUnavailableException ||
      exception is GatewayTimeoutException) {
    return false;
  } else {
    return true;
  }
}
