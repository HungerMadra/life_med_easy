import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../components/app_state.dart';
import 'create_user.dart'; 

class IntroPage extends StatelessWidget {
    final AppState appState; // Declare the appState variable in the IntroPage
    const IntroPage({Key? key, required this.appState}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              
              //logo 
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Image.asset('lib/images/two.png',height: 200,),
            ),

            const SizedBox(height: 50,),
        
              //title
        
              Text('LI F E  M E D  E A S Y',
              style: GoogleFonts.roboto(fontSize: 20,
              fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15,),
              
              //sub-title
        
              Text('Take Charge Of Your Health And Meet Your Lifestyle Goals',
              style: GoogleFonts.roboto(
                fontSize: 14,
                color: Colors.black),
                textAlign: TextAlign.center,
                ),
                
              const SizedBox(height: 100,),

              //button
              
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  CreateUser(appState:appState),
                    )
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
                      child: Text('Continue',
                      style: GoogleFonts.roboto(color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      ),
                      ),
                      ),
                  ),
                ),
              ),
              const SizedBox(height: 24,),
              ],
          ),
        ),
      ),
    );
  }
}