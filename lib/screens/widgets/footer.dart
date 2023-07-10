import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:review_restaurant/screens/favorite_restaurant_screen.dart';
import 'package:review_restaurant/screens/newsfeed.dart';
import 'package:review_restaurant/screens/settings_screen.dart';
import 'package:review_restaurant/screens/voucher_list_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/City.dart';
import '../../model/district.dart';
import '../../model/user.dart';
import '../home_screen.dart';
import '../subscription_screen.dart';

class MyFooter extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTabChanged;

  const MyFooter(
      {super.key, required this.currentIndex, required this.onTabChanged});

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
    } else if (index == 3) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userJson = prefs.getString('user');

      Map<String, dynamic> userMap = jsonDecode(userJson!);
      User fetchedUser = User.fromJson(userMap);
      if (fetchedUser.subscriptionStatus == false) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const SubscriptionScreen(screen: "NewsFeed"),
          ),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NewsfeedScreen()),
        );
      }
    } else if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => FavoriteRestaurantScreen()),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const VouchersScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
        color: Colors.white,
      ),
      padding: const EdgeInsets.all(1.0),
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
              Icons.wysiwyg_sharp,
              size: _getCurrentTabSize(3),
              color: _getCurrentTabColor(3),
            ),
            onPressed: () => _onTabChanged(3, context),
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
              Icons.card_giftcard_outlined,
              size: _getCurrentTabSize(4),
              color: _getCurrentTabColor(4),
            ),
            onPressed: () => _onTabChanged(4, context),
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
    return currentIndex == tabIndex
        ? Colors.orange.shade800
        : const Color.fromARGB(255, 135, 135, 135);
  }
}
