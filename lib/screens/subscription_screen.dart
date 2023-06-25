import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:review_restaurant/screens/home_screen.dart';
import 'package:review_restaurant/screens/newsfeed.dart';
import 'package:review_restaurant/screens/payment_paypal_screen.dart';
import 'package:review_restaurant/screens/payment_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/City.dart';
import '../model/district.dart';

class SubscriptionScreen extends StatelessWidget {
  final String screen;

  const SubscriptionScreen({super.key, required this.screen});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 70.0),
            const Text(
              'Why go Premium?',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.orange,
              ),
            ),
            const SizedBox(height: 25.0),
            Card(
              elevation: 2.0,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
                side: const BorderSide(color: Colors.red, width: 2.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Upgrade to premium and get all the features available ',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 16.0),
                    const Text(
                      'Special for Premium:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                    ListView(
                      shrinkWrap: true,
                      children: const [
                        ListTile(
                          leading: Icon(Icons.check, color: Colors.red),
                          title: Text(
                            'Write blogs',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                        ListTile(
                          leading: Icon(Icons.check, color: Colors.red),
                          title: Text(
                            'Interact with articles',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                        ListTile(
                          leading: Icon(Icons.check, color: Colors.red),
                          title: Text(
                            'No ads',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                        ListTile(
                          leading: Icon(Icons.check, color: Colors.red),
                          title: Text(
                            'Discount Voucher',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(),
            ),
            Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PaymentPayPalScreen(
                                price: 0.99,
                              )),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                  ),
                  child: Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(16.0),
                    child: const Text(
                      '0.99\$' '/ month',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PaymentPayPalScreen(
                                price: 10.00,
                              )),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                  ),
                  child: Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(16.0),
                    child: const Text(
                      '10\$' '/ year',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () async {
                    if (screen == "Home") {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      String? cityJson = prefs.getString('city');
                      String? districtJson = prefs.getString('district');

                      if (cityJson != null && districtJson != null) {
                        City? city = City.fromJson(json.decode(cityJson));
                        District? district =
                            District.fromJson(json.decode(districtJson));
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  HomeScreen(city: city, district: district)),
                        );
                      }
                    }
                    if (screen == "NewsFeed") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NewsfeedScreen()),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                  ),
                  child: Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(16.0),
                    child: const Text(
                      'Skip',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.orange,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}
