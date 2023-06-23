import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:review_restaurant/screens/payment_success_screen.dart';
import 'package:review_restaurant/service/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/user.dart';

class PaymentScreen extends StatefulWidget {
  PaymentScreen({Key? key}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  TextEditingController cardNumberController = TextEditingController();

  TextEditingController cardHolderController = TextEditingController();

  TextEditingController expiryDateController = TextEditingController();

  TextEditingController cvvController = TextEditingController();

  UserService userService = UserService();

  User? user;

  @override
  void initState() {
    super.initState();
    getUserFromSharedPreferences();
  }

  void getUserFromSharedPreferences() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userJson = prefs.getString('user');

      if (userJson != null) {
        Map<String, dynamic> userMap = jsonDecode(userJson);
        User fetchedUser = User.fromJson(userMap);

        setState(() {
          user = fetchedUser;
        });
      } else {
        throw Exception('User data not found in SharedPreferences');
      }
    } catch (e) {
      print('Error loading user data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text('Payment'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              alignment: Alignment.centerRight,
              children: [
                Container(
                  height: 60.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: Colors.grey),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: cardNumberController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Card Number',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // CachedNetworkImage(
                //   imageUrl:
                //       'https://luatvietan.vn/wp-content/uploads/2014/07/dich-vu-visa.jpg', // Thay thế bằng URL thật
                //   height: 10.0,
                // ),
              ],
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: cardHolderController,
              decoration: InputDecoration(
                labelText: 'Card Holder Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: expiryDateController,
                    decoration: InputDecoration(
                      labelText: 'Expiry Date',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 16.0),
                Expanded(
                  child: TextFormField(
                    controller: cvvController,
                    decoration: InputDecoration(
                      labelText: 'CVV',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                userService
                    .changeSubcriptionStatus(user!.userId)
                    .then((value) => {
                          if (value)
                            {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        PaymentSuccessScreen()),
                              ),
                            }
                          else
                            {null}
                        });
              },
              child: Text('Submit Payment'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                primary: Colors.orange, // Màu cam chủ đạo
              ),
            ),
          ],
        ),
      ),
    );
  }
}
