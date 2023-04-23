import 'package:stylish2023/Data/product_list.dart';
import 'package:dio/dio.dart';

class ApiRepository {
  final Dio _dio = Dio();
  final String _baseUrl = 'https://api.appworks-school.tw/api/1.0';

  Future<List<HotsProductData>> fetchMarketingHots() async {
    try {
      final response = await _dio.get('$_baseUrl/marketing/hots');
      final marketingHots = (response.data['data'] as List<dynamic>)
          .map((hotsProductData) => HotsProductData.fromJson(hotsProductData))
          .toList();

      if (response.statusCode == 200) {
        return marketingHots;
      } else {
        throw Exception("Failed to load joke");
      }
    } catch (e) {
      print('Error: $e');
      print("Stack Trace: ${StackTrace.current}");
      throw Exception("Failed to load product list: $e");
    }
  }

  Future<List<Product>> fetchWomenProductList() async {
    try {
      final response = await _dio.get('$_baseUrl/products/women');
      final products = (response.data['data'] as List<dynamic>)
          .map((productData) => Product.fromJson(productData))
          .toList();

      if (response.statusCode == 200) {
        return products;
      } else {
        throw Exception("Failed to load joke");
      }
    } catch (e) {
      print('Error: $e');
      print("Stack Trace: ${StackTrace.current}");
      throw Exception("Failed to load product list: $e");
    }
  }

  Future<List<Product>> fetchMenProductList() async {
    try {
      final response = await _dio.get('$_baseUrl/products/men');
      final products = (response.data['data'] as List<dynamic>)
          .map((productData) => Product.fromJson(productData))
          .toList();

      if (response.statusCode == 200) {
        return products;
      } else {
        throw Exception("Failed to load joke");
      }
    } catch (e) {
      print('Error: $e');
      print("Stack Trace: ${StackTrace.current}");
      throw Exception("Failed to load product list: $e");
    }
  }

  Future<List<Product>> fetchAccessoriesProductList() async {
    try {
      final response = await _dio.get('$_baseUrl/products/accessories');
      final products = (response.data['data'] as List<dynamic>)
          .map((productData) => Product.fromJson(productData))
          .toList();

      if (response.statusCode == 200) {
        return products;
      } else {
        throw Exception("Failed to load joke");
      }
    } catch (e) {
      print('Error: $e');
      print("Stack Trace: ${StackTrace.current}");
      throw Exception("Failed to load product list: $e");
    }
  }
}
