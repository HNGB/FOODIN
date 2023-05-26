import 'package:flutter/material.dart';

class RestaurantListScreen extends StatelessWidget {
  final String city;
  final String district;

  RestaurantListScreen({
    required this.city,
    required this.district,
  });

  final List<String> allImages = [
    'assets/images/bobanbojpg.jpg',
    'assets/images/comtam.jpg',
    'assets/images/micaysasin.jpg',
    'assets/images/piza.jpg',
    'assets/images/sushimrtom.jpg',
    // Add 5 more restaurant images here
    'assets/images/bun-bo-dung.jpg',
    'assets/images/banh-canh-ghe-ngoc-lam.jpg',
    'assets/images/lau-bo-nam-canh.jpg',
    'assets/images/quan-pho-toan.jpg',
    'assets/images/mr-tofu-bun-dau-mam-tom.jpg',
  ];
  // Danh sách các tên restaurant mới
  final List<String> restaurantNames = [
    'Bơ Bán Bò',
    'Cơm Tấm Phúc Lọc Thọ',
    'Mì Cay Sasin',
    'Pizza Hut',
    'Sushi Mr.Tom',
    // Add 5 more restaurant names here
    'Bún Bò Dũng',
    'Bánh Canh Ghẹ Ngọc Lâm',
    'Lẩu Bò Năm Canh',
    'Quán Phở Toàn',
    'Bún đậu MrTofu',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.red),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16.0),
            child: TextField(
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
              itemCount: allImages.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        color: Color.fromARGB(237, 243, 238, 238),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16.0),
                              child: Image.asset(
                                allImages[index],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              restaurantNames[index], // Thay đổi tên restaurant
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.red,
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.attach_money, color: Colors.red),
                                    Text(
                                      '9.5',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.star, color: Colors.red),
                                    Text(
                                      '5',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ],
                                ),
                                Icon(Icons.favorite, color: Colors.red),
                              ],
                            ),
                          ),
                        ],
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
