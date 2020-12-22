import 'package:flutter/material.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:location/location.dart';
import 'package:weather_app/view/home_view/home_view_model.dart';

import 'home_view_widgets.dart';

class HomeView extends StatefulWidget {
  HomeView({Key key, this.title}) : super(key: key);

  final String title;

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends State<HomeView> {
  // View Model
  HomeViewModel viewModel = Injector().get<HomeViewModel>();

  @override
  void initState() {
    super.initState();

    searchWeatherData();
  }

  @override
  void setState(fn) {
    if (!mounted) return;
    super.setState(fn);
  }

  /// Networking
  void searchWeatherData() async {
    // Get user's lat long
    double _latitude;
    double _longitude;

    LocationData _locationData = await viewModel.getLocation();
    if (_locationData != null) {
      _latitude = _locationData.latitude;
      _longitude = _locationData.longitude;
    }

    String cityName = await viewModel.getCityName(
      latitude: _latitude,
      longitude: _longitude,
    );
    print("cityName: $cityName");

    viewModel.searchWeatherData(
      cityName: cityName,
      longitude: _longitude,
      latitude: _latitude,
      onCompletion: () {
        setState(() {});
      },
    );
  }

  /// UI
  Widget buildBodyContent() {
    if (viewModel.isLoading) {
      return showCircularProgressIndicator();
    } else {
      var children = <Widget>[];
      if (viewModel.getErrorMessage().isEmpty) {
        children.add(temperatureCell());
      } else {
        children.add(errorCell());
      }

      return Container(
        child: ListView(
          children: children,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: buildBodyContent(),
      ),
    );
  }
}
