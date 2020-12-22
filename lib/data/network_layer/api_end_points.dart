enum EnvironmentTypes { DEV, QA, PROD }

class ApiEndPoints {

  String _dev = "";
  String _qa = "";
  String _prod = "https://community-open-weather-map.p.rapidapi.com";

  String getApiEndPointUrl(EnvironmentTypes type) {
    switch (type) {
      case EnvironmentTypes.DEV:
        return _dev;
      case EnvironmentTypes.QA:
        return _qa;
      case EnvironmentTypes.PROD:
        return _prod;
      default:
        return '';
    }
  }

  String get getDefaultEndPointUrl {
    return getApiEndPointUrl(EnvironmentTypes.PROD);
  }

  String get apiKey {
    return "099cef3c5fmsha40b21845b10f1ep15de44jsn97b8bb165003";
  }

  String get apiHost {
    return "community-open-weather-map.p.rapidapi.com";
  }
}