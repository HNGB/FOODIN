import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../model/user_voucher.dart';
import '../model/voucher.dart';

class VoucherService {
  Future<List<Voucher>> getVouchers() async {
    final response = await http
        .get(Uri.parse('https://foodiapi.azurewebsites.net/api/Voucher'));

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);
      final List<Voucher> vouchers =
          responseData.map((json) => Voucher.fromJson(json)).toList();
      return vouchers;
    } else {
      throw Exception('Failed to load vouchers');
    }
  }

  Future<List<UserVoucher>> getVouchersByUser(int userId) async {
    final response = await http.get(Uri.parse(
        'https://foodiapi.azurewebsites.net/api/Voucher/ByUser/$userId'));

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);
      final List<UserVoucher> vouchers =
          responseData.map((json) => UserVoucher.fromJson(json)).toList();
      return vouchers;
    } else {
      throw Exception('Failed to load vouchers');
    }
  }

  Future<void> buyVoucher(
      BuildContext context, int userId, int voucherId) async {
    final url =
        Uri.parse('https://foodiapi.azurewebsites.net/api/Voucher/BuyVoucher');

    final body = jsonEncode({
      'userId': userId,
      'voucherId': voucherId,
    });

    final response = await http
        .post(url, body: body, headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Buy success!'),
        ),
      );
    } else {
      throw Exception('Failed to buy voucher');
    }
  }
}
