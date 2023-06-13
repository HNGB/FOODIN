import 'package:flutter/material.dart';
import 'package:review_restaurant/model/district.dart';
import '../model/City.dart';
import '../model/restaurant.dart';
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
  List<bool> isFavorite = [];
  String searchKeyword = '';

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
  }

  void loadRestaurants() async {
    try {
      List<Restaurant> fetchedRestaurants = await restaurantService
          .getRestaurantsByDistrictId(widget.district.districtId);
      setState(() {
        restaurants = fetchedRestaurants;
        isFavorite = List.generate(fetchedRestaurants.length, (index) => false);
        filterRestaurants();
      });
    } catch (e) {
      print('Error loading restaurants: $e');
    }
  }

  void filterRestaurants() {
    if (widget.searchController.text.isEmpty) {
      setState(() {
        filteredRestaurants = restaurants
            .where((restaurant) => restaurant.resName
                .toLowerCase()
                .contains(searchKeyword.toLowerCase()))
            .toList();
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
                border: OutlineInputBorder(),
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
                                      color: isFavorite[index]
                                          ? Colors.red
                                          : const Color.fromARGB(
                                              255, 142, 142, 142),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        isFavorite[index] = !isFavorite[index];
                                      });
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
