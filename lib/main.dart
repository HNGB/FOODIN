import 'package:flutter/material.dart';
import 'package:review_restaurant/screens/newlogin_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Food Review App',
      home: LoginPage(),
    );
  }
}
