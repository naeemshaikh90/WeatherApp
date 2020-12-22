import 'package:flutter/material.dart';
import 'package:weather_app/data/network_layer/api_response.dart';
import 'package:weather_app/data/weather_api/weather_api.dart';

abstract class WeatherDataAccessor {
  Future<ApiResponse> getSearchWeatherData({@required String requestQuery});
}

class IWeatherDataAccessor extends WeatherDataAccessor {
  WeatherApi weatherApi;

  IWeatherDataAccessor({
    @required this.weatherApi,
  });

  @override
  Future<ApiResponse> getSearchWeatherData({String requestQuery}) async {
    try {
      ApiResponse apiResponse = await weatherApi.getSearchWeatherData(
        requestQuery: requestQuery,
      );
      return apiResponse;
    } catch (exception) {
      throw exception;
    }
  }
}
