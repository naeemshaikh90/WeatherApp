class ApiStatusCode {
  // Success
  static const int statusCode200Ok = 200;

  // Error
  static const int statusCode400BadRequest = 400;
  static const int statusCode401Unauthorized = 401;
  static const int statusCode403Forbidden = 403;
  static const int statusCode404NotFound = 404;

  static const int statusCode500InternalServerError = 500;
  static const int statusCode503ServiceUnavailable = 503;
  static const int statusCode504GatewayTimeout = 504;
}
