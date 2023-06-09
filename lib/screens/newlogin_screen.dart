import 'package:flutter/material.dart';
import 'package:review_restaurant/screens/signup_screen.dart';

import '../component/my_button.dart';
import '../component/my_textfield.dart';
import '../component/square_tile.dart';
import 'city_selection_screen.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  // text editing controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  // sign user in method
  void signUserIn(BuildContext context) {
    // Perform sign-in operations

    // Navigate to CitySelectionScreen
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CitySelectionScreen()),
    );
  }

  void navigateToSignUpScreen(BuildContext context) {
    // Navigate to SignUpScreen
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignUpScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            // image: DecorationImage(
            //   image: AssetImage("assets/images/Frame1.png"),
            //   fit: BoxFit.cover,
            // ),
            ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    child: Text(
                      "FOODIN",
                      style: TextStyle(
                        fontSize: 48, // Kích thước văn bản
                        fontWeight: FontWeight.bold, // Đậm
                        color: Colors.orange, // Màu văn bản
                      ),
                    ),
                  ),
                  // const SizedBox(height: 50),
                  // const Icon(
                  //   Icons.lock,
                  //   size: 100,
                  //   color: Colors.white, // Chỉnh màu chữ thành màu trắng
                  // ),
                  const SizedBox(height: 50),
                  // Text(
                  //   'Welcome back you\'ve been missed!',
                  //   style: TextStyle(
                  //     color: const Color.fromARGB(255, 233, 22, 22), // Chỉnh màu chữ thành màu trắng
                  //     fontSize: 16,
                  //     fontWeight: FontWeight.bold, // Tăng độ đậm của chữ
                  //   ),
                  // ),
                  const SizedBox(height: 25),

                  // username textfield
                  MyTextField(
                    controller: usernameController,
                    hintText: 'Username',
                    obscureText: false,
                  ),

                  const SizedBox(height: 10),

                  // password textfield
                  MyTextField(
                    controller: passwordController,
                    hintText: 'Password',
                    obscureText: true,
                  ),

                  const SizedBox(height: 10),

                  // forgot password?
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Forgot Password?',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 25),

                  // sign in button
                  MyButton(
                    onTap: () =>
                        signUserIn(context), // Pass the context to signUserIn
                  ),

                  const SizedBox(height: 50),

                  // or continue with
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: Colors.grey[400],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            'Or continue with',
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: Colors.grey[400],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 50),

                  // google + apple sign in buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      // google button
                      SquareTile(imagePath: 'assets/images/google.png'),

                      SizedBox(width: 25),

                      // apple button
                      SquareTile(
                          imagePath: 'assets/images/Facebook_Logo_(2019).png')
                    ],
                  ),

                  const SizedBox(height: 25),

                  // not a member? register now
                  GestureDetector(
                      onTap: () => navigateToSignUpScreen(context),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Not a member?',
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                          const SizedBox(width: 4),
                          const Text(
                            'Register now',
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
