class HomeViewUIModel {
  String cityName;
  String currentTemperature;
  String minimumTemperature;
  String maximumTemperature;
  String feelsLikeTemperature;

  String pressure;
  String humidity;

  String windSpeed;
  String weatherType;

  HomeViewUIModel({
    this.currentTemperature,
    this.minimumTemperature,
    this.maximumTemperature,
    this.feelsLikeTemperature,
    this.pressure,
    this.humidity,
    this.windSpeed,
    this.weatherType,
  });
}
