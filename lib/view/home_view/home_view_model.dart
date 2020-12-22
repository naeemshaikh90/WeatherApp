import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:location/location.dart';
import 'package:weather_app/data_accessor/weather_data_accessor.dart';
import 'package:weather_app/model/request_model/weather_api.dart';
import 'package:weather_app/model/response_model/search_weather_response.dart';
import 'package:weather_app/utils/constants.dart';
import 'package:weather_app/view/home_view/home_view_ui_model.dart';

abstract class HomeViewModel {
  /// Utility
  bool get isLoading;
  void setIsLoading(bool isLoading);
  String getErrorMessage();
  Future<LocationData> getLocation();
  Future<String> getCityName({
    @required double latitude,
    @required double longitude,
  });

  /// Networking
  void searchWeatherData({
    @required String cityName,
    int cnt = 1,
    double longitude,
    double latitude,
    String units = "metric",

    // Callback
    @required VoidCallback onCompletion,
  });

  /// UI Model
  HomeViewUIModel get uiModel;
  void configureUIModel();
}

class IHomeViewModel extends HomeViewModel {
  /// Request
  WeatherRequest weatherRequest;

  /// Data Accessor
  WeatherDataAccessor weatherDataAccessor;

  IHomeViewModel({
    // Request
    @required this.weatherRequest,

    // Data Accessor
    @required this.weatherDataAccessor,
  });

  SearchWeatherResponse _searchWeatherResponse;
  HomeViewUIModel _model;

  /// Utility
  bool _isLoading = true;
  String _errorMessage = "";

  @override
  bool get isLoading => _isLoading;

  @override
  void setIsLoading(bool isLoading) {
    _isLoading = isLoading;
  }

  @override
  String getErrorMessage() {
    return _errorMessage;
  }

  @override
  Future<LocationData> getLocation() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return null;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }

    _locationData = await location.getLocation();
    return _locationData;
  }

  @override
  Future<String> getCityName({double latitude, double longitude}) async {
    String cityName = Constants.defaultCityName;

    if (latitude == null || longitude == null) {
      return cityName;
    }

    // Find city name using lat long
    final coordinates = new Coordinates(latitude, longitude);
    List<Address> addresses = await Geocoder.local.findAddressesFromCoordinates(
      coordinates,
    );

    if (addresses.first.locality != null) {
      cityName = addresses.first.locality;
    }

    return cityName;
  }

  /// Networking
  @override
  void searchWeatherData({
    String cityName,
    int cnt = 1,
    double longitude,
    double latitude,
    String units = "metric",
    onCompletion,
  }) async {
    _isLoading = true;
    _model = HomeViewUIModel();

    String _requestQuery = weatherRequest.getSearchWeatherRequestQuery(
      q: cityName,
      cnt: cnt,
      longitude: longitude,
      latitude: latitude,
      units: units,
    );

    weatherDataAccessor
        .getSearchWeatherData(requestQuery: _requestQuery)
        .then((apiResponse) {
      _isLoading = false;

      //print('searchWeatherData response: $apiResponse');

      if (apiResponse.data is SearchWeatherResponse) {
        _searchWeatherResponse = apiResponse.data;
        configureUIModel();
      }
      onCompletion();
    }).catchError((exception) {
      _isLoading = false;
      _errorMessage = exception.toString();
      onCompletion();
    });
  }

  /// UI Model

  @override
  HomeViewUIModel get uiModel {
    return _model;
  }

  @override
  void configureUIModel() {
    _model = HomeViewUIModel();
    SearchWeatherResponseList firstList = _searchWeatherResponse.list.first;
    if (firstList != null) {
      _model.cityName = firstList.name;

      double temp = firstList.main.temp;
      String _currentTemperature = "$temp" + Constants.degreeSymbol;
      _model.currentTemperature = _currentTemperature;

      double tempMin = firstList.main.tempMin;
      String _minimumTemperature = "H:" + "$tempMin" + Constants.degreeSymbol;
      _model.minimumTemperature = _minimumTemperature;

      double tempMax = firstList.main.tempMax;
      String _maximumTemperature = "L:" + "$tempMax" + Constants.degreeSymbol;
      _model.maximumTemperature = _maximumTemperature;

      double feelsLike = firstList.main.feelsLike;
      String _feelsLikeTemperature =
          "Feels Like: " + "$feelsLike" + Constants.degreeSymbol;
      _model.feelsLikeTemperature = _feelsLikeTemperature;

      double pressure = firstList.main.pressure;
      String _pressureLabel = "Pressure: " + "$pressure" + " hPa";
      _model.pressure = _pressureLabel;

      double humidity = firstList.main.humidity;
      String _humidityLabel = "Humidity: " + "$humidity" + "%";
      _model.humidity = _humidityLabel;

      double windSpeed = firstList.wind.speed;
      String _windSpeedLabel = "Wind Speed: " + "$windSpeed" + " kph";
      _model.windSpeed = _windSpeedLabel;

      String _weatherType = firstList.weather.first.main;
      _model.weatherType = _weatherType;
    }
  }
}
