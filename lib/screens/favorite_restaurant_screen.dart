import 'package:flutter/material.dart';
import 'package:review_restaurant/screens/widgets/footer.dart';

class Restaurant {
  final String name;
  final String address;
  final String? phoneNumber;
  final int rating;
  final String avatar;

  Restaurant({
    required this.name,
    required this.address,
    this.phoneNumber,
    required this.rating,
    required this.avatar,
  });
}

class FavoriteRestaurantScreen extends StatefulWidget {
  @override
  _FavoriteRestaurantScreenState createState() =>
      _FavoriteRestaurantScreenState();
}

class _FavoriteRestaurantScreenState extends State<FavoriteRestaurantScreen> {
  int _currentIndex = 1;
  List<Restaurant> favoriteRestaurants = [
    Restaurant(
      name: 'Busan Korean Food',
      address: '25 Lê Văn Việt, Hiệp Phú, Quận 9, Thành phố Hồ Chí Minh',
      phoneNumber: null,
      rating: 4,
      avatar:
          'https://images.foody.vn/res/g115/1141161/prof/s576x330/foody-upload-api-foody-mobile-fo-bc3774be-220622165107.jpeg',
    ),
    Restaurant(
      name: 'Busan Korean Food',
      address: '25 Lê Văn Việt, Hiệp Phú, Quận 9, Thành phố Hồ Chí Minh',
      phoneNumber: null,
      rating: 4,
      avatar:
          'https://images.foody.vn/res/g115/1141161/prof/s576x330/foody-upload-api-foody-mobile-fo-bc3774be-220622165107.jpeg',
    ),
    Restaurant(
      name: 'Busan Korean Food',
      address: '25 Lê Văn Việt, Hiệp Phú, Quận 9, Thành phố Hồ Chí Minh',
      phoneNumber: null,
      rating: 4,
      avatar:
          'https://images.foody.vn/res/g115/1141161/prof/s576x330/foody-upload-api-foody-mobile-fo-bc3774be-220622165107.jpeg',
    ),
    Restaurant(
      name: 'Busan Korean Food',
      address: '25 Lê Văn Việt, Hiệp Phú, Quận 9, Thành phố Hồ Chí Minh',
      phoneNumber: null,
      rating: 4,
      avatar:
          'https://images.foody.vn/res/g115/1141161/prof/s576x330/foody-upload-api-foody-mobile-fo-bc3774be-220622165107.jpeg',
    ),
    // Thêm các nhà hàng khác vào đây
  ];

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
            return Card(
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
                    favoriteRestaurants[index].name,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                          favoriteRestaurants[index].phoneNumber!,
                          style: TextStyle(fontSize: 16),
                        ),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.yellow,
                          ),
                          Text(
                            favoriteRestaurants[index].rating.toString(),
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ],
                  ),
                  trailing: Icon(
                    Icons.favorite,
                    color: Colors.red,
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
