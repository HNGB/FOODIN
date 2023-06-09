import 'package:flutter/material.dart';
import 'package:review_restaurant/screens/city_selection_screen.dart';
import 'package:review_restaurant/screens/home_screen.dart';
import 'package:review_restaurant/screens/login_screen.dart';
import 'package:review_restaurant/screens/newlogin_screen.dart';
import 'package:review_restaurant/screens/restaurant_list_screen.dart';
import 'package:review_restaurant/screens/restaurant_detail_screen.dart';
import 'package:review_restaurant/screens/welcome_screen.dart';

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
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginPage(),
    );
  }
}
