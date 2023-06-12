import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:review_restaurant/screens/settings_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/City.dart';
import '../../model/district.dart';
import '../home_screen.dart';

class MyFooter extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTabChanged;

  MyFooter({required this.currentIndex, required this.onTabChanged});

  Future<void> _onTabChanged(int index, BuildContext context) async {
    if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SettingsScreen()),
      );
    } else if (index == 0) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? cityJson = prefs.getString('city');
      String? districtJson = prefs.getString('district');

      if (cityJson != null && districtJson != null) {
        City? city = City.fromJson(json.decode(cityJson));
        District? district = District.fromJson(json.decode(districtJson));

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(city: city, district: district),
          ),
        );
      } else {
        // Handle case when city or district is not available
      }
    } else {
      onTabChanged(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      padding: EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: Icon(
              Icons.home,
              size: _getCurrentTabSize(0),
              color: _getCurrentTabColor(0),
            ),
            onPressed: () => _onTabChanged(0, context),
          ),
          IconButton(
            icon: Icon(
              Icons.favorite,
              size: _getCurrentTabSize(1),
              color: _getCurrentTabColor(1),
            ),
            onPressed: () => _onTabChanged(1, context),
          ),
          IconButton(
            icon: Icon(
              Icons.settings,
              size: _getCurrentTabSize(2),
              color: _getCurrentTabColor(2),
            ),
            onPressed: () => _onTabChanged(2, context),
          ),
        ],
      ),
    );
  }

  double _getCurrentTabSize(int tabIndex) {
    return currentIndex == tabIndex ? 30.0 : 24.0;
  }

  Color _getCurrentTabColor(int tabIndex) {
    return currentIndex == tabIndex ? Colors.red : Colors.black;
  }
}
