import 'package:dio/dio.dart';
import 'package:stylish2023/Data/Product';

class DioClient {
  final Dio dio = Dio();

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

  Future<List<Product>> fetchProductList() async {
    try {
      final response = await dio.get(womenProductListEndpoint);
      final data = List<Map<String, dynamic>>.from(response.data['data']);
      return data.map((json) => Product.fromJson(json)).toList();
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
