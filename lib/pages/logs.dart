import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../components/readings_tile.dart';
import '../models/readings.dart';
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

    // Pages to display on the bottom nav bar
  final List<Widget> _pages = [
    // Use ListView.builder only if you need dynamic content, otherwise, you can use a Column
    ListView(
      children: [
        //Reading Title 
        Center(
          child: Text('Logged Readings:',
          style: GoogleFonts.roboto(
                  fontSize: 12,
                  color: Colors.blueGrey[350],
                ),),
        ),

        //Reading Subtitle 

        //Reading Description
      SizedBox(
        height: 500,
        child: ListView.builder(
          itemCount: Readings().readings.length,
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.all(15),
          itemBuilder: (context, index) {
            final reading = Readings().readings[index];
            return ReadingsTile(reading: reading);  // Use ReadingsTile to display each reading
          },
        ),
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