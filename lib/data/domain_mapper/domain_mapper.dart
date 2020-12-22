import 'package:weather_app/data/network_layer/api_response.dart';

abstract class DomainMapper {
  ApiResponse mapGenericResponse({
    bool success: false,
    String message: "",
    dynamic data,
  });
}

class IDomainMapper extends DomainMapper {
  @override
  ApiResponse mapGenericResponse({
    bool success = false,
    String message = "",
    data,
  }) {
    return ApiResponse(
      success: success,
      message: message,
      data: data,
    );
  }
}
