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
  late final List<Map<String, dynamic>> _sugarLog = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchPressureLog();
//    _fetchSugarLog();
  }

Future<void> _fetchPressureLog() async {
  final database = await ReadingsTile.getDatabase();
  _pressureLog = await database.query('pressure_log', orderBy: 'id DESC', limit: 14); // Fetch most recent 14 readings in descending order of ID
  setState(() {
    _isLoading = false;
  });
}

//Uncoment the below code to fetch sugar log

// Future<void> _fetchSugarLog() async {
//   final database = await ReadingsTile.getDatabase();
//   _sugarLog = await database.query('sugar_log', orderBy: 'id DESC', limit: 14); // Fetch most recent 14 readings in descending order of ID
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
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceVariant,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Center(
                            child: Text(
                              'Blood Pressure Log',
                              style: GoogleFonts.roboto(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        
                        for (int i = 0; i < _pressureLog.length; i++)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${i + 1}.',
                                style: GoogleFonts.roboto(
                                  fontSize: 12,
                                  color: Colors.blueGrey[350],
                                ),
                              ),
                              Text(
                                'Syst: ${_pressureLog[i]['syst']}',
                                style: GoogleFonts.roboto(
                                  fontSize: 12,
                                  color: Colors.blueGrey[350],
                                ),
                              ),
                              Text(
                                'Dias: ${_pressureLog[i]['dias']}',
                                style: GoogleFonts.roboto(
                                  fontSize: 12,
                                  color: Colors.blueGrey[350],
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
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
