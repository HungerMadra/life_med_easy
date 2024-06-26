import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:life_med_easy/components/text_field.dart'; // Import custom text field widget
import '../models/cards.dart'; // Import the Cards model

class ReadingsTile extends StatefulWidget {
  
  final Cards reading; // Instance of the Cards model representing the reading

  // Constructor for ReadingsTile
  const ReadingsTile({
    Key? key,
    required this.reading,
  }) : super(key: key);

  @override
  State<ReadingsTile> createState() => _ReadingsTileState();


  // Getter method to access the database instance
  static Future<Database> getDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'pressure_log_database.db'),
      version: 1, // Increment the version number
      onCreate: (db, version) {
          // Add a debug statement to indicate that onCreate is being called
  print('Database onCreate callback triggered.');
        // Create the pressure_log table
        db.execute(
          'CREATE TABLE pressure_log(id INTEGER PRIMARY KEY, syst INTEGER, dias INTEGER)',
        );
        // Create the sugar_log table
        db.execute(
          'CREATE TABLE sugar_log(id INTEGER PRIMARY KEY, a1c INTEGER)',
        );
      },
      // onUpgrade: (db, oldVersion, newVersion) {
      //   if (oldVersion < 1) {
      //     // Perform migration if necessary
      //   }
      // },
    );
  }
}

class _ReadingsTileState extends State<ReadingsTile> {

  // Create a database instance
  late Database _database;

  // Initialize the database
  void _initializeDatabase() async {
    _database = await ReadingsTile.getDatabase();
  }

  // To initialize the database when the app starts
  @override
  void initState() {
    super.initState();
    _initializeDatabase();
  }

  Future<void> _savePressureLog(BuildContext context, int syst, int dias) async {
    await _database.insert(
      'pressure_log',
      {'syst': syst, 'dias': dias},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    // Show popup dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Blood Pressure Saved',
            style: GoogleFonts.roboto(
              fontSize: 16,
              color: Colors.blueGrey[350],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'OK',
                style: GoogleFonts.roboto(
                  fontSize: 16,
                  color: Colors.blueGrey[350],
                ),
              ),
            ),
          ],
        );
      },
    );

    // Clear text fields
    for (var controller in widget.reading.textFieldControllers) {
      controller.clear();
    }

    // Print current pressure log to debug console
    print(await _getPressureLog());
  }

  Future<void> _saveSugarLog(BuildContext context, int a1c) async {
    await _database.insert(
      'sugar_log',
      {'a1c': a1c},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    // Show popup dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Blood Sugar Saved',
            style: GoogleFonts.roboto(
              fontSize: 16,
              color: Colors.blueGrey[350],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'OK',
                style: GoogleFonts.roboto(
                  fontSize: 16,
                  color: Colors.blueGrey[350],
                ),
              ),
            ),
          ],
        );
      },
    );

    // Clear text field
    widget.reading.textFieldControllers[0].clear();

    // Print current sugar log to debug console
    print(await _getSugarLog());
  }

  // Function to handle reading pressure log from the database
  Future<List<Map<String, dynamic>>> _getPressureLog() async {
    return await _database.query('pressure_log');
  }

  // Function to handle reading sugar log from the database
  Future<List<Map<String, dynamic>>> _getSugarLog() async {
    return await _database.query('sugar_log');
  }

  // Build method to create the UI for the ReadingsTile
  @override
  Widget build(BuildContext context) {
    
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(25),
      width: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Displaying an image (Icon)
              AspectRatio(
                aspectRatio: 1,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceVariant,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  width: double.infinity,
                  padding: const EdgeInsets.all(25),
                  child: Image.asset(widget.reading.imagePath),
                ),
              ),

              const SizedBox(height: 25),

              // Displaying heading text
              Text(
                widget.reading.heading,
                style: GoogleFonts.roboto(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),

              const SizedBox(height: 5),

              // Displaying description text
              Text(
                widget.reading.description,
                style: GoogleFonts.roboto(
                  fontSize: 11,
                  color: Colors.blueGrey[350],
                ),
              ),

              const SizedBox(height: 5),

              // Displaying countdown timer
              Row(
                children: [
                  Text(
                    'Countdown: ',
                    style: GoogleFonts.roboto(
                      fontSize: 11,
                      color: Colors.blueGrey[350],
                    ),
                  ),
                  // StreamBuilder to display countdown time dynamically
                  StreamBuilder<Duration>(
                    stream: widget.reading.countdown.countdownStream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final remainingTime = snapshot.data!;
                        final formattedTime =
                            '${remainingTime.inHours.remainder(24).toString().padLeft(2, '0')}:${remainingTime.inMinutes.remainder(60).toString().padLeft(2, '0')}:${remainingTime.inSeconds.remainder(60).toString().padLeft(2, '0')}';

                        return Text(
                          formattedTime,
                          style: GoogleFonts.roboto(
                            fontSize: 11,
                            color: Colors.red,
                          ),
                        );
                      } else {
                        return const Text('Loading...');
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Displaying text fields for user input
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Looping through text field controllers and creating corresponding text fields
                  for (int index = 0; index < widget.reading.textFieldControllers.length; index++)
                    SizedBox(
                      width: 70,
                      height: 40,
                      child: MyTextField(
                        hintText: widget.reading.hintTexts[index],
                        controller: widget.reading.textFieldControllers[index],
                      ),
                    ),

                  // Submit Button
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surfaceVariant,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      onPressed: () {
                        // Check index and execute corresponding action
                        if (widget.reading.heading == 'Blood Pressure') {
                          // Extract values from text fields
                          int syst = int.tryParse(widget.reading.textFieldControllers[0].text) ?? 0;
                          int dias = int.tryParse(widget.reading.textFieldControllers[1].text) ?? 0;
                          // Action for the first submit button
                          _savePressureLog(context, syst, dias);
                        } else if (widget.reading.heading == 'Blood Sugar') {
                          int a1c = int.tryParse(widget.reading.textFieldControllers[0].text) ?? 0;
                          // Action for the second submit button
                          _saveSugarLog(context, a1c);
                        }
                      },
                      icon: const Icon(Icons.keyboard_double_arrow_right_rounded, color: Colors.green, size: 30),
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
