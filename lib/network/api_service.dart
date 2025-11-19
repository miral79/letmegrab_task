import 'package:dio/dio.dart';
import 'package:letmegrab_task/app/constants/api_endpoints.dart';
import 'package:letmegrab_task/core/exceptions/api_exception.dart';
import 'package:letmegrab_task/core/logger/logger.dart';
import 'network_manager.dart';
import 'api_queue_manager.dart';

typedef ApiCall = Future<Response> Function();

class ApiService {
  final Dio _dio;
  final NetworkManager networkManager;
  final ApiQueueManager queueManager;

  ApiService({required this.networkManager, required this.queueManager})
    : _dio = Dio(
        BaseOptions(
          baseUrl: ApiEndpoints.baseUrl,
          connectTimeout: const Duration(seconds: 15),
          receiveTimeout: const Duration(seconds: 15),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "Bearer ",
          },
        ),
      ) {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          AppLogger.info(
            "API Request",
            data: {
              "URL": "${options.baseUrl}${options.path}",
              "Method": options.method,
              "Token": options.headers['Authorization'] = "Bearer ",
              if (options.queryParameters.isNotEmpty)
                "Query Parameters": options.queryParameters,
              if (options.data != null) "Body": options.data,
            },
          );
          handler.next(options);
        },
        onResponse: (response, handler) {
          AppLogger.success(
            "API Response",
            data: {
              "URL":
                  "${response.requestOptions.baseUrl}${response.requestOptions.path}",
              "Status Code": response.statusCode,
              "Response Body": response.data,
            },
          );
          handler.next(response);
        },
        onError: (DioException e, handler) {
          AppLogger.error("API Error", error: e, stackTrace: e.stackTrace);
          if (e.response != null) {
            AppLogger.error(
              "Error Response",
              error: {
                "URL": "${e.requestOptions.baseUrl}${e.requestOptions.path}",
                "Status Code": e.response?.statusCode,
                "Response Body": e.response?.data,
              },
            );
          }
          handler.next(e);
        },
      ),
    );
  }

  Future<Response> safeRequest(ApiCall requestFn) async {
    // Queue request if offline
    if (!networkManager.isOnline) {
      queueManager.add(requestFn);
      throw NoInternetException();
    }

    try {
      final response = await requestFn();

      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        return response;
      }

      switch (response.statusCode) {
        case 401:
          throw UnauthorizedException();
        case 403:
          throw ForbiddenException();
        case 404:
          throw NotFoundException();
        default:
          if (response.statusCode != null && response.statusCode! >= 500) {
            throw ServerErrorException();
          }
          throw ApiException(
            message: "Unexpected error",
            statusCode: response.statusCode,
            details: response.data,
          );
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError) {
        queueManager.add(requestFn);
        throw NoInternetException();
      } else if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw TimeoutException();
      } else if (e.type == DioExceptionType.badResponse) {
        throw ApiException(
          message: "Bad response",
          statusCode: e.response?.statusCode,
          details: e.response?.data,
        );
      } else {
        throw ApiException(message: e.message ?? "Unknown Dio error");
      }
    } catch (e) {
      throw ParsingException("Unexpected error: $e");
    }
  }

  /// Generic HTTP methods
  Future<Response> get(String path, {Map<String, dynamic>? queryParameters}) =>
      safeRequest(() => _dio.get(path, queryParameters: queryParameters));

  Future<Response> post(
    String path, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
  }) => safeRequest(
    () => _dio.post(path, data: data, queryParameters: queryParameters),
  );

  Future<Response> put(
    String path, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
  }) => safeRequest(
    () => _dio.put(path, data: data, queryParameters: queryParameters),
  );

  Future<Response> delete(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) => safeRequest(() => _dio.delete(path, queryParameters: queryParameters));

  Future<Response> patch(
    String path, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
  }) => safeRequest(
    () => _dio.patch(path, data: data, queryParameters: queryParameters),
  );
}
