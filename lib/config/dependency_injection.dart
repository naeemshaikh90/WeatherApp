import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:weather_app/data/domain_mapper/domain_mapper.dart';
import 'package:weather_app/data/network_layer/api_exception_mesages.dart';
import 'package:weather_app/data/network_layer/api_services.dart';
import 'package:weather_app/data/network_layer/network_service.dart';
import 'package:weather_app/data/weather_api/weather_api.dart';
import 'package:weather_app/data_accessor/weather_data_accessor.dart';
import 'package:weather_app/model/request_model/weather_api.dart';
import 'package:weather_app/utils/global_shared_objects.dart';
import 'package:weather_app/view/home_view/home_view_model.dart';

class DependencyInjection {
  static final DependencyInjection _injector = DependencyInjection._internal();

  factory DependencyInjection() {
    return _injector;
  }

  DependencyInjection._internal();

  void configureDependency() {
    final injector = Injector();

    /// network_layer
    configureNetworking(injector);

    /// api_exception_messages
    configureApiExceptionMessages(injector);

    /// Home View
    configureHomeView(injector);
  }
}

/// Utilities

void configureNetworking(Injector injector) {
  injector.map<NetworkService>(
    (i) => INetworkService(),
    isSingleton: true,
  );

  injector.map<ApiServices>(
    (i) => IApiServices(),
    isSingleton: true,
  );

  injector.map<DomainMapper>(
    (i) => IDomainMapper(),
    isSingleton: true,
  );
}
void configureApiExceptionMessages(Injector injector) {
  injector.map<ApiExceptionMessages>(
    (i) => IApiExceptionMessages(),
    isSingleton: true,
  );

  apiExceptionMessages = Injector().get<ApiExceptionMessages>();
}

/// Views
void configureHomeView(Injector injector) {
  injector.map<WeatherRequest>(
    (i) => IWeatherRequest(),
    isSingleton: true,
  );

  injector.map<WeatherApi>(
    (i) => IWeatherApi(
      networkService: i.get<NetworkService>(),
      apiServices: i.get<ApiServices>(),
      domainMapper: i.get<DomainMapper>(),
    ),
    isSingleton: true,
  );

  injector.map<WeatherDataAccessor>(
    (i) => IWeatherDataAccessor(
      weatherApi: i.get<WeatherApi>(),
    ),
    isSingleton: true,
  );

  injector.map<HomeViewModel>(
    (i) => IHomeViewModel(
      weatherRequest: i.get<WeatherRequest>(),
      weatherDataAccessor: i.get<WeatherDataAccessor>(),
    ),
    isSingleton: true,
  );
}
