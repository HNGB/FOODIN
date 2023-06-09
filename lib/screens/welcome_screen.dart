import 'package:flutter/material.dart';
import 'package:review_restaurant/screens/city_selection_screen.dart';
import 'package:review_restaurant/screens/home_screen.dart';
import 'package:review_restaurant/screens/login_screen.dart';
import 'package:review_restaurant/screens/signup_screen.dart';
import 'package:review_restaurant/screens/widgets/customized_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FractionallySizedBox(
        heightFactor: 1.0,
        widthFactor: 1.0,
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/Frame1.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const SizedBox(
                child: Image(
                  image: AssetImage("assets/images/logo.png"),
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 40),
              CustomizedButton(
                buttonText: "Login",
                buttonColor: const Color.fromARGB(255, 211, 7, 7),
                textColor: Colors.white,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                  );
                },
              ),
              CustomizedButton( 
                buttonText: "Register",
                buttonColor: Colors.orange,
                textColor: Colors.white,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const SignUpScreen()),
                  );
                },
              ),
              const SizedBox(height: 20),
              // Padding(
              //   padding: EdgeInsets.all(10.0),
              //   child: InkWell(
              //     onTap: () {
              //       Navigator.push(
              //         context,
              //         MaterialPageRoute(builder: (context) => CitySelectionScreen()),
              //       );
              //       print("Continue as a Guest pressed");
              //     },
              //     child: const Text(
              //       "Continue as a Guest",
              //       style: TextStyle(
              //         fontFamily: "OpenSans",
              //         color: Color(0xff35C2C1),
              //         fontSize: 18,
              //         fontWeight: FontWeight.bold,
              //         decoration: TextDecoration.underline,
              //       ),
              //     ),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}