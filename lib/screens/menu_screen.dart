import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/food.dart';
import '../service/food_service.dart';

class MenuScreen extends StatefulWidget {
  final int restaurantId;
  const MenuScreen({Key? key, required this.restaurantId}) : super(key: key);

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  List<Food> foods = [];
  FoodService foodService = FoodService();

  @override
  void initState() {
    super.initState();
    loadMenu();
  }

  void loadMenu() async {
    try {
      final listFood =
          await foodService.getFoodListByRestaurantId(widget.restaurantId);
      setState(() {
        foods = listFood.toList();
      });
    } catch (e) {
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    Color blueColor = const Color.fromARGB(255, 255, 109, 42);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: blueColor,
        title: const Text('Menu'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(20.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 20.0,
          crossAxisSpacing: 20.0,
          childAspectRatio:
              1.0, // Tỉ lệ giữa chiều rộng và chiều cao của mỗi mục
          mainAxisExtent: 200.0,
        ),
        itemCount: foods.length,
        itemBuilder: (context, index) {
          final food = foods[index];
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 110,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0),
                    ),
                    image: DecorationImage(
                      image: NetworkImage(food.foodImage),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          food.foodName,
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center, // Căn giữa văn bản
                        ),
                      ),

                      const SizedBox(
                          height:
                              10.0), // Khoảng cách giữa foodName và foodPrice
                      Center(
                        child: Text(
                          '${NumberFormat('#,###').format(food.foodPrice)}đ',
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
