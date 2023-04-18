import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:stylish2023/Data/product_list.dart';

class HttpDioClient {
  static final client = http.Client();

  /// https://api.appworks-school.tw/api/1.0/products/women
  static const baseURL = 'https://api.appworks-school.tw/api/1.0';

  /// 全部
  static const allProductListEndpoint = '$baseURL/products/all';

  /// 女裝
  static const womenProductListEndpoint = '$baseURL/products/women';

  /// 男裝
  static const menProductListEndpoint = '$baseURL/products/men';

  /// 配件
  static const accessoriesProductListEndpoint = '$baseURL/products/accessories';

  static Future<List<Product>> fetchProductList() async {
    try {
      final response = await client.get(Uri.parse(womenProductListEndpoint));
      final data =
          List<Map<String, dynamic>>.from(json.decode(response.body)['data']);
      return data.map((json) => Product.fromJson(json)).toList();
    } catch (e) {
      debugPrint('Error: $e');
      throw Exception('Failed to get product list');
    } finally {
      client.close();
    }
  }
}
