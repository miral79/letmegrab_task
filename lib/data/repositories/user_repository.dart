import 'package:letmegrab_task/data/models/products.dart';

import '../datasources/remote/api_datasource.dart';

class UserRepository {
  final ApiDataSource _apiDataSource;

  UserRepository(this._apiDataSource);

  Future<ProductsResponseModel> fetchUsers() {
    return _apiDataSource.getUsers();
  }

  Future<Map<String, dynamic>> fetchUserDetails(int id) {
    return _apiDataSource.getUserDetails(id);
  }
}
