import 'package:flutter/material.dart';
import 'package:life_med_easy/components/bottom_nav_bar.dart';
import 'package:life_med_easy/pages/insights.dart';
import 'package:life_med_easy/pages/logs.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/readings.dart';  // Import the Readings class
import 'package:life_med_easy/components/readings_tile.dart';  // Import the ReadingsTile class

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Selected Index To Control The Bottom Nav Bar
  int _selectedIndex = 0;


  //To initialize the database when the app starts

    @override
  void initState() {
    super.initState();
  }
  
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
          child: Text('After your tests please log your readings below:',
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

      // Add your desired content here

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              color: Colors.black,
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        title: const Text(
          'L I F E  M E D  E A S Y',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
          centerTitle: true,  // Center the title horizontally
      ),

      drawer: const Drawer(),

      bottomNavigationBar: MyBottomNavBar(
        onTabChange: (index) => navigateBottomNavBar(index),
      ),

      body: _pages[_selectedIndex],
    );
  }
}
