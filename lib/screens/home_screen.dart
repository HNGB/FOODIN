import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:review_restaurant/model/district.dart';
import 'package:review_restaurant/screens/restaurant_detail_screen.dart';
import 'package:review_restaurant/screens/widgets/footer.dart';
import 'package:review_restaurant/service/restaurant_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/City.dart';
import '../model/restaurant.dart';
import 'city_selection_screen.dart';
import 'restaurant_list_screen.dart';

class HomeScreen extends StatefulWidget {
  final City city;
  final District district;

  HomeScreen({required this.city, required this.district});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Restaurant> trendingRestaurants = [];
  int _currentIndex = 0;
  RestaurantService restaurantService = RestaurantService();
  TextEditingController searchController = TextEditingController();

  Future<void> _saveDataToStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('city', json.encode(widget.city.toJson()));
    await prefs.setString('district', json.encode(widget.district.toJson()));
  }

  @override
  void initState() {
    super.initState();
    _saveDataToStorage();
    loadTrendingRestaurant();
  }

  void loadTrendingRestaurant() async {
    try {
      List<Restaurant> fetchedRestaurant = await restaurantService
          .getTrendingRestaurantsByDistrictId(widget.district.districtId);
      setState(() {
        trendingRestaurants = fetchedRestaurant;
      });
    } catch (e) {
      print('Error loading districts: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 3.5,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/background.jpg'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      '${widget.district.districtName}, ',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    Text(
                      '${widget.city.cityName} City',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    Spacer(),
                    IconButton(
                      icon: Icon(Icons.location_on),
                      color: Colors.red,
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CitySelectionScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(16.0, 16, 16.0, 16),
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    hintText: 'Search for restaurants',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(18))),
                    suffixIcon: Icon(Icons.search),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RestaurantListScreen(
                          city: widget.city,
                          district: widget.district,
                          searchController: searchController,
                        ),
                      ),
                    );
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(20, 15, 20, 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Trending Restaurants',
                      style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      child: Text(
                        'Show All',
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RestaurantListScreen(
                              city: widget.city,
                              district: widget.district,
                              searchController: searchController,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              Container(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: trendingRestaurants.length,
                  itemBuilder: (context, index) {
                    final restaurant = trendingRestaurants[index];

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RestaurantDetailScreen(),
                          ),
                        );
                      },
                      child: Container(
                        width: 200,
                        margin: EdgeInsets.all(1.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: Container(
                          child: Column(
                            children: [
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16.0),
                                  child: Image.network(
                                    restaurant.avatar,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  restaurant.resName,
                                  style: TextStyle(
                                    fontSize: 16.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: MyFooter(
        currentIndex: _currentIndex,
        onTabChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
