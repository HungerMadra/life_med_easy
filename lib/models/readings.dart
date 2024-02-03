import 'package:flutter/material.dart';
import 'cards.dart';

class Readings {
  final List<Cards> _readings = [
    Cards(
      imagePath: 'lib/images/bp.png',
          // Set targetDateTime to today at 6 PM
      targetDateTime: DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day, // To set to 1 day from now update line to DateTime.now().day + 1
        18, // 6 PM
        0, // 0 minutes
      ),
      heading: 'Blood Pressure',
      description: 'Your next reading is this evening in',
      textFieldControllers: [
        TextEditingController(),
        TextEditingController(),
      ],
      hintTexts: ['SYST', 'DIAS'], // New list of hint texts
    ),
    Cards(
      imagePath: 'lib/images/bs.png',
      targetDateTime: DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day, // To set to 1 day from now update line to DateTime.now().day + 1
        18, // 6 PM
        0, // 0 minutes
      ),
      heading: 'Blood Sugar',
      description: 'Your next reading is before dinner in',
      textFieldControllers: [
        TextEditingController(),
      ],
      hintTexts: ['A1C'], // New list of hint texts
    ),
  ];

  List<Cards> get readings => _readings;
}
