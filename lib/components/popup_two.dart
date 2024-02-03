import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:life_med_easy/components/app_state.dart';

class DialogBloodTwo extends StatefulWidget {
  final AppState appState; // Add this line
  const DialogBloodTwo({Key? key, required this.appState}) : super(key: key);

  @override
  DialogBloodTwoState createState() => DialogBloodTwoState();
}

class DialogBloodTwoState extends State<DialogBloodTwo> {

  @override
  Widget build(BuildContext context) {
  // Access variables from AppState
  bool isBreakfastSelected = widget.appState.isBreakfastSelected;
  bool isLunchSelected = widget.appState.isLunchSelected;
  bool isDinnerSelected = widget.appState.isDinnerSelected;
  String beforeBreakfastReminder = widget.appState.beforeBreakfastReminder; // Representing "Yes" or "No" for morning
  String afterBreakfastReminder = widget.appState.afterBreakfastReminder; // Representing "Yes" or "No" for noon
  String beforeLunchReminder = widget.appState.beforeLunchReminder; // Representing "Yes" or "No" for evening
  String afterLunchReminder = widget.appState.afterLunchReminder; // Representing "Yes" or "No" for morning
  String beforeDinnerReminder = widget.appState.beforeDinnerReminder; // Representing "Yes" or "No" for noon
  String afterDinnerReminder = widget.appState.afterDinnerReminder; // Representing "Yes" or "No" for evening
    return AlertDialog(
      backgroundColor: Colors.grey[300], // Set the background color of the dialog
      title: Text("Make Selections Below",
          style: GoogleFonts.roboto(color: Colors.black),
          textAlign: TextAlign.center
      ),
      content: Column(
        children: [
          buildCard("Breakfast", isBreakfastSelected, beforeBreakfastReminder, afterBreakfastReminder),
          buildCard("Lunch", isLunchSelected, beforeLunchReminder, afterLunchReminder),
          buildCard("Dinner", isDinnerSelected, beforeDinnerReminder, afterDinnerReminder),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black, // Set the background color of the button
          ),
          child: Text(
            "Close",
            style: GoogleFonts.roboto(color: Colors.white), // Set the text color of the button
          ),
        ),
      ],
    );
  }

  Widget buildCard(String title, bool isSelected, String selectedReminder1, String selectedReminder2) {
    return Card(
      child: Column(
        children: [
          ListTile(
            title: Text(title),
            trailing: Checkbox(
              value: isSelected,
              onChanged: (bool? value) {
                // Handle checkbox state change
                setState(() {
                  switch (title) {
                    case 'Breakfast':
                      widget.appState.isBreakfastSelected = value!;
                      break;
                    case 'Lunch':
                      widget.appState.isLunchSelected = value!;
                      break;
                    case 'Dinner':
                      widget.appState.isDinnerSelected = value!;
                      break;
                  }
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Set reminder: ",
                    style: GoogleFonts.roboto(color: Colors.black)),
                DropdownButton<String>(
                  value: selectedReminder1,
                  onChanged: (String? newValue) {
                    // Handle dropdown state change
                    if (newValue != null) {
                      setState(() {
                        switch (title) {
                          case 'Breakfast':
                            widget.appState.beforeBreakfastReminder = newValue;
                            break;
                          case 'Lunch':
                            widget.appState.beforeLunchReminder = newValue;
                            break;
                          case 'Dinner':
                            widget.appState.beforeDinnerReminder = newValue;
                            break;
                        }
                      });
                    }
                  },
                  items: <String>['', 'Before', 'After']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value,
                        style: GoogleFonts.roboto(color: Colors.black),textScaleFactor: 0.75,),
                    );
                  }).toList(),
                ),
                DropdownButton<String>(
                  value: selectedReminder2,
                  onChanged: (String? newValue) {
                    // Handle dropdown state change
                    if (newValue != null) {
                      setState(() {
                        switch (title) {
                          case 'Breakfast':
                            widget.appState.afterBreakfastReminder = newValue;
                            break;
                          case 'Lunch':
                            widget.appState.afterLunchReminder = newValue;
                            break;
                          case 'Dinner':
                            widget.appState.afterDinnerReminder = newValue;
                            break;
                        }
                      });
                    }
                  },
                  items: <String>['', 'Before', 'After']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value,
                        style: GoogleFonts.roboto(color: Colors.black),textScaleFactor: 0.75),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}