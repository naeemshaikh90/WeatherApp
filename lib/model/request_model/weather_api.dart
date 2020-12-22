import 'package:flutter/material.dart';

abstract class WeatherRequest {
  String getSearchWeatherRequestQuery({
    /// use this parameter when searching for a city. Do not use with other parameters
    @required String q,

    /// To limit number of listed cities please setup cnt parameter
    int cnt = 1,

    /// Must be used with lat. Get current weather data when you know the longitude of the city.
    double longitude,

    /// Must be used with lon. Get current weather data when you know the latitude of the city.
    double latitude,

    /// You can use different types of metric systems by units = metric or imperial
    String units = "metric",
  });
}

class IWeatherRequest extends WeatherRequest {
  @override
  String getSearchWeatherRequestQuery({
    @required String q,
    int cnt = 1,
    double longitude,
    double latitude,
    String units = "metric",
  }) {
    String urlRequest = "?q=" + q + "&cnt=" + "$cnt" + "&units=" + units;
    if (longitude != null && latitude != null) {
      urlRequest = urlRequest + "&lon=" + "$longitude" + "&lat=" + "$latitude";
    }
    //print("getSearchWeatherRequestQuery: $urlRequest");
    return urlRequest;
  }
}
