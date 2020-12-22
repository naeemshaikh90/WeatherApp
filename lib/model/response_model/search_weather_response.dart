// To parse this JSON data, do
//
//     final searchWeatherResponse = searchWeatherResponseFromJson(jsonString);

import 'dart:convert';

SearchWeatherResponse searchWeatherResponseFromJson(String str) =>
    SearchWeatherResponse.fromJson(json.decode(str));

String searchWeatherResponseToJson(SearchWeatherResponse data) =>
    json.encode(data.toJson());

class SearchWeatherResponse {
  SearchWeatherResponse({
    this.message,
    this.cod,
    this.count,
    this.list,
  });

  String message;
  String cod;
  int count;
  List<SearchWeatherResponseList> list;

  factory SearchWeatherResponse.fromJson(Map<String, dynamic> json) =>
      SearchWeatherResponse(
        message: json["message"] == null ? null : json["message"],
        cod: json["cod"] == null ? null : json["cod"],
        count: json["count"] == null ? null : json["count"],
        list: json["list"] == null
            ? null
            : List<SearchWeatherResponseList>.from(
                json["list"].map((x) => SearchWeatherResponseList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message == null ? null : message,
        "cod": cod == null ? null : cod,
        "count": count == null ? null : count,
        "list": list == null
            ? null
            : List<dynamic>.from(list.map((x) => x.toJson())),
      };
}

class SearchWeatherResponseList {
  SearchWeatherResponseList({
    this.id,
    this.name,
    this.coord,
    this.main,
    this.dt,
    this.wind,
    this.sys,
    this.rain,
    this.snow,
    this.clouds,
    this.weather,
  });

  int id;
  String name;
  SearchWeatherResponseCoord coord;
  SearchWeatherResponseMain main;
  int dt;
  SearchWeatherResponseWind wind;
  SearchWeatherResponseSys sys;
  dynamic rain;
  dynamic snow;
  SearchWeatherResponseClouds clouds;
  List<SearchWeatherResponseWeather> weather;

  factory SearchWeatherResponseList.fromJson(Map<String, dynamic> json) =>
      SearchWeatherResponseList(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        coord: json["coord"] == null
            ? null
            : SearchWeatherResponseCoord.fromJson(json["coord"]),
        main: json["main"] == null
            ? null
            : SearchWeatherResponseMain.fromJson(json["main"]),
        dt: json["dt"] == null ? null : json["dt"],
        wind: json["wind"] == null
            ? null
            : SearchWeatherResponseWind.fromJson(json["wind"]),
        sys: json["sys"] == null
            ? null
            : SearchWeatherResponseSys.fromJson(json["sys"]),
        rain: json["rain"],
        snow: json["snow"],
        clouds: json["clouds"] == null
            ? null
            : SearchWeatherResponseClouds.fromJson(json["clouds"]),
        weather: json["weather"] == null
            ? null
            : List<SearchWeatherResponseWeather>.from(json["weather"]
                .map((x) => SearchWeatherResponseWeather.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "coord": coord == null ? null : coord.toJson(),
        "main": main == null ? null : main.toJson(),
        "dt": dt == null ? null : dt,
        "wind": wind == null ? null : wind.toJson(),
        "sys": sys == null ? null : sys.toJson(),
        "rain": rain,
        "snow": snow,
        "clouds": clouds == null ? null : clouds.toJson(),
        "weather": weather == null
            ? null
            : List<dynamic>.from(weather.map((x) => x.toJson())),
      };
}

class SearchWeatherResponseCoord {
  SearchWeatherResponseCoord({
    this.lat,
    this.lon,
  });

  double lat;
  double lon;

  factory SearchWeatherResponseCoord.fromJson(Map<String, dynamic> json) =>
      SearchWeatherResponseCoord(
        lat: json["lat"] == null ? null : json["lat"].toDouble(),
        lon: json["lon"] == null ? null : json["lon"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "lat": lat == null ? null : lat,
        "lon": lon == null ? null : lon,
      };
}

class SearchWeatherResponseMain {
  SearchWeatherResponseMain({
    this.temp,
    this.feelsLike,
    this.tempMin,
    this.tempMax,
    this.pressure,
    this.humidity,
  });

  double temp;
  double feelsLike;
  double tempMin;
  double tempMax;
  double pressure;
  double humidity;

  factory SearchWeatherResponseMain.fromJson(Map<String, dynamic> json) =>
      SearchWeatherResponseMain(
        temp: json["temp"] == null ? null : json["temp"].toDouble(),
        feelsLike:
            json["feels_like"] == null ? null : json["feels_like"].toDouble(),
        tempMin: json["temp_min"] == null ? null : json["temp_min"].toDouble(),
        tempMax: json["temp_max"] == null ? null : json["temp_max"].toDouble(),
        pressure: json["pressure"] == null ? null : json["pressure"].toDouble(),
        humidity: json["humidity"] == null ? null : json["humidity"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "temp": temp == null ? null : temp,
        "feels_like": feelsLike == null ? null : feelsLike,
        "temp_min": tempMin == null ? null : tempMin,
        "temp_max": tempMax == null ? null : tempMax,
        "pressure": pressure == null ? null : pressure,
        "humidity": humidity == null ? null : humidity,
      };
}

class SearchWeatherResponseWind {
  SearchWeatherResponseWind({
    this.speed,
    this.deg,
  });

  double speed;
  int deg;

  factory SearchWeatherResponseWind.fromJson(Map<String, dynamic> json) =>
      SearchWeatherResponseWind(
        speed: json["speed"] == null ? null : json["speed"].toDouble(),
        deg: json["deg"] == null ? null : json["deg"],
      );

  Map<String, dynamic> toJson() => {
        "speed": speed == null ? null : speed,
        "deg": deg == null ? null : deg,
      };
}

class SearchWeatherResponseSys {
  SearchWeatherResponseSys({
    this.country,
  });

  String country;

  factory SearchWeatherResponseSys.fromJson(Map<String, dynamic> json) =>
      SearchWeatherResponseSys(
        country: json["country"] == null ? null : json["country"],
      );

  Map<String, dynamic> toJson() => {
        "country": country == null ? null : country,
      };
}

class SearchWeatherResponseClouds {
  SearchWeatherResponseClouds({
    this.all,
  });

  int all;

  factory SearchWeatherResponseClouds.fromJson(
    Map<String, dynamic> json,
  ) =>
      SearchWeatherResponseClouds(
        all: json["all"] == null ? null : json["all"],
      );

  Map<String, dynamic> toJson() => {
        "all": all == null ? null : all,
      };
}

class SearchWeatherResponseWeather {
  SearchWeatherResponseWeather({
    this.id,
    this.main,
    this.description,
    this.icon,
  });

  int id;
  String main;
  String description;
  String icon;

  factory SearchWeatherResponseWeather.fromJson(Map<String, dynamic> json) =>
      SearchWeatherResponseWeather(
        id: json["id"] == null ? null : json["id"],
        main: json["main"] == null ? null : json["main"],
        description: json["description"] == null ? null : json["description"],
        icon: json["icon"] == null ? null : json["icon"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "main": main == null ? null : main,
        "description": description == null ? null : description,
        "icon": icon == null ? null : icon,
      };
}
