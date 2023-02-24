import 'dart:math';

const earthRadiusKm = 6371.0;

class User {
  String city;
  double latitude;
  double longitude;
  List<String> imageUrls;
  String name;
  String bio;
  String email;
  int strength;

  User({
    required this.city,
    required this.latitude,
    required this.longitude,
    required this.imageUrls,
    required this.name,
    required this.bio,
    required this.email,
    this.strength = 1000,
  });

  User.blank()
      : city = '',
        latitude = 0,
        longitude = 0,
        imageUrls = [''],
        name = '',
        bio = 'bio',
        email = '',
        strength = 1000;

  User.fromJSON(data)
      : city = data['city'],
        latitude = data['latitude'],
        longitude = data['longitude'],
        imageUrls = List<String>.from(data['imageUrls']),
        name = data['name'],
        bio = data['bio'],
        email = data['email'],
        strength = data['strength'] ?? 1000;

  double _degreesToRadians(double degrees) {
    return degrees * pi / 180.0;
  }

  num _haversine(double radians) {
    return pow(sin(radians / 2), 2);
  }

  double distanceTo(User user2) {
    double lat1 = latitude;
    double lon1 = longitude;
    double lat2 = user2.latitude;
    double lon2 = user2.longitude;

    final dLat = _degreesToRadians(lat2 - lat1);
    final dLon = _degreesToRadians(lon2 - lon1);
    final a = _haversine(dLat) +
        cos(_degreesToRadians(lat1)) *
            cos(_degreesToRadians(lat2)) *
            _haversine(dLon);
    final c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return earthRadiusKm * c;
  }

  @override
  String toString() {
    return "User: $email - $name - $bio - $city";
  }
}
