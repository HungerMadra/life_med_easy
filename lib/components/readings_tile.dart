import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:life_med_easy/components/text_field.dart'; // Import custom text field widget
import '../models/cards.dart'; // Import the Cards model

class ReadingsTile extends StatelessWidget {
  final Cards reading; // Instance of the Cards model representing the reading

  // Constructor for ReadingsTile
  const ReadingsTile({
    Key? key,
    required this.reading,
  }) : super(key: key);

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
                  child: Image.asset(reading.imagePath),
                ),
              ),

              const SizedBox(height: 25),

              // Displaying heading text
              Text(
                reading.heading,
                style: GoogleFonts.roboto(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),

              const SizedBox(height: 5),

              // Displaying description text
              Text(
                reading.description,
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
                    stream: reading.countdown.countdownStream,
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
                  for (int index = 0; index < reading.textFieldControllers.length; index++)
                    SizedBox(
                      width: 70,
                      height: 40,
                      child: MyTextField(
                        hintText: reading.hintTexts[index],
                        controller: reading.textFieldControllers[index],
                      ),
                    ),

                  // Submit Button
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surfaceVariant,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      onPressed: () {},
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
