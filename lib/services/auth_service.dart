import 'dart:convert';
import 'package:booking_haven/dio.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authServiceProvider = Provider<AuthService>((ref) {
  final dio = ref.watch(dioProvider);
  final storage = ref.watch(secureStorageProvider);
  return AuthService(dio, storage);
});

// final dioProvider = Provider<Dio>((ref) {
//   final dio = Dio(BaseOptions(
//     // For Android emulator use 10.0.2.2
//     // baseUrl: 'http://10.0.2.2:8000/api/',
//     baseUrl: 'http://192.168.150.133:8000/api/',
//     // For iOS simulator/real device use your machine's IP
//     // baseUrl: 'http://192.168.1.X:8000/api/',
//     headers: {'Accept': 'application/json'},
//   ));

//   // Add logging interceptor
//   dio.interceptors.add(LogInterceptor(
//     request: true,
//     requestBody: true,
//     responseBody: true,
//     error: true,
//   ));

//   return dio;
// });

final secureStorageProvider = Provider<FlutterSecureStorage>(
  (_) => const FlutterSecureStorage(),
);

class AuthService {
  final Dio _dio;
  final FlutterSecureStorage _storage;

  AuthService(this._dio, this._storage);

  Future<String?> getToken() async => await _storage.read(key: 'auth_token');

  Future<void> persistToken(String token) async {
    await _storage.write(key: 'auth_token', value: token);
  }

  Future<void> deleteToken() async {
    await _storage.delete(key: 'auth_token');
  }

  Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    try {
      final response = await _dio.post(
        'register',
        data: {
          'name': name,
          'email': email,
          'password': password,
          'password_confirmation': passwordConfirmation,
        },
      );

      await persistToken(response.data['token']);
      return {'success': true, 'data': response.data};
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dio.post(
        'login',
        data: {'email': email, 'password': password},
      );

      await persistToken(response.data['token']);
      return {'success': true, 'data': response.data};
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  // Future<void> logout() async {
  //   try {
  //     await _dio.post('logout');
  //     await deleteToken();
  //   } on DioException catch (_) {
  //     await deleteToken();
  //   }
  // }
  Future<void> logout() async {
    try {
      final token = await getToken();
      if (token != null) {
        await _dio.post(
          'logout',
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
              'Accept': 'application/json',
            },
          ),
        );
      }
      await deleteToken();
    } on DioException catch (_) {
      await deleteToken();
    }
  }

  Future<Map<String, dynamic>> getUserProfile() async {
    try {
      final response = await _dio.get('profile');
      return response.data;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        await deleteToken();
      }
      rethrow;
    }
  }

  Map<String, dynamic> _handleError(DioException e) {
    print('API Error: ${e.message}');
    print('Response: ${e.response?.data}');

    if (e.response?.statusCode == 422) {
      final errors = e.response?.data['errors'] ?? {};
      print('Validation errors: $errors');
      return {'success': false, 'errors': errors};
    }

    return {
      'success': false,
      'errors': {
        'general': [e.response?.data['message'] ?? 'Connection failed']
      }
    };
  }
}
