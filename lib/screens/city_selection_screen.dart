import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../model/City.dart';
import '../service/city_service.dart';
import 'district_selection_screen.dart';

class CitySelectionScreen extends StatefulWidget {
  @override
  _CitySelectionScreenState createState() => _CitySelectionScreenState();
}

class _CitySelectionScreenState extends State<CitySelectionScreen> {
  City? selectedCity;
  List<City> cities = [];
  CityService cityService = CityService();

  @override
  void initState() {
    super.initState();
    setStatusBarColor(Colors.white);
    loadCities();
  }

  void loadCities() async {
    try {
      List<City> fetchedCities = await cityService.getCities();
      setState(() {
        cities = fetchedCities;
      });
    } catch (e) {
      print('Error loading cities: $e');
    }
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
    double dropdownWidth = screenWidth * 0.5;

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        color: Colors.white,
        child: Center(
          child: Container(
            margin: EdgeInsets.all(32.0),
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.orange[300],
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
                  child: DropdownButton<City>(
                    value: selectedCity,
                    hint: Text('Select City'),
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black,
                    ),
                    iconSize: 24,
                    elevation: 16,
                    underline: Container(),
                    isExpanded: true,
                    onChanged: (City? value) {
                      setState(() {
                        selectedCity = value;
                      });
                      if (selectedCity != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DistrictSelectionScreen(
                              city: selectedCity!,
                            ),
                          ),
                        );
                      }
                    },
                    items: cities.map((City city) {
                      return DropdownMenuItem<City>(
                        value: city,
                        child: Text(city.cityName),
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
