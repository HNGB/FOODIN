import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:review_restaurant/model/district.dart';
import 'package:review_restaurant/screens/subscription_screen.dart';
import 'package:review_restaurant/service/district_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/City.dart';
import '../model/user.dart';
import 'home_screen.dart';

class DistrictSelectionScreen extends StatefulWidget {
  final City city;

  const DistrictSelectionScreen({Key? key, required this.city})
      : super(key: key);

  @override
  _DistrictSelectionScreenState createState() =>
      _DistrictSelectionScreenState();
}

class _DistrictSelectionScreenState extends State<DistrictSelectionScreen> {
  District? selectedDistrict;
  List<District> districts = [];
  DistrictService districtService = DistrictService();
  User? user;
  @override
  void initState() {
    super.initState();
    setStatusBarColor(Colors.white);
    loadDistricts();
    getUserFromSharedPreferences();
  }

  void saveCityAndDistrictToLocalStorage(District district) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String cityJson = jsonEncode(widget.city.toJson());
    String districtJson = jsonEncode(district.toJson());
    await prefs.setString('city', cityJson);
    await prefs.setString('district', districtJson);
  }

  void loadDistricts() async {
    try {
      List<District> fetchedDistricts =
          await districtService.getDistrictsByCityId(widget.city.cityId);
      setState(() {
        districts = fetchedDistricts;
      });
    } catch (e) {
      print('Error loading districts: $e');
    }
  }

  void setStatusBarColor(Color color) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: color,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
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
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.red),
      ),
      body: Container(
        color: Colors.white,
        child: Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'You have selected a city: ${widget.city.cityName}',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                DropdownButtonHideUnderline(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Colors.orange[300],
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: DropdownButtonFormField<District>(
                      value: selectedDistrict,
                      decoration: InputDecoration(
                        enabledBorder: InputBorder.none,
                        hintText: 'Select district',
                        hintStyle: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      items: districts.map((district) {
                        return DropdownMenuItem<District>(
                          value: district,
                          child: Text(
                            district.districtName,
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedDistrict = value;
                          saveCityAndDistrictToLocalStorage(value!);
                        });
                        if (selectedDistrict != null) {
                          if (user!.subscriptionStatus == false) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    SubscriptionScreen(screen: "Home"),
                              ),
                            );
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomeScreen(
                                  city: widget.city,
                                  district: selectedDistrict!,
                                ),
                              ),
                            );
                          }
                        }
                      },
                    ),
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
