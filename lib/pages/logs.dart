import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:life_med_easy/components/logs_tile.dart';
import 'insights.dart';

class Logs extends StatefulWidget {
  const Logs({Key? key}) : super(key: key);

  @override
  State<Logs> createState() => _LogsState();
}

class _LogsState extends State<Logs> {
  int _selectedIndex = 0;

  void navigateBottomNavBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    // Use ListView.builder only if you need dynamic content, otherwise, you can use a Column
    ListView(
      children: [
        //Reading Title
        Center(
          child: Text(
            'Logged Readings:',
            style: GoogleFonts.roboto(
              fontSize: 12,
              color: Colors.blueGrey[350],
            ),
          ),
        ),
        //Reading Subtitle

        //Reading Description
        const SizedBox(
          height: 500,
          child: LogsTile(), // Display LogsTile to show both pressure and sugar logs
        ),
      ],
    ),
    const Logs(),
    const Insights(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: _pages[_selectedIndex],
    );
  }
}
