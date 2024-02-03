import 'package:flutter/material.dart';

class Insights extends StatefulWidget {
  const Insights({super.key});

  @override
  State<Insights> createState() => _InsightsState();
}

class _InsightsState extends State<Insights> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: const Center(
        child: Text('Insights Page Content- Work In Progress'),
        ),
     
    );
  }
}