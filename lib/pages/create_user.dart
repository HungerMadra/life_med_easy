import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:life_med_easy/components/text_field.dart';
import '../components/app_state.dart';
import '../components/dual_text_field.dart';
import '../components/popup_one.dart';
import 'home_page.dart';
import 'package:life_med_easy/components/popup_two.dart';


class CreateUser extends StatefulWidget {
  final AppState appState;
  const CreateUser({Key? key, required this.appState}) : super(key: key);

  @override
  CreateUserState createState() => CreateUserState();
}

class CreateUserState extends State<CreateUser> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController sexController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  bool isTest1Selected = false;
  bool isTest2Selected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            //Logo
            const Icon(
              Icons.person, 
              size: 80, 
              color: Colors.black
              ),
        
              const SizedBox(height: 25),
        
            //App Name 
            Text(
              'L I F E  M E D  E A S Y',
              style: GoogleFonts.roboto(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
        
            const SizedBox(height: 50),
        
            //Full Name Text Field

            MyTextField(
              hintText: 'Enter Full Name',
              controller: nameController),
               const SizedBox(height: 25),
        
            //Age Text Field 

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyDualTextField(
                  hintText: 'Enter Age',
                  controller: ageController,
                  ),MyDualTextField(
                    hintText: 'Male/Female',
                    controller: sexController,
                     ),
                     ],
                     ),

              const SizedBox(height: 25),
        
            //Phone Number Text Field

            MyTextField(
              hintText: 'Enter Phone Number',
              controller: numberController),
              const SizedBox(height: 25),

               // Additional Text and Checkboxes
              Text(
                'What Readings Will You Like To Track',
                style: GoogleFonts.roboto(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),

              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Checkbox(
  value: isTest1Selected,
  onChanged: (bool? value) {
    if (value != null) {
      setState(() {
        isTest1Selected = value;
        if (isTest1Selected) {
          // Show the blood pressure readings dialog
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return DialogBlood(appState: widget.appState); 
            },
          );
        }
      });
    }
  },
),

          Text(
            'Blood Pressure Readings',
            style: GoogleFonts.roboto(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    ),
Expanded(
      child: Row(
        children: [
          Checkbox(
  value: isTest2Selected,
  onChanged: (bool? value) {
    if (value != null) {
      setState(() {
        isTest2Selected = value;
        if (isTest2Selected) {
          // Show the blood pressure readings dialog
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return DialogBloodTwo(appState: widget.appState);
            },
          );
        }
      });
    }
  },
),
          Text(
            'Blood Sugar Readings',
            style: GoogleFonts.roboto(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    ),
  ],
),
const SizedBox(height: 25),
 // Complete button
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Center(
                      child: Text(
                        'Complete Setup',
                        style: GoogleFonts.roboto(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}