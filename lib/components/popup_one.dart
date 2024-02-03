import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:life_med_easy/components/app_state.dart';

class DialogBlood extends StatefulWidget {
  final AppState appState; // Add this line

  const DialogBlood({Key? key, required this.appState}) : super(key: key); // Modify the constructor

  @override
  DialogBloodState createState() => DialogBloodState();
}

class DialogBloodState extends State<DialogBlood> {

  @override
  Widget build(BuildContext context) {
    // Access variables from AppState
    bool isMorningSelected = widget.appState.isMorningSelected;
    bool isNoonSelected = widget.appState.isNoonSelected;
    bool isEveSelected = widget.appState.isEveSelected;
    String selectedMorningReminder = widget.appState.selectedMorningReminder;// Representing "Yes" or "No" for morning
    String selectedNoonReminder = widget.appState.selectedNoonReminder;// Representing "Yes" or "No" for noon
    String selectedEveningReminder = widget.appState.selectedEveningReminder;// Representing "Yes" or "No" for evening
    return AlertDialog(
      backgroundColor: Colors.grey[300], // Set the background color of the dialog
      title: Text("Make Selections Below",
          style: GoogleFonts.roboto(color: Colors.black), 
          textAlign: TextAlign.center
          ),
      content: Column(
        children: [
          buildCard("Morning", isMorningSelected, selectedMorningReminder),
          buildCard("Afternoon", isNoonSelected, selectedNoonReminder),
          buildCard("Evening", isEveSelected, selectedEveningReminder),
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

  Widget buildCard(String title, bool isSelected, String selectedReminder) {
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
                    case 'Morning':
                      widget.appState.isMorningSelected = value!;
                      break;
                    case 'Afternoon':
                      widget.appState.isNoonSelected = value!;
                      break;
                    case 'Evening':
                      widget.appState.isEveSelected = value!;
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
                    style: GoogleFonts.roboto(color: Colors.black)
                    ),
                DropdownButton<String>(
                  value: selectedReminder,
                  onChanged: (String? newValue) {
                    // Handle dropdown state change
                    if (newValue != null) {
                      setState(() {
                        switch (title) {
                          case 'Morning':
                            widget.appState.selectedMorningReminder = newValue;
                            break;
                          case 'Afternoon':
                            widget.appState.selectedNoonReminder = newValue;
                            break;
                          case 'Evening':
                            widget.appState.selectedEveningReminder = newValue;
                            break;
                        }
                      });
                    }
                  },
                  items: <String>['', 'Yes', 'No']
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
