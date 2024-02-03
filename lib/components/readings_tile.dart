import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:life_med_easy/components/text_field.dart';
import '../models/cards.dart';

class ReadingsTile extends StatelessWidget {
  final Cards reading;

  const ReadingsTile({
    Key? key,
    required this.reading,
  }) : super(key: key);

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
        crossAxisAlignment:CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             // Icon
          AspectRatio(
            aspectRatio:1,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceVariant,
                borderRadius: BorderRadius.circular(12),
                ),
                width: double.infinity,
                padding: const EdgeInsets.all(25),
                child: Image.asset(reading.imagePath  
                ),
                ),
          ),

          const SizedBox(height: 25),

          // heading
          Text(reading.heading,
          style: GoogleFonts.roboto(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),),

          const SizedBox(height: 5),

           // description
          Text(reading.description,
          style: GoogleFonts.roboto(
                fontSize: 11,
                color: Colors.blueGrey[350],
              ),),

          const SizedBox(height: 5),

          // dateTime (Countdown)

              Row(
                children: [
                   Text('Countdown: ',
                   style: GoogleFonts.roboto(
                fontSize: 11,
                color: Colors.blueGrey[350],
                ),
                ),
                  StreamBuilder<Duration>(
                    stream: reading.countdown.countdownStream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final remainingTime = snapshot.data!;
                        final formattedTime =
                            '${remainingTime.inHours.remainder(24
                            ).toString().padLeft(2, '0')}:${remainingTime.inMinutes.remainder(60).toString().padLeft(2, '0'
                            )}:${remainingTime.inSeconds.remainder(60).toString().padLeft(2, '0')}';

                        return Text(
                          formattedTime,
                          style: GoogleFonts.roboto(
                            fontSize: 11,
                            color: Colors.red
                            ),);
                            } else {
                              return const Text('Loading...');
                              }},
                  ),
                ],
              ),
              const SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for (int index = 0; index < reading.textFieldControllers.length; index++)
              SizedBox(
                width: 70,
                height: 40,
                child: MyTextField(
                  hintText: reading.hintTexts[index],
                  controller: reading.textFieldControllers[index],
                  ),
              ),


              //Submit Button

              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceVariant,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: IconButton(onPressed: () {}, 
                icon: const Icon(Icons.keyboard_double_arrow_right_rounded, color: Colors.green, size: 30,)),
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
