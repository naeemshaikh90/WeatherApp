abstract class ApiExceptionMessages {
  String get somethingWentWrong;
  String get message400BadRequest;
  String get message401Unauthorized;
  String get message403Forbidden;
  String get message404NotFound;
  String get message500InternalServerError;
  String get message503ServiceUnavailable;
  String get message504GatewayTimeout;
}

class IApiExceptionMessages extends ApiExceptionMessages {
  @override
  String get somethingWentWrong => "Something went wrong";

  @override
  String get message400BadRequest => somethingWentWrong;

  @override
  String get message401Unauthorized => "401 - " + somethingWentWrong;

  @override
  String get message403Forbidden => somethingWentWrong;

  @override
  String get message404NotFound => somethingWentWrong;

  @override
  String get message500InternalServerError =>
      "An internal error occurred in Weather API";

  @override
  String get message503ServiceUnavailable =>
      "The server is currently unavailable";

  @override
  String get message504GatewayTimeout => "The request time out";
}
