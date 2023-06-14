import 'dart:async';
import 'package:flutter/material.dart';
import 'package:review_restaurant/screens/restaurant_detail_screen.dart';
import 'package:review_restaurant/screens/widgets/footer.dart';
import 'package:review_restaurant/service/restaurant_service.dart';
import '../model/City.dart';
import '../model/district.dart';
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
  PageController _pageController = PageController();
  Timer? _timer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    loadTrendingRestaurant();
    startTimer();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    });
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

  String _getImageUrlByIndex(int index) {
    switch (index) {
      case 0:
        return 'https://treobangron.com.vn/wp-content/uploads/2022/12/banner-quang-cao-nha-hang-29.jpg';
      case 1:
        return 'https://batdia.com.vn/wp-content/uploads/2022/04/cung-cap-bat-to-ban-pho-banner.jpg';
      case 2:
        return 'https://amthuckinhbac.com/wp-content/uploads/2021/10/banner_lau_nuong_bac_ninh.jpg';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(20, 15, 20, 0),
            child: Text(
              "Find Restaurant",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  '${widget.district.districtName}, ',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.orange[600],
                  ),
                ),
                Text(
                  '${widget.city.cityName} City',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.orange[600],
                  ),
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
            padding: EdgeInsets.fromLTRB(20.0, 10, 20.0, 16),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search for restaurants',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(18)),
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
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
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height / 4,
            child: PageView.builder(
              controller: _pageController,
              itemCount: 3,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        _getImageUrlByIndex(index),
                      ),
                      fit: BoxFit.fill,
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
                const Text(
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
                      color: Colors.orange[700],
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
                    margin: EdgeInsets.all(10.0),
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
