// Model class for Hotel
class Hotel {
  final String address;
  final String name;

  Hotel({
    required this.address,
    required this.name,
  });

  factory Hotel.fromJson(Map<String, dynamic> json) {
    return Hotel(
      name: json['name'],
      address: json['address'],
    );
  }
}
