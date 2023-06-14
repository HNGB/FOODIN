import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:review_restaurant/screens/welcome_screen.dart';
import 'package:review_restaurant/screens/widgets/customized_button.dart';
import 'package:review_restaurant/screens/widgets/customized_textfield.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../component/my_button.dart';
import '../component/my_textfield.dart';
import '../component/signinButton.dart';
import '../component/square_tile.dart';
import 'city_selection_screen.dart';
import 'login_screen.dart';
import 'newlogin_screen.dart';
import 'package:http/http.dart' as http;

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final fullNameController = TextEditingController();
  void signUserIn(BuildContext context, String username, password, gmail,
      fullName, phoneNumber) async {
    // Perform sign-in operations
    try {
      Map<String, dynamic> body = {
        'userName': username,
        'fullName': fullName,
        'email': gmail,
        'phoneNumber': phoneNumber,
        'password': password
      };

      http.Response response = await http.post(
        Uri.parse('https://foodiapi.azurewebsites.net/api/User/Register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        // Parse the response JSON
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Register success!, Login now'),
          ),
        );
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      } else {
        // Handle other status codes if needed
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Registration failed. Please check and re-enter.'),
          ),
        );
      }
    } catch (e) {
      print(e.toString());
    }
    // Navigate to CitySelectionScreen
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white, // Màu nền trắng

        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.orange, width: 1), // Màu viền đỏ
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios_sharp),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  child: Center(
                    child: Text(
                      "Register",
                      style: TextStyle(
                        fontSize: 48, // Kích thước văn bản
                        fontWeight: FontWeight.bold, // Đậm
                        color: Colors.orange, // Màu văn bản
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                MyTextField(
                  controller: usernameController,
                  hintText: 'Username',
                  obscureText: false,
                ),

                const SizedBox(height: 10),
                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),
                const SizedBox(height: 10),
                // password textfield
                MyTextField(
                  controller: emailController,
                  hintText: 'Gmail',
                  obscureText: false,
                ),
                const SizedBox(height: 10),
                MyTextField(
                  controller: fullNameController,
                  hintText: 'Full name',
                  obscureText: false,
                ),
                const SizedBox(height: 10),

                // password textfield
                MyTextField(
                  controller: phoneNumberController,
                  hintText: 'Phone number',
                  obscureText: false,
                ),
                const SizedBox(height: 10),

                SigninButton(
                  onTap: () => signUserIn(
                      context,
                      usernameController.text.toString(),
                      passwordController.text.toString(),
                      emailController.text.toString(),
                      fullNameController.text.toString(),
                      phoneNumberController.text
                          .toString()), // Pass the context to signUserIn
                ),

                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Container(
                        height: 1,
                        width: MediaQuery.of(context).size.height * 0.17,
                        color: Colors.grey,
                      ),
                      const Text("Or Register with"),
                      Container(
                        height: 1,
                        width: MediaQuery.of(context).size.height * 0.16,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    // google button
                    SquareTile(imagePath: 'assets/images/google.png'),

                    SizedBox(width: 10),

                    // apple button
                    SquareTile(
                        imagePath: 'assets/images/Facebook_Logo_(2019).png')
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(55, 8, 8, 8.0),
                  child: Row(
                    children: [
                      const Text(
                        "Already have an account?",
                        style: TextStyle(
                          color: Color(0xff1E232C),
                          fontSize: 15,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => LoginPage(),
                            ),
                          );
                        },
                        child: const Text(
                          "  Login Now",
                          style: TextStyle(
                            color: Color(0xff35C2C1),
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
