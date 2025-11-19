import 'package:letmegrab_task/app/constants/api_endpoints.dart';
import 'package:letmegrab_task/data/models/products.dart';
import 'package:dio/dio.dart' as dio;
import '../../../network/api_service.dart';

class ApiDataSource {
  final ApiService _apiService;

  ApiDataSource(this._apiService);

  /// check Email availability
  Future<ProductsResponseModel> getUsers() async {
    try {
      dio.Response response = await _apiService.get(ApiEndpoints.getPosts);
      return ProductsResponseModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getUserDetails(int id) async {
    try {
      dio.Response response = await _apiService.get(ApiEndpoints.getPosts);
      return Map<String, dynamic>.from(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
