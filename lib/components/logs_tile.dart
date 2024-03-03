import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'readings_tile.dart'; // Import the ReadingsTile class

class LogsTile extends StatefulWidget {
  const LogsTile({Key? key}) : super(key: key);

  @override
  State<LogsTile> createState() => _LogsTileState();
}

class _LogsTileState extends State<LogsTile> {
  late List<Map<String, dynamic>> _pressureLog = [];
  late List<Map<String, dynamic>> _sugarLog = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchPressureLog();
//    _fetchSugarLog();
  }

  Future<void> _fetchPressureLog() async {
    final database = await ReadingsTile.getDatabase();
    _pressureLog = await database.query('pressure_log');
    setState(() {
      _isLoading = false;
    });
  }

//Uncoment the below code to fetch sugar log

  // Future<void> _fetchSugarLog() async {
  //   final database = await ReadingsTile.getDatabase();
  //   //TODO: Replace 'pressure_log' with 'sugar_log'
  //   _sugarLog = await database.query('pressure_log');
  //   setState(() {
  //     _isLoading = false;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(child: CircularProgressIndicator())
        : Container(
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
                // Displaying pressure log data
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Blood Pressure Log',
                      style: GoogleFonts.roboto(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    for (var entry in _pressureLog)
                      Text(
                        'Syst: ${entry['syst']}, Dias: ${entry['dias']}',
                        style: GoogleFonts.roboto(
                          fontSize: 12,
                          color: Colors.blueGrey[350],
                        ),
                      ),
                  ],
                ),
                // Displaying sugar log data
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Blood Sugar Log',
                      style: GoogleFonts.roboto(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    for (var entry in _sugarLog)
                      Text(
                        'Sugar: ${entry['sugar']}',
                        style: GoogleFonts.roboto(
                          fontSize: 12,
                          color: Colors.blueGrey[350],
                        ),
                      ),
                  ],
                ),
              ],
            ),
          );
  }
}
