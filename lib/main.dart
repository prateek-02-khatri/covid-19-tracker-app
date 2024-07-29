import 'package:covid_19_tracker_app/screen/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const Covid19TrackerApp());
}

class Covid19TrackerApp extends StatelessWidget {
  const Covid19TrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Covid-19-Tracker",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey.shade900,
      ),
      home: const SplashScreen(),
    );
  }
}
