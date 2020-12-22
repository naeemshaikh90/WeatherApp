import 'package:flutter/material.dart';
import 'package:weather_app/view/home_view/home_view.dart';

extension HomeViewWidgets on HomeViewState {
  Widget showCircularProgressIndicator() {
    return Container(
      padding: EdgeInsets.only(bottom: 15),
      child: Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.white,
        ),
      ),
    );
  }

  Widget textCell({double fontSize, String text}) {
    return RichText(
      softWrap: true,
      text: TextSpan(
        style: TextStyle(
          color: Colors.deepPurple,
          fontSize: fontSize,
        ),
        children: [
          TextSpan(text: text),
        ],
      ),
    );
  }

  Widget temperatureCell() {
    return Container(
      padding: EdgeInsets.only(top: 40),
      alignment: Alignment.center,
      child: Column(
        children: [
          // City
          textCell(fontSize: 35, text: viewModel.uiModel.cityName),

          // Weather Type
          textCell(fontSize: 20, text: viewModel.uiModel.weatherType),

          Padding(padding: EdgeInsets.only(bottom: 32)),

          // Current
          textCell(fontSize: 50, text: viewModel.uiModel.currentTemperature),

          Padding(padding: EdgeInsets.only(bottom: 8)),

          // Min & Max
          textCell(
              fontSize: 23,
              text: "${viewModel.uiModel.minimumTemperature} "
                  "${viewModel.uiModel.maximumTemperature}"),

          Padding(padding: EdgeInsets.only(bottom: 4)),

          // Feels Like
          textCell(fontSize: 23, text: viewModel.uiModel.feelsLikeTemperature),

          Padding(padding: EdgeInsets.only(bottom: 32)),

          // Pressure & Humidity
          textCell(fontSize: 23, text: viewModel.uiModel.pressure),

          Padding(padding: EdgeInsets.only(bottom: 4)),

          // Humidity
          textCell(fontSize: 23, text: viewModel.uiModel.humidity),

          Padding(padding: EdgeInsets.only(bottom: 4)),

          // Wind Speed
          textCell(fontSize: 23, text: viewModel.uiModel.windSpeed),
        ],
      ),
    );
  }

  Widget errorCell() {
    return Center(
      child: textCell(
        fontSize: 20,
        text: viewModel.getErrorMessage(),
      ),
    );
  }
}
