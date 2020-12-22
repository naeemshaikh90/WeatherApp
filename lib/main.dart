import 'package:catcher/catcher.dart';
import 'package:flutter/material.dart';

import 'config/dependency_injection.dart';
import 'view/home_view/home_view.dart';

void main() {

  DependencyInjection().configureDependency();

  ReportMode reportMode = PageReportMode(showStackTrace: false);

  CatcherOptions options = CatcherOptions(reportMode, [ConsoleHandler()]);

  Catcher(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: Catcher.navigatorKey,
      home: MyApp(),
    ),
    debugConfig: options,
    releaseConfig: options,
    profileConfig: options,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeView(title: 'Weather'),
    );
  }
}
