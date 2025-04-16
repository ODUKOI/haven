// providers.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:booking_haven/services/hotel_service.dart';

// This provider uses the HotelService to fetch the cities from your API.
final citiesProvider = FutureProvider<List<Map<String, String>>>((ref) async {
  final hotelService = ref.watch(hotelServiceProvider);
  return hotelService.getCities();
});
