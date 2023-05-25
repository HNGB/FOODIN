import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'district_selection_screen.dart';

class CitySelectionScreen extends StatefulWidget {
  @override
  _CitySelectionScreenState createState() => _CitySelectionScreenState();
}

class _CitySelectionScreenState extends State<CitySelectionScreen> {
  String? selectedCity;

  @override
  void initState() {
    super.initState();
    setStatusBarColor(
        Colors.white); // Đặt màu của thanh trạng thái thành màu trắng
  }

  @override
  void dispose() {
    setStatusBarColor(Colors
        .transparent); // Đặt màu của thanh trạng thái thành màu trong suốt khi thoát khỏi màn hình này
    super.dispose();
  }

  void setStatusBarColor(Color color) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: color,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double dropdownWidth = screenWidth * 0.5; // 50% chiều rộng màn hình

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        color: Colors.white,
        child: Center(
          child: Container(
            margin: EdgeInsets.all(32.0),
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 6.0,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Select City',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Container(
                  width: dropdownWidth,
                  child: DropdownButton<String>(
                    value: selectedCity,
                    hint: Text('Select City'), // Hint text
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black,
                    ),
                    iconSize: 24,
                    elevation: 16,
                    underline: Container(),
                    isExpanded: true,
                    onChanged: (String? value) {
                      setState(() {
                        selectedCity = value;
                      });
                      if (selectedCity != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                DistrictSelectionScreen(city: selectedCity!),
                          ),
                        );
                      }
                    },
                    items:
                        ['Ha Noi', 'Ho Chi Minh', 'Da Nang'].map((String city) {
                      return DropdownMenuItem<String>(
                        value: city,
                        child: Text(city),
                      );
                    }).toList(),
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
