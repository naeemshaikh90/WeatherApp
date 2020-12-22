import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/data/domain_mapper/domain_mapper.dart';
import 'package:weather_app/data/network_layer/api_response.dart';
import 'package:weather_app/data/network_layer/api_services.dart';
import 'package:weather_app/data/network_layer/network_service.dart';
import 'package:weather_app/model/response_model/search_weather_response.dart';

abstract class WeatherApi {
  Future<ApiResponse> getSearchWeatherData({@required String requestQuery});
}

class IWeatherApi extends WeatherApi {
  NetworkService networkService;
  ApiServices apiServices;
  DomainMapper domainMapper;

  IWeatherApi({
    @required this.networkService,
    @required this.apiServices,
    @required this.domainMapper,
  });

  @override
  Future<ApiResponse> getSearchWeatherData({String requestQuery}) async {
    http.Response _response = await networkService
        .callApi(
            httpMethod: HttpMethod.GET,
            headerType: HeaderType.ApiKey,
            url: apiServices.getSearchWeatherUrl(),
            body: requestQuery)
        .catchError((exception) {
      return domainMapper.mapGenericResponse(
        success: false,
        message: "Error: ${exception.toString()}",
        data: [],
      );
    });

    SearchWeatherResponse searchWeatherResponse = searchWeatherResponseFromJson(
      _response.body,
    );

    if (searchWeatherResponse != null) {
      return domainMapper.mapGenericResponse(
        success: true,
        message: "Data fetched successfully",
        data: searchWeatherResponse,
      );
    } else {
      String errorMessage = "Error: SearchWeatherResponse is empty";
      return domainMapper.mapGenericResponse(
        success: false,
        message: errorMessage,
        data: [],
      );
    }
  }
}
