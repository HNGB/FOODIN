import 'package:flutter/material.dart';
import 'package:review_restaurant/screens/restaurant_detail_screen.dart';
import 'package:review_restaurant/screens/widgets/footer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'city_selection_screen.dart';
import 'restaurant_list_screen.dart';

class HomeScreen extends StatefulWidget {
  final String city;
  final String district;

  HomeScreen({required this.city, required this.district});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> trendingImages = [
    'assets/images/bobanbojpg.jpg',
    'assets/images/comtam.jpg',
    'assets/images/micaysasin.jpg',
    'assets/images/piza.jpg',
    'assets/images/sushimrtom.jpg',
  ];

  final List<String> trendingLabels = [
    'Bơ Bán Bò',
    'Cơm Tấm Phúc Lọc Thọ',
    'Mì Cay Sasin',
    'Pizza Hut',
    'Sushi Mr.Tom',
  ];
  int _currentIndex = 0;
  Future<void> _saveDataToStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('city', widget.city);
    await prefs.setString('district', widget.district);
  }

  @override
  void initState() {
    super.initState();
    _saveDataToStorage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
                    '${widget.district}, ',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  Text(
                    '${widget.city} City',
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
                decoration: InputDecoration(
                  hintText: 'Search for restaurants',
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.search),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 40, 20, 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Trending Restaurants',
                    style:
                        TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    child: Text(
                      'Show All',
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    onPressed: () {
                      // TODO: Navigate to show all restaurants in the district
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RestaurantListScreen(
                            city: widget.city,
                            district: widget.district,
                            // Add this line
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
                itemCount: trendingImages.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      // Chuyển đến màn hình khác khi người dùng nhấn vào item
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const RestaurantDetailScreen()),
                      );
                    },
                    child: Container(
                      width: 200,
                      margin: EdgeInsets.all(1.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16.0),
                              child: Image.asset(
                                trendingImages[index],
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              trendingLabels[index],
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
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
