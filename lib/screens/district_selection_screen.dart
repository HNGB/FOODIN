import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'home_screen.dart';

class DistrictSelectionScreen extends StatelessWidget {
  final String city;

  const DistrictSelectionScreen({Key? key, required this.city})
      : super(key: key);

  List<String> getDistricts() {
    switch (city) {
      case 'Ha Noi':
        return [
          'Hoang Mai',
          'Long Bien',
          'Thanh Xuan',
          'Bac Tu Liem',
          'Ba Dinh',
          'Cau Giay',
          'Dong Da',
          'Hai Ba Trung',
          'Hoan Kiem',
          'Ha Dong',
          'Tay Ho',
          'Nam Tu Liem'
        ];
      case 'Ho Chi Minh':
        return [
          'Binh Chanh',
          'Binh Tan',
          'Cu Chi',
          'District 1',
          'District 2',
          'District 3',
          'District 4',
          'District 5',
          'District 6',
          'District 8',
          'District 9',
          'District 10',
          'District 11',
          'District 12',
          'Go Vap District',
          'Hoc Mon',
          'Phu Nhuan District',
          'Tan Binh District',
          'Tan Phu District',
          'Thu Duc City',
        ];
      case 'Da Nang':
        return [
          'Hai Chau District',
          'Cam Le District',
          'Thanh Khe District',
          'Lien Chieu District',
          'Ngu Hanh Son District',
          'Son Tra District',
          'Hoa Vang District',
          'Hoang Sa District'
        ];
      default:
        return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    // Set status bar color
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white, // Set the status bar color to white
      statusBarBrightness: Brightness.dark, // Set status bar icons to be light
    ));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme:
            IconThemeData(color: Colors.red), // Set the back arrow color to red
      ),
      body: Container(
        color: Colors.white, // Thay đổi màu nền thành màu trắng
        child: Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'You have selected a city: $city',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                DropdownButtonHideUnderline(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Colors.red,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: DropdownButtonFormField<String>(
                      value: null,
                      decoration: InputDecoration(
                        enabledBorder: InputBorder.none,
                        hintText: 'Select district',
                        hintStyle: TextStyle(
                          color: Colors.white70,
                        ),
                      ),
                      items: getDistricts().map((district) {
                        return DropdownMenuItem<String>(
                          value: district,
                          child: Text(
                            district,
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomeScreen(
                              city: city,
                              district: value!,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
