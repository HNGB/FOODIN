import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/City.dart';
import '../model/district.dart';
import 'home_screen.dart';

class PaymentSuccessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle_outline,
              color: Colors.green,
              size: 100.0,
            ),
            SizedBox(height: 16.0),
            Text(
              'Payment Successful',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.green, // Chi tiết màu đỏ
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                String? cityJson = prefs.getString('city');
                String? districtJson = prefs.getString('district');

                if (cityJson != null && districtJson != null) {
                  City? city = City.fromJson(json.decode(cityJson));
                  District? district =
                      District.fromJson(json.decode(districtJson));

                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(
                        city: city,
                        district: district,
                      ),
                    ),
                    (route) => false,
                  );
                }
              },
              child: Text('Back to Home'),
              style: ElevatedButton.styleFrom(
                primary: Colors.orange, // Màu cam
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white, // Màu trắng tổng thể
    );
  }
}
