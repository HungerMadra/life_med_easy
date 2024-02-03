import 'package:flutter/material.dart';
import 'package:life_med_easy/models/countdown.dart';

class Cards {
  final String imagePath;
  final Countdown countdown; // Use Countdown for dynamic countdown logic
  final List<TextEditingController> textFieldControllers;
  final String heading;
  final String description;
  final List<String> hintTexts;

  Cards({
    required this.imagePath,
    required DateTime targetDateTime,
    required this.heading,
    required this.description,
    required this.textFieldControllers,
    required this.hintTexts,
  }) : countdown = Countdown(targetDateTime);

  // Add other methods as needed
}


