import 'package:weather_app/data/network_layer/api_end_points.dart';

abstract class ApiServices {
  String getSearchWeatherUrl();
}

class IApiServices extends ApiServices {
  @override
  String getSearchWeatherUrl(){
      String url = ApiEndPoints().getDefaultEndPointUrl + "/find";
      return url;
  }
}