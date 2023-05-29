import 'package:flutter/material.dart';

class RestaurantListScreen extends StatefulWidget {
  final String city;
  final String district;

  RestaurantListScreen({
    required this.city,
    required this.district,
  });

  @override
  _RestaurantListScreenState createState() => _RestaurantListScreenState();
}

class _RestaurantListScreenState extends State<RestaurantListScreen> {
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

  List<bool> isFavorite =
      List.filled(10, false); // Tạo danh sách trạng thái yêu thích ban đầu

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
                        color: Color.fromARGB(255, 231, 231, 231),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment
                            .center, // Thay đổi căn chỉnh của cột
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16.0),
                              child: Image.asset(
                                allImages[index],
                                fit: BoxFit.cover,
                                width: double
                                    .infinity, // Sử dụng chiều rộng tối đa của ô chứa
                                height: double
                                    .infinity, // Sử dụng chiều cao tối đa của ô chứa
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              restaurantNames[index],
                              style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700),
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
                                    Icon(Icons.attach_money,
                                        color: const Color.fromARGB(
                                            221, 124, 122, 122)),
                                    Text(
                                      '9.5',
                                      style: TextStyle(color: Colors.black87),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.star,
                                        color:
                                            Color.fromARGB(255, 238, 238, 14)),
                                    Text(
                                      '5',
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
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
