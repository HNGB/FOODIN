import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:review_restaurant/model/district.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/City.dart';
import '../model/restaurant.dart';
import '../model/user.dart';
import 'restaurant_detail_screen.dart';
import 'package:review_restaurant/service/restaurant_service.dart';

class RestaurantListScreen extends StatefulWidget {
  final City city;
  final District district;
  final TextEditingController searchController;

  RestaurantListScreen({
    required this.city,
    required this.district,
    required this.searchController,
  });

  @override
  _RestaurantListScreenState createState() => _RestaurantListScreenState();
}

class _RestaurantListScreenState extends State<RestaurantListScreen> {
  RestaurantService restaurantService = RestaurantService();
  List<Restaurant> restaurants = [];
  List<Restaurant> filteredRestaurants = [];
  List<int> favoriteRestaurantIds = [];
  String searchKeyword = '';
  User? user;

  void navigateToRestaurantDetail(int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RestaurantDetailScreen(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    loadRestaurants();
    getUserFromSharedPreferences();
  }

  void loadRestaurants() async {
    try {
      List<Restaurant> fetchedRestaurants = await restaurantService
          .getRestaurantsByDistrictId(widget.district.districtId);
      setState(() {
        restaurants = fetchedRestaurants;
        filteredRestaurants = fetchedRestaurants;
        filterRestaurants();
      });
    } catch (e) {
      print('Error loading restaurants: $e');
    }
  }

  void filterRestaurants() {
    if (widget.searchController.text.isEmpty) {
      setState(() {
        filteredRestaurants = restaurants;
      });
    } else {
      setState(() {
        filteredRestaurants = restaurants
            .where((restaurant) => restaurant.resName
                .toLowerCase()
                .contains(widget.searchController.text.toLowerCase()))
            .toList();
      });
    }
  }

  void showErrorSnackBar() {
    const snackBar = SnackBar(
      content: Text('Failed to add restaurant to favorites.'),
      duration: Duration(seconds: 3),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void getUserFromSharedPreferences() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userJson = prefs.getString('user');

      if (userJson != null) {
        Map<String, dynamic> userMap = jsonDecode(userJson);
        User fetchedUser = User.fromJson(userMap);

        List<Restaurant> favoriteRestaurants = await restaurantService
            .getFavoriteRestaurantsByUserId(fetchedUser.userId);

        setState(() {
          user = fetchedUser;
          favoriteRestaurantIds = favoriteRestaurants
              .map((restaurant) => restaurant.restaurantId)
              .toList();
        });
      } else {
        throw Exception('User data not found in SharedPreferences');
      }
    } catch (e) {
      print('Error loading user data: $e');
    }
  }

  bool isRestaurantFavorite(int restaurantId) {
    return favoriteRestaurantIds.contains(restaurantId);
  }

  void addToFavorites(int restaurantId) async {
    try {
      if (user != null) {
        setState(() {
          favoriteRestaurantIds.add(restaurantId);
        });

        await restaurantService.addToFavorite(
          user!.userId,
          restaurantId,
        );
      }
    } catch (e) {
      setState(() {
        favoriteRestaurantIds.remove(restaurantId);
      });
      showErrorSnackBar();
    }
  }

  void removeFromFavorites(int restaurantId) async {
    try {
      if (user != null) {
        setState(() {
          favoriteRestaurantIds.remove(restaurantId);
        });

        await restaurantService.addToFavorite(
          user!.userId,
          restaurantId,
        );
      }
    } catch (e) {
      setState(() {
        favoriteRestaurantIds.add(restaurantId);
      });
      showErrorSnackBar();
    }
  }

  void toggleFavorite(int restaurantId) {
    if (isRestaurantFavorite(restaurantId)) {
      removeFromFavorites(restaurantId);
    } else {
      addToFavorites(restaurantId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.red),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              '${widget.district.districtName}, ',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.orange[400],
              ),
            ),
            Text(
              '${widget.city.cityName} City',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.orange[400],
              ),
            ),
            Spacer(),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              controller: widget.searchController,
              onChanged: (value) {
                searchKeyword = value;
                filterRestaurants();
              },
              decoration: InputDecoration(
                hintText: 'Search for restaurants',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(18)),
                suffixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.8,
              ),
              itemCount: filteredRestaurants.length,
              itemBuilder: (context, index) {
                final restaurant = filteredRestaurants[index];
                final bool isRestaurantFav =
                    isRestaurantFavorite(restaurant.restaurantId);
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () => navigateToRestaurantDetail(index),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.0),
                          color: Color.fromARGB(255, 231, 231, 231),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16.0),
                                child: Image.network(
                                  restaurant.avatar,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: double.infinity,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                restaurant.resName,
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: Colors.yellow[800],
                                      ),
                                      Text(
                                        restaurant.calculatedRating.toString(),
                                        style: TextStyle(color: Colors.black87),
                                      ),
                                    ],
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.favorite,
                                      color: isRestaurantFav
                                          ? Colors.red
                                          : Colors.grey,
                                    ),
                                    onPressed: () {
                                      toggleFavorite(restaurant.restaurantId);
                                    },
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
              },
            ),
          ),
        ],
      ),
    );
  }
}
