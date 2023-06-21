import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:review_restaurant/model/favourite_restaurant.dart';
import 'package:review_restaurant/screens/widgets/footer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/user.dart';
import '../service/restaurant_service.dart';

class FavoriteRestaurantScreen extends StatefulWidget {
  @override
  _FavoriteRestaurantScreenState createState() =>
      _FavoriteRestaurantScreenState();
}

class _FavoriteRestaurantScreenState extends State<FavoriteRestaurantScreen> {
  int _currentIndex = 1;
  final RestaurantService restaurantService = RestaurantService();
  List<FavouriteRestaurant> favoriteRestaurants = [];
  User? user;
  @override
  void initState() {
    super.initState();
    // Gọi hàm getFavoriteRestaurantsByUserId(userId) từ restaurantService ở đây
    getUserFromSharedPreferences();
  }

  void getUserFromSharedPreferences() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userJson = prefs.getString('user');

      if (userJson != null) {
        Map<String, dynamic> userMap = jsonDecode(userJson);
        User fetchedUser = User.fromJson(userMap);
        List<FavouriteRestaurant> fetchedRestaurant = await restaurantService
            .getFavoriteRestaurantsByUserId(fetchedUser.userId);
        setState(() {
          user = fetchedUser;
          favoriteRestaurants = fetchedRestaurant;
        });
      } else {
        throw Exception('User data not found in SharedPreferences');
      }
    } catch (e) {
      print('Error loading user data: $e');
    }
  }

  void removeFromFavorites(int restaurantId) async {
    try {
      if (user != null) {
        await restaurantService.addToFavorite(
          user!.userId,
          restaurantId,
        );
      }
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text("Favorite Restaurant",
            style: TextStyle(color: Colors.orange[700])),
      ),
      body: Container(
        color: Colors.grey[200],
        child: ListView.separated(
          itemCount: favoriteRestaurants.length,
          separatorBuilder: (BuildContext context, int index) => Divider(),
          itemBuilder: (BuildContext context, int index) {
            return Dismissible(
              key: UniqueKey(),
              direction: DismissDirection.endToStart,
              background: Container(
                color: Colors.red,
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 16.0),
                child: Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ),
              onDismissed: (direction) {
                removeFromFavorites(favoriteRestaurants[index].restaurantId);
                setState(() {
                  favoriteRestaurants.removeAt(index);
                });
              },
              child: Card(
                elevation: 2,
                child: ListTileTheme(
                  style: ListTileStyle.list,
                  child: ListTile(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    leading: CircleAvatar(
                      backgroundImage:
                          NetworkImage(favoriteRestaurants[index].avatar),
                    ),
                    title: Text(
                      favoriteRestaurants[index].resName,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          favoriteRestaurants[index].address,
                          style: TextStyle(fontSize: 16),
                        ),
                        if (favoriteRestaurants[index].phoneNumber != null)
                          Text(
                            "Phone: ${favoriteRestaurants[index].phoneNumber!}",
                            style: TextStyle(fontSize: 16),
                          ),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.yellow,
                            ),
                            Text(
                              favoriteRestaurants[index]
                                  .calculatedRating
                                  .toString(),
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
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
