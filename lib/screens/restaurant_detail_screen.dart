import 'package:flutter/material.dart';
import 'package:review_restaurant/service/review_service.dart';

import '../model/food.dart';
import '../model/restaurant.dart';
import '../model/review.dart';
import '../service/food_service.dart';
import '../service/restaurant_service.dart';

class RestaurantDetailScreen extends StatefulWidget {
  final int restaurantId;

  const RestaurantDetailScreen({Key? key, required this.restaurantId})
      : super(key: key);

  @override
  _RestaurantDetailScreenState createState() => _RestaurantDetailScreenState();
}

class _RestaurantDetailScreenState extends State<RestaurantDetailScreen> {
  Restaurant? restaurant;
  List<Food> foods = [];
  RestaurantService restaurantService = RestaurantService();
  ReviewService reviewService = ReviewService();
  FoodService foodService = FoodService();
  int reviewCount = 0;

  @override
  void initState() {
    super.initState();
    loadRestaurants();
    loadMenu();
  }

  void loadRestaurants() async {
    try {
      final restaurant =
          await restaurantService.getRestaurantById(widget.restaurantId);
      final reviews =
          await ReviewService().getReviewsByRestaurantId(widget.restaurantId);
      final reviewCount = reviews.length;
      setState(() {
        this.restaurant = restaurant;
        this.reviewCount = reviewCount;
      });
    } catch (e) {
      // Handle error
    }
  }

  void loadMenu() async {
    try {
      final listFood =
          await foodService.getFoodListByRestaurantId(widget.restaurantId);
      setState(() {
        foods = listFood;
      });
    } catch (e) {
      // Handle error
    }
  }

  Widget buildRatingStars(int rating) {
    return Row(
      children: List.generate(
        5,
        (index) => Icon(
          index < rating ? Icons.star : Icons.star_rounded,
          color: index < rating
              ? const Color.fromARGB(255, 255, 230, 5)
              : const Color.fromARGB(255, 221, 221, 221),
          size: 20,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const Color grayIcon = Color.fromARGB(255, 198, 197, 197);
    const Color grayText = Color.fromARGB(255, 129, 129, 129);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded,
              color: Color.fromARGB(255, 255, 107, 21)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 2.5,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(restaurant?.coverImage ?? ''),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  left: 5,
                  right: 5,
                  bottom: 0,
                  child: Transform.translate(
                    offset: const Offset(0, 130.0),
                    child: Container(
                      height: 200,
                      margin: const EdgeInsets.symmetric(horizontal: 16.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 5,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding:
                            const EdgeInsets.fromLTRB(26.0, 16.0, 16.0, 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              restaurant?.resName ?? '',
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                buildRatingStars(
                                    restaurant?.calculatedRating ?? 0),
                                const SizedBox(width: 10),
                                Text(
                                  restaurant?.calculatedRating.toString() ?? '',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Color.fromARGB(255, 255, 230, 5),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const SizedBox(width: 2),
                                Text(
                                  '($reviewCount Reviews)',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Color.fromARGB(255, 199, 199, 199),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            const Divider(
                              color: Color.fromARGB(
                                  255, 206, 206, 206), //color of divider
                              height: 5, //height spacing of divider
                              thickness: 0.5, //thickness of divier line
                            ),
                            const SizedBox(height: 20),
                            const Row(
                              children: [
                                Icon(
                                  Icons.access_time,
                                  size: 20,
                                  color: grayIcon,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  '09:00 - 22:00',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: grayText,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(width: 20),
                                Icon(
                                  Icons.local_parking_rounded,
                                  size: 20,
                                  color: grayIcon,
                                ),
                                SizedBox(width: 2),
                                Text(
                                  'Parking lot',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: grayText,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                const Icon(
                                  Icons.house_outlined,
                                  size: 20,
                                  color: grayIcon,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  restaurant?.address ?? '',
                                  style: const TextStyle(
                                      fontSize: 14,
                                      color: grayText,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(25.0, 145.0, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Menu',
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 200,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: foods.length,
                    itemBuilder: (context, index) {
                      final food = foods[index];
                      return Container(
                        width: 150,
                        margin: const EdgeInsets.only(right: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 120,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: NetworkImage(food.foodImage),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              food.foodName,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              '${food.foodPrice.toString()}đ',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu'),
      ),
      body: const Center(
        child: Text('Menu của nhà hàng'),
      ),
    );
  }
}

class PhotosScreen extends StatelessWidget {
  const PhotosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Photos'),
      ),
      body: const Center(
        child: Text('Ảnh của nhà hàng'),
      ),
    );
  }
}

class InformationScreen extends StatelessWidget {
  const InformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Information'),
      ),
      body: const Center(
        child: Text('Thông tin về nhà hàng'),
      ),
    );
  }
}
