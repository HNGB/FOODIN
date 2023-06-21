import 'package:flutter/material.dart';
import 'package:review_restaurant/screens/widgets/footer.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white10,
        elevation: 0,
        automaticallyImplyLeading: false, // Ẩn nút quay lại
        centerTitle: true,
        title: Text(
          'Settings',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.red, // Màu đỏ cho chữ ở appbar
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 80),
            padding: EdgeInsets.fromLTRB(30, 16, 30, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Account Settings',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16.0),
                ListTile(
                  leading: Icon(Icons.person),
                  title: Text('Profile'),
                  onTap: () {
                    // TODO: Implement profile settings
                  },
                ),
                ListTile(
                  leading: Icon(Icons.lock),
                  title: Text('Privacy'),
                  onTap: () {
                    // TODO: Implement privacy settings
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 24.0),
          Container(
            padding: EdgeInsets.fromLTRB(30, 16, 30, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'General Settings',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16.0),
                ListTile(
                  leading: Icon(Icons.notifications),
                  title: Text('Notifications'),
                  onTap: () {
                    // TODO: Implement notification settings
                  },
                ),
                ListTile(
                  leading: Icon(Icons.language),
                  title: Text('Language'),
                  onTap: () {
                    // TODO: Implement language settings
                  },
                ),
                ListTile(
                  leading: Icon(Icons.output_outlined),
                  title: Text('Log out'),
                  onTap: () {
                    // TODO: Implement privacy settings
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: MyFooter(
        currentIndex: 2,
        onTabChanged: (index) {},
      ),
    );
  }
}
