import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:review_restaurant/model/district.dart';
import 'package:review_restaurant/service/district_service.dart';
import '../model/City.dart';
import 'home_screen.dart';

class DistrictSelectionScreen extends StatefulWidget {
  final City city;

  const DistrictSelectionScreen({Key? key, required this.city})
      : super(key: key);

  @override
  _DistrictSelectionScreenState createState() =>
      _DistrictSelectionScreenState();
}

class _DistrictSelectionScreenState extends State<DistrictSelectionScreen> {
  District? selectedDistrict;
  List<District> districts = [];
  DistrictService districtService = DistrictService();

  @override
  void initState() {
    super.initState();
    setStatusBarColor(Colors.white);
    loadDistricts();
  }

  void loadDistricts() async {
    try {
      List<District> fetchedDistricts =
          await districtService.getDistrictsByCityId(widget.city.cityId);
      setState(() {
        districts = fetchedDistricts;
      });
    } catch (e) {
      print('Error loading districts: $e');
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.red),
      ),
      body: Container(
        color: Colors.white,
        child: Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'You have selected a city: ${widget.city.cityName}',
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
                      color: Colors.orange[300],
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: DropdownButtonFormField<District>(
                      value: selectedDistrict,
                      decoration: InputDecoration(
                        enabledBorder: InputBorder.none,
                        hintText: 'Select district',
                        hintStyle: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      items: districts.map((district) {
                        return DropdownMenuItem<District>(
                          value: district,
                          child: Text(
                            district.districtName,
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedDistrict = value;
                        });
                        if (selectedDistrict != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomeScreen(
                                city: widget.city,
                                district: selectedDistrict!,
                              ),
                            ),
                          );
                        }
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
