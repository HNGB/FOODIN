import 'package:flutter/material.dart';
import 'package:review_restaurant/screens/login_screen.dart';
import 'package:review_restaurant/screens/signup_screen.dart';

import '../widgets/customized_button.dart';

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
                height: 130,
                width: 180,
                child: Image(
                  image: AssetImage("assets/icons/logo.png"),
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 40),
              CustomizedButton(
                buttonText: "Login",
                buttonColor: const Color.fromARGB(255, 211, 7, 7),
                textColor: Colors.white,
                textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                  );
                },
              ),
              CustomizedButton(
                buttonText: "Register",
                buttonColor: Colors.white,
                textColor: Colors.black,
                textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const SignUpScreen()),
                  );
                },
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  "Continue as a Guest",
                  style: TextStyle(color: Color(0xff35C2C1), fontSize: 25),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}