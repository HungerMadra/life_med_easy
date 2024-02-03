import 'package:flutter/material.dart';
import 'package:life_med_easy/components/app_state.dart';
import 'package:life_med_easy/pages/intro_page.dart';

void main() {
  // Initialize AppState
  AppState appState = AppState();
  runApp(MyApp(appState: appState));
}

class MyApp extends StatelessWidget {
  final AppState appState; // Add this line

  const MyApp({Key? key, required this.appState}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: IntroPage(appState:appState),
    );
  }
}

