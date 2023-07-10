import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:review_restaurant/screens/widgets/dashed_line_vertical_painter.dart';
import 'package:review_restaurant/screens/widgets/footer.dart';
import 'package:review_restaurant/service/voucher_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/user.dart';
import '../model/user_voucher.dart';
import '../model/voucher.dart';

class VouchersScreen extends StatefulWidget {
  const VouchersScreen({Key? key}) : super(key: key);

  @override
  State<VouchersScreen> createState() => _VouchersScreenState();
}

class _VouchersScreenState extends State<VouchersScreen>
    with SingleTickerProviderStateMixin {
  User? user;
  int _currentIndex = 4;
  VoucherService voucherService = VoucherService();
  List<Voucher> vouchers = [];
  List<UserVoucher> myVouchers = [];
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    getUserFromSharedPreferences();
  }

  void loadVouchers() async {
    try {
      List<Voucher> fetchedVouchers = await voucherService.getVouchers();
      List<UserVoucher> fetchedMyVouchers =
          await voucherService.getVouchersByUser(user!.userId);
      setState(() {
        vouchers = fetchedVouchers;
        myVouchers = fetchedMyVouchers;
      });
    } catch (e) {
      print('Error loading vouchers: $e');
    }
  }

  Future<void> _handleBuyVoucher(int userId, int voucherId) async {
    try {
      await voucherService.buyVoucher(context, userId, voucherId);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to buy voucher'),
        ),
      );
    }
  }

  void getUserFromSharedPreferences() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userJson = prefs.getString('user');

      if (userJson != null) {
        Map<String, dynamic> userMap = jsonDecode(userJson);
        User fetchedUser = User.fromJson(userMap);

        setState(() {
          user = fetchedUser;
          loadVouchers();
        });
      } else {
        throw Exception('User data not found in SharedPreferences');
      }
    } catch (e) {
      print('Error loading user data: $e');
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0, // Ẩn thanh công cụ của AppBar
        bottom: PreferredSize(
          preferredSize:
              const Size.fromHeight(kToolbarHeight), // Đặt chiều cao của TabBar
          child: TabBar(
            controller: _tabController,
            tabs: const [
              Tab(text: 'All Vouchers'),
              Tab(text: 'My Vouchers'),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          ListView.builder(
            itemCount: vouchers.length,
            itemBuilder: (BuildContext context, int index) {
              Voucher voucher = vouchers[index];
              return buildVoucherCard(voucher);
            },
          ),
          ListView.builder(
            itemCount: myVouchers.length,
            itemBuilder: (BuildContext context, int index) {
              UserVoucher userVoucher = myVouchers[index];
              return buildUserVoucherCard(userVoucher);
            },
          ),
        ],
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

  Widget buildVoucherCard(Voucher voucher) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        alignment: Alignment.center,
        height: 130,
        child: Card(
          elevation: 4,
          shadowColor: const Color.fromARGB(255, 171, 171, 171),
          child: Row(
            children: [
              const SizedBox(width: 5),
              Image.network(
                voucher.logo,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
              const SizedBox(width: 8),
              SizedBox(
                width: 200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      voucher.voucherName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      voucher.description,
                      style:
                          TextStyle(fontSize: 14, color: Colors.grey.shade500),
                      softWrap: true,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      '${NumberFormat('#,###').format(voucher.price)} point',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange.shade600),
                    ),
                  ],
                ),
              ),
              CustomPaint(
                  size: const Size(1, double.infinity),
                  painter: DashedLineVerticalPainter()),
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: IconButton(
                  onPressed: () {
                    _handleBuyVoucher(user!.userId, voucher.voucherId);
                  },
                  icon: const Icon(FontAwesomeIcons.cartPlus),
                  color: Colors.orange.shade800,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildUserVoucherCard(UserVoucher userVoucher) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        alignment: Alignment.center,
        height: 130,
        child: Card(
          elevation: 4,
          shadowColor: const Color.fromARGB(255, 171, 171, 171),
          child: Row(
            children: [
              const SizedBox(width: 10),
              Image.network(
                userVoucher.logo,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
              const SizedBox(width: 20),
              SizedBox(
                width: 200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      userVoucher.voucherName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      userVoucher.description,
                      style:
                          TextStyle(fontSize: 14, color: Colors.grey.shade500),
                      softWrap: true,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Expired at: ${userVoucher.expiredDate}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
