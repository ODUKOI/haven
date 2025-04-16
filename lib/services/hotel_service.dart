// hotel_service.dart
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


import '../dio.dart';
import '../models/hotels_models.dart'; // This file contains your dioProvider.

final hotelServiceProvider = Provider<HotelService>((ref) {
  final dio = ref.watch(dioProvider);
  return HotelService(dio);
});

class HotelService {
  final Dio dio;
  HotelService(this.dio);

  Future<List<Hotel>> getHotels() async {
    try {
      final response = await dio.get('/hotels');
      if (response.statusCode == 200) {
        final List data = response.data;
        return data.map((json) => Hotel.fromJson(json)).toList();
      } else {
        throw Exception('Error: ${response.statusCode}');
      }
    } on DioError catch (e) {
      throw Exception('Dio error: ${e.message}');
    }
  }

  Future<List<Map<String, String>>> getCities() async {
    final hotels = await getHotels();
    final Set<String> uniqueCities = {};

    for (var hotel in hotels) {
      // Split the address by commas and get the last part (adjust according to your API data format)
      final parts = hotel.address.split(',');
      if (parts.isNotEmpty) {
        uniqueCities.add(parts.last.trim());
      }
    }

    return uniqueCities.map((name) => {'name': name}).toList();
  }
}
